import 'dart:typed_data';

import 'package:courier/src/codec.dart';
import 'package:test/test.dart';

void main() {
  group('encodeRequest / decodeRequest', () {
    test('round-trip without extensions', () {
      final requestId = Uint8List.fromList(List.generate(16, (i) => i + 1));
      final payload = Uint8List.fromList([0x0A, 0x06, 0x68, 0x65, 0x6C, 0x6C, 0x6F, 0x21]);

      final frame = encodeRequest(1001, requestId, null, payload);
      expect(frame.length, equals(28 + payload.length));

      // Verify header fields
      final buf = ByteData.sublistView(frame);
      expect(buf.getUint32(0, Endian.big), equals(frame.length)); // length
      expect(buf.getUint16(4, Endian.big), equals(1)); // version
      expect(buf.getUint32(6, Endian.big), equals(1001)); // cmd
      expect(buf.getUint16(26, Endian.big), equals(0)); // extLen

      // Verify payload
      final decoded = decodeRequest(frame);
      expect(decoded.cmd, equals(1001));
      expect(decoded.version, equals(1));
      expect(decoded.requestId, equals(requestId));
      expect(decoded.extensionsLen, equals(0));
      expect(decoded.extensions.length, equals(0));
      expect(decoded.payload, equals(payload));
    });

    test('round-trip with extensions', () {
      final requestId = Uint8List.fromList(List.generate(16, (i) => i));
      final extensions = Uint8List.fromList([1, 2, 3, 4, 5]);
      final payload = Uint8List.fromList([0xDE, 0xAD, 0xBE, 0xEF]);

      final frame = encodeRequest(2002, requestId, extensions, payload);
      expect(frame.length, equals(28 + extensions.length + payload.length));

      final decoded = decodeRequest(frame);
      expect(decoded.cmd, equals(2002));
      expect(decoded.extensions, equals(extensions));
      expect(decoded.payload, equals(payload));
    });

    test('empty payload', () {
      final requestId = Uint8List(16);
      final payload = Uint8List(0);

      final frame = encodeRequest(100, requestId, null, payload);
      expect(frame.length, equals(28));

      final decoded = decodeRequest(frame);
      expect(decoded.payload.length, equals(0));
    });

    test('frame too short throws', () {
      expect(
        () => decodeRequest(Uint8List(10)),
        throwsA(isA<StateError>()),
      );
    });

    test('truncated frame throws', () {
      final requestId = Uint8List(16);
      final payload = Uint8List.fromList([1, 2, 3]);
      final frame = encodeRequest(100, requestId, null, payload);

      expect(
        () => decodeRequest(Uint8List.sublistView(frame, 0, 30)),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('decodeResponse', () {
    test('success response', () {
      final requestId = Uint8List.fromList(List.generate(16, (i) => i + 10));
      final payload = Uint8List.fromList([0x08, 0x01]);

      // Manually build response: length(4) + requestId(16) + code(2) + payload
      final length = 22 + payload.length;
      final buf = ByteData(length);
      buf.setUint32(0, length, Endian.big);
      buf.buffer.asUint8List().setRange(4, 20, requestId);
      buf.setUint16(20, 0, Endian.big); // code = OK
      buf.buffer.asUint8List().setRange(22, length, payload);

      final resp = decodeResponse(buf.buffer.asUint8List());
      expect(resp.code, equals(0));
      expect(resp.requestId, equals(requestId));
      expect(resp.payload, equals(payload));
    });

    test('error response', () {
      final requestId = Uint8List(16);
      final errorMsg = Uint8List.fromList('server error'.codeUnits);

      final length = 22 + errorMsg.length;
      final buf = ByteData(length);
      buf.setUint32(0, length, Endian.big);
      buf.buffer.asUint8List().setRange(4, 20, requestId);
      buf.setUint16(20, 500, Endian.big); // code = 500
      buf.buffer.asUint8List().setRange(22, length, errorMsg);

      final resp = decodeResponse(buf.buffer.asUint8List());
      expect(resp.code, equals(500));
      expect(String.fromCharCodes(resp.payload), equals('server error'));
    });

    test('response too short throws', () {
      expect(
        () => decodeResponse(Uint8List(10)),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('newRequestId', () {
    test('generates 16 bytes', () {
      final id = newRequestId();
      expect(id.length, equals(16));
    });

    test('generates unique IDs', () {
      final ids = Set<String>();
      for (var i = 0; i < 100; i++) {
        ids.add(toHex(newRequestId()));
      }
      expect(ids.length, equals(100));
    });
  });

  group('toHex', () {
    test('converts bytes to hex', () {
      expect(toHex(Uint8List.fromList([0x0A, 0xFF, 0x00, 0x01])), equals('0aff0001'));
    });
  });
}
