import 'dart:math';
import 'dart:typed_data';

import 'package:courier/courier.dart';
import 'package:courier/src/generated/chat.pb.dart';
import 'package:test/test.dart';

const String brokerUrl = 'ws://193.112.111.56:8083/mqtt';
const String serviceName = 'ChatService';
const String testUsername = 'dart_test_user';

String generateClientId() {
  final rng = Random();
  final suffix = List.generate(6, (_) => rng.nextInt(36).toRadixString(36)).join();
  return 'dart-test-$suffix';
}

CourierClient createClient({String? clientId}) {
  return CourierClient(CourierClientOptions(
    broker: brokerUrl,
    clientId: clientId ?? generateClientId(),
    timeout: 10000,
  ));
}

void main() {
  group('CourierClient Integration Tests', () {
    late CourierClient client;
    late String clientId;

    setUp(() async {
      clientId = generateClientId();
      client = CourierClient(CourierClientOptions(
        broker: brokerUrl,
        clientId: clientId,
        timeout: 10000,
      ));
      await client.connect();
    });

    tearDown(() async {
      await client.close();
    });

    test('connect and disconnect', () async {
      // Already connected in setUp
      expect(client.clientId, isNotNull);
      expect(client.clientId, isNotEmpty);
    });

    test('Login', () async {
      final req = LoginRequest()
        ..clientId = clientId
        ..username = '$testUsername-${DateTime.now().millisecondsSinceEpoch}';

      final respBytes = await client.call(serviceName, 1001, req.writeToBuffer());
      final resp = LoginResponse.fromBuffer(respBytes);

      expect(resp.success, isTrue);
      expect(resp.userId, isNotEmpty);
    });

    test('Login and ListRooms', () async {
      // Login first
      final loginReq = LoginRequest()
        ..clientId = clientId
        ..username = '$testUsername-${DateTime.now().millisecondsSinceEpoch}';
      final loginBytes = await client.call(serviceName, 1001, loginReq.writeToBuffer());
      final loginResp = LoginResponse.fromBuffer(loginBytes);
      expect(loginResp.success, isTrue);

      // List rooms
      final listReq = ListRoomsRequest()..clientId = clientId;
      final listBytes = await client.call(serviceName, 1005, listReq.writeToBuffer());
      final listResp = ListRoomsResponse.fromBuffer(listBytes);

      expect(listResp.rooms, isNotNull);
      expect(listResp.rooms, isNotEmpty);
    });

    test('Login, JoinRoom, SendMessage, GetMessages, LeaveRoom', () async {
      final username = '$testUsername-${DateTime.now().millisecondsSinceEpoch}';

      // Login
      final loginReq = LoginRequest()
        ..clientId = clientId
        ..username = username;
      final loginBytes = await client.call(serviceName, 1001, loginReq.writeToBuffer());
      final loginResp = LoginResponse.fromBuffer(loginBytes);
      expect(loginResp.success, isTrue);

      // List rooms to find one
      final listReq = ListRoomsRequest()..clientId = clientId;
      final listBytes = await client.call(serviceName, 1005, listReq.writeToBuffer());
      final listResp = ListRoomsResponse.fromBuffer(listBytes);
      expect(listResp.rooms, isNotEmpty);

      final roomId = listResp.rooms.first.id;

      // Join room
      final joinReq = JoinRoomRequest()
        ..clientId = clientId
        ..roomId = roomId;
      final joinBytes = await client.call(serviceName, 1006, joinReq.writeToBuffer());
      final joinResp = JoinRoomResponse.fromBuffer(joinBytes);
      expect(joinResp.success, isTrue);

      // Send message
      final sendReq = SendMessageRequest()
        ..clientId = clientId
        ..roomId = roomId
        ..content = 'Hello from Dart courier client!';
      final sendBytes = await client.call(serviceName, 1003, sendReq.writeToBuffer());
      final sendResp = SendMessageResponse.fromBuffer(sendBytes);
      expect(sendResp.success, isTrue);
      expect(sendResp.messageId, isNotEmpty);

      // Get messages
      final getMsgReq = GetMessagesRequest()
        ..clientId = clientId
        ..roomId = roomId
        ..limit = 10;
      final getMsgBytes = await client.call(serviceName, 1004, getMsgReq.writeToBuffer());
      final getMsgResp = GetMessagesResponse.fromBuffer(getMsgBytes);
      expect(getMsgResp.messages, isNotEmpty);

      // Verify our message is in the list
      final ourMessage = getMsgResp.messages.where(
        (m) => m.content == 'Hello from Dart courier client!',
      );
      expect(ourMessage, isNotEmpty);

      // Leave room
      final leaveReq = LeaveRoomRequest()
        ..clientId = clientId
        ..roomId = roomId;
      final leaveBytes = await client.call(serviceName, 1007, leaveReq.writeToBuffer());
      final leaveResp = LeaveRoomResponse.fromBuffer(leaveBytes);
      expect(leaveResp.success, isTrue);

      // Logout
      final logoutReq = LogoutRequest()..clientId = clientId;
      final logoutBytes = await client.call(serviceName, 1002, logoutReq.writeToBuffer());
      final logoutResp = LogoutResponse.fromBuffer(logoutBytes);
      expect(logoutResp.success, isTrue);
    });

    test('call on closed client throws', () async {
      await client.close();
      expect(
        () => client.call(serviceName, 1001, Uint8List(0)),
        throwsA(isA<StateError>()),
      );
    });

    test('timeout on very short timeout', () async {
      final quickClient = CourierClient(CourierClientOptions(
        broker: brokerUrl,
        clientId: generateClientId(),
        timeout: 1, // 1ms - will definitely timeout
      ));
      await quickClient.connect();

      try {
        final req = LoginRequest()
          ..clientId = quickClient.clientId
          ..username = 'timeout-test';
        await quickClient.call(serviceName, 1001, req.writeToBuffer());
        fail('Should have timed out');
      } catch (e) {
        expect(e, isA<CourierError>());
        expect((e as CourierError).code, equals(408));
      } finally {
        await quickClient.close();
      }
    });
  });
}
