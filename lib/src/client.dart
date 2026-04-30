import 'dart:async';
import 'dart:typed_data';

import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';

import 'codec.dart';
import 'errors.dart';
import 'topic.dart';

class CourierClientOptions {
  final String broker;
  final String clientId;
  final String? username;
  final String? password;
  final int timeout;
  final int retryCount;
  final int retryInterval;
  final double retryBackoff;
  final int keepAlive;
  final bool cleanSession;
  final int qos;

  CourierClientOptions({
    required this.broker,
    required this.clientId,
    this.username,
    this.password,
    this.timeout = 10000,
    this.retryCount = 0,
    this.retryInterval = 1000,
    this.retryBackoff = 1.5,
    this.keepAlive = 60,
    this.cleanSession = true,
    this.qos = 0,
  });
}

class _PendingCall {
  final Completer<Uint8List> completer;
  final Timer timer;
  Timer? retryTimer;

  _PendingCall(this.completer, this.timer);
}

class CourierClient {
  final String clientId;
  final CourierClientOptions _options;

  MqttServerClient? _mqttClient;
  final Map<String, _PendingCall> _pending = {};
  bool _closed = false;
  int _connectId = 0;

  final _connectedController = StreamController<void>.broadcast();
  final _disconnectedController = StreamController<void>.broadcast();
  final _errorController = StreamController<Exception>.broadcast();

  Stream<void> get onConnected => _connectedController.stream;
  Stream<void> get onDisconnected => _disconnectedController.stream;
  Stream<Exception> get onError => _errorController.stream;

  CourierClient(CourierClientOptions options)
      : _options = options,
        clientId = options.clientId;

  Future<void> connect() async {
    if (_closed) throw StateError('courier/rpc: client closed');
    if (_mqttClient != null) return;

    final broker = _options.broker;
    final uri = Uri.parse(broker);

    final isWebSocket =
        broker.startsWith('ws://') || broker.startsWith('wss://');

    final host = uri.host;
    final port = uri.port;

    // For WebSocket, the server param must be the full WS URL.
    // For TCP, it must be the hostname.
    final server = isWebSocket ? broker : host;
    final client = MqttServerClient.withPort(server, _options.clientId, port);

    client.logging(on: false);
    client.keepAlivePeriod = _options.keepAlive;
    client.autoReconnect = true;

    if (isWebSocket) {
      client.useWebSocket = true;
    }

    final connMsg = MqttConnectMessage()
        .withClientIdentifier(_options.clientId)
        .startClean();

    client.connectionMessage = connMsg;

    _connectId++;
    final myConnectId = _connectId;

    client.onConnected = () {
      if (_connectId != myConnectId) return;
      _connectedController.add(null);
    };

    client.onDisconnected = () {
      if (_connectId != myConnectId) return;
      _disconnectedController.add(null);
    };

    client.onAutoReconnect = () {
      if (_connectId != myConnectId) return;
      _connectedController.add(null);
    };

    _mqttClient = client;

    try {
      await client.connect(
        _options.username,
        _options.password,
      );
    } catch (e) {
      _mqttClient = null;
      throw transportError('connect failed: $e');
    }

    final status = client.connectionStatus;
    if (status == null || status.state != MqttConnectionState.connected) {
      _mqttClient = null;
      throw transportError(
        'connect failed: ${status?.state}',
      );
    }

    final respTopic = responseTopic(_options.clientId);
    client.subscribe(respTopic, MqttQos.values[_options.qos]);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>> messages) {
      for (final msg in messages) {
        try {
          final pubMsg = msg.payload as MqttPublishMessage;
          final bytes = Uint8List.fromList(pubMsg.payload.message?.toList() ?? []);
          _handleMessage(bytes);
        } catch (e) {
          _errorController.add(
            Exception('courier/rpc: message handling error: $e'),
          );
        }
      }
    });
  }

  Future<void> close() async {
    _closed = true;
    for (final call in _pending.values) {
      call.timer.cancel();
      call.retryTimer?.cancel();
      if (!call.completer.isCompleted) {
        call.completer.completeError(StateError('courier/rpc: client closed'));
      }
    }
    _pending.clear();

    final client = _mqttClient;
    _mqttClient = null;

    if (client != null) {
      client.disconnect();
    }

    await _connectedController.close();
    await _disconnectedController.close();
    await _errorController.close();
  }

  Future<Uint8List> call(
    String serviceName,
    int cmd,
    Uint8List payload,
  ) async {
    if (_closed) throw StateError('courier/rpc: client closed');
    final client = _mqttClient;
    if (client == null ||
        client.connectionStatus?.state != MqttConnectionState.connected) {
      throw StateError('courier/rpc: not connected');
    }

    final requestId = newRequestId();
    final requestHex = toHex(requestId);
    final reqTopic = requestTopic(serviceName);
    final frame = encodeRequest(cmd, requestId, null, payload);

    final completer = Completer<Uint8List>();
    final timer = Timer(Duration(milliseconds: _options.timeout), () {
      _pending.remove(requestHex);
      if (!completer.isCompleted) {
        completer.completeError(timeoutError(_options.timeout));
      }
    });

    final pendingCall = _PendingCall(completer, timer);
    _pending[requestHex] = pendingCall;

    _publish(client, reqTopic, frame);

    if (_options.retryCount > 0) {
      int attempts = 0;
      int interval = _options.retryInterval;
      pendingCall.retryTimer = Timer.periodic(
        Duration(milliseconds: interval),
        (t) {
          if (!_pending.containsKey(requestHex)) {
            t.cancel();
            return;
          }
          if (++attempts >= _options.retryCount) {
            t.cancel();
            return;
          }
          final c = _mqttClient;
          if (c != null &&
              c.connectionStatus?.state == MqttConnectionState.connected) {
            _publish(c, reqTopic, frame);
          }
          interval = (interval * _options.retryBackoff).round();
        },
      );
    }

    return completer.future;
  }

  void _publish(MqttServerClient client, String topic, Uint8List frame) {
    final builder = MqttPayloadBuilder();
    for (final b in frame) {
      builder.addByte(b);
    }
    client.publishMessage(topic, MqttQos.values[_options.qos], builder.payload!);
  }

  void _handleMessage(Uint8List data) {
    try {
      final resp = decodeResponse(data);
      final requestHex = toHex(resp.requestId);

      final call = _pending.remove(requestHex);
      if (call == null) return;

      call.timer.cancel();
      call.retryTimer?.cancel();

      if (resp.code != responseCodeOk) {
        final msg = String.fromCharCodes(resp.payload);
        if (!call.completer.isCompleted) {
          call.completer.completeError(CourierError(resp.code, msg));
        }
      } else {
        if (!call.completer.isCompleted) {
          call.completer.complete(resp.payload);
        }
      }
    } catch (e) {
      // malformed response frame, ignore
    }
  }
}
