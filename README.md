# courier

Dart Courier RPC client library, wire-compatible with the Go [courier](https://github.com/simpossible/courier) framework.

Courier is a lightweight RPC framework built on MQTT + Protobuf with a custom binary frame protocol. This library lets Dart/Flutter applications communicate with Go courier servers.

## Install

Add to your `pubspec.yaml`:

```yaml
dependencies:
  courier:
    git:
      url: https://github.com/simpossible/courier-flutter.git
```

Or for local development:

```yaml
dependencies:
  courier:
    path: ../courier-flutter
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:courier/courier.dart';

void main() async {
  final client = CourierClient(CourierClientOptions(
    broker: 'ws://localhost:8083/mqtt',
    clientId: 'my-app-client',
    timeout: 10000,
  ));

  await client.connect();

  // Send an RPC call (cmd=1001, payload is protobuf-encoded)
  final response = await client.call('ChatService', 1001, payload);
  await client.close();
}
```

### With Protobuf

```dart
import 'package:courier/courier.dart';
import 'package:your_package/generated/chat.pb.dart';

void main() async {
  final client = CourierClient(CourierClientOptions(
    broker: 'ws://localhost:8083/mqtt',
    clientId: 'dart-client-001',
  ));

  await client.connect();

  // Login
  final loginReq = LoginRequest()
    ..clientId = client.clientId
    ..username = 'alice';
  final loginResp = LoginResponse.fromBuffer(
    await client.call('ChatService', 1001, loginReq.writeToBuffer()),
  );
  print('Logged in: ${loginResp.success}');

  // Send a message
  final sendReq = SendMessageRequest()
    ..clientId = client.clientId
    ..roomId = 'general'
    ..content = 'Hello from Dart!';
  final sendResp = SendMessageResponse.fromBuffer(
    await client.call('ChatService', 1003, sendReq.writeToBuffer()),
  );
  print('Message sent: ${sendResp.messageId}');

  await client.close();
}
```

## API

### CourierClientOptions

| Option | Type | Default | Description |
|---|---|---|---|
| `broker` | `String` | required | MQTT broker URL (`ws://`, `wss://`, `tcp://`) |
| `clientId` | `String` | required | MQTT ClientID, used for response routing |
| `username` | `String?` | `null` | MQTT auth username |
| `password` | `String?` | `null` | MQTT auth password |
| `timeout` | `int` | `10000` | Request timeout in ms |
| `retryCount` | `int` | `0` | Number of retries (0 = no retry) |
| `retryInterval` | `int` | `1000` | Initial retry interval in ms |
| `retryBackoff` | `double` | `1.5` | Retry backoff multiplier |
| `keepAlive` | `int` | `60` | MQTT keep-alive in seconds |
| `cleanSession` | `bool` | `true` | MQTT clean session |
| `qos` | `int` | `0` | MQTT QoS level (0, 1, or 2) |

### CourierClient

```dart
final client = CourierClient(options);
```

#### Methods

- **`connect()`** — Connect to broker and subscribe to response topic
- **`call(serviceName, cmd, payload)`** — Send RPC request and wait for response
- **`close()`** — Disconnect and reject all pending requests

#### Streams

```dart
client.onConnected.listen(() { /* ... */ });
client.onDisconnected.listen(() { /* ... */ });
client.onError.listen((err) { /* ... */ });
```

### Errors

```dart
try {
  await client.call('ChatService', 1001, payload);
} on CourierError catch (e) {
  print('code=${e.code}, message=${e.message}');
}
```

Error codes:
- `408` — Request timeout
- `499` — Request canceled
- `503` — Transport error

### Topic Helpers

```dart
import 'package:courier/courier.dart';

requestTopic('ChatService');                    // mrpc/request/ChatService
responseTopic('client-001');                    // mrpc/response/client-001
eventTopic('ChatService', 'NewMessage');        // mrpc/event/ChatService/NewMessage
```

## Protocol

The binary frame protocol is identical to Go and JavaScript courier clients:

**Request Frame** (client → server, 28B header + payload):
```
[4B length BE][2B version=1][4B cmd BE][16B requestID][2B extLen][ext...][payload...]
```

**Response Frame** (server → client, 22B header + payload):
```
[4B length BE][16B requestID][2B code BE][payload...]
```

**MQTT Topics**:
- Request: `mrpc/request/{serviceName}`
- Response: `mrpc/response/{clientId}`
- Event: `mrpc/event/{serviceName}/{eventName}`

## Code Generation

Generate Dart protobuf classes from your `.proto` file:

```bash
protoc --dart_out=lib/src/generated your_service.proto
```

Your `.proto` file must annotate each RPC method with a `cmd` number:

```protobuf
import "options/options.proto";

service ChatService {
  rpc Login(LoginRequest) returns (LoginResponse) {
    option (courier.cmd) = 1001;
  }
}
```

Then call using the generated types:

```dart
final req = LoginRequest()..username = 'alice';
final resp = LoginResponse.fromBuffer(
  await client.call('ChatService', 1001, req.writeToBuffer()),
);
```

## Development

```bash
dart pub get
dart analyze
dart test
```

## License

MIT
