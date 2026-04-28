import 'dart:math';
import 'dart:typed_data';

const int protocolVersion = 1;
const int requestHeaderLen = 28;
const int responseHeaderLen = 22;
const int responseCodeOk = 0;

void _writeUint32BE(ByteData buf, int offset, int value) {
  buf.setUint32(offset, value, Endian.big);
}

void _writeUint16BE(ByteData buf, int offset, int value) {
  buf.setUint16(offset, value, Endian.big);
}

int _readUint32BE(ByteData buf, int offset) {
  return buf.getUint32(offset, Endian.big);
}

int _readUint16BE(ByteData buf, int offset) {
  return buf.getUint16(offset, Endian.big);
}

Uint8List encodeRequest(
  int cmd,
  Uint8List requestId,
  Uint8List? extensions,
  Uint8List payload,
) {
  final extLen = extensions?.length ?? 0;
  final length = requestHeaderLen + extLen + payload.length;
  final buf = ByteData(length);

  _writeUint32BE(buf, 0, length);
  _writeUint16BE(buf, 4, protocolVersion);
  _writeUint32BE(buf, 6, cmd);
  buf.buffer.asUint8List().setRange(10, 26, requestId);
  _writeUint16BE(buf, 26, extLen);

  int offset = requestHeaderLen;
  if (extLen > 0 && extensions != null) {
    buf.buffer.asUint8List().setRange(offset, offset + extLen, extensions);
    offset += extLen;
  }
  buf.buffer.asUint8List().setRange(offset, offset + payload.length, payload);

  return buf.buffer.asUint8List();
}

class ResponseFrame {
  final Uint8List requestId;
  final int code;
  final Uint8List payload;

  ResponseFrame({
    required this.requestId,
    required this.code,
    required this.payload,
  });
}

ResponseFrame decodeResponse(Uint8List data) {
  if (data.length < responseHeaderLen) {
    throw StateError(
      'courier/codec: response frame too short (${data.length} < $responseHeaderLen)',
    );
  }

  final buf = ByteData.sublistView(data);
  final length = _readUint32BE(buf, 0);
  final requestId = Uint8List.sublistView(data, 4, 20);
  final code = _readUint16BE(buf, 20);
  final payload = Uint8List.sublistView(data, 22, length);

  return ResponseFrame(requestId: requestId, code: code, payload: payload);
}

class RequestFrame {
  final int length;
  final int version;
  final int cmd;
  final Uint8List requestId;
  final int extensionsLen;
  final Uint8List extensions;
  final Uint8List payload;

  RequestFrame({
    required this.length,
    required this.version,
    required this.cmd,
    required this.requestId,
    required this.extensionsLen,
    required this.extensions,
    required this.payload,
  });
}

RequestFrame decodeRequest(Uint8List data) {
  if (data.length < requestHeaderLen) {
    throw StateError(
      'courier/codec: request frame too short (${data.length} < $requestHeaderLen)',
    );
  }

  final buf = ByteData.sublistView(data);
  final length = _readUint32BE(buf, 0);
  if (data.length < length) {
    throw StateError(
      'courier/codec: truncated request frame (have ${data.length}, need $length)',
    );
  }

  final version = _readUint16BE(buf, 4);
  final cmd = _readUint32BE(buf, 6);
  final requestId = Uint8List.sublistView(data, 10, 26);
  final extensionsLen = _readUint16BE(buf, 26);

  Uint8List extensions = Uint8List(0);
  int payloadOffset = requestHeaderLen;
  if (extensionsLen > 0) {
    extensions = Uint8List.sublistView(
      data,
      requestHeaderLen,
      requestHeaderLen + extensionsLen,
    );
    payloadOffset += extensionsLen;
  }
  final payload = Uint8List.sublistView(data, payloadOffset, length);

  return RequestFrame(
    length: length,
    version: version,
    cmd: cmd,
    requestId: requestId,
    extensionsLen: extensionsLen,
    extensions: extensions,
    payload: payload,
  );
}

Uint8List newRequestId() {
  final rng = Random.secure();
  return Uint8List.fromList(List.generate(16, (_) => rng.nextInt(256)));
}

String toHex(Uint8List bytes) {
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
