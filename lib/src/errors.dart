const int _timeoutCode = 408;
const int _cancelCode = 499;
const int _transportCode = 503;

class CourierError implements Exception {
  final int code;
  final String message;

  CourierError(this.code, this.message);

  @override
  String toString() => 'courier/rpc: code=$code msg=$message';
}

CourierError timeoutError(int timeout) {
  return CourierError(_timeoutCode, 'request timed out after ${timeout}ms');
}

CourierError cancelError() {
  return CourierError(_cancelCode, 'request canceled');
}

CourierError transportError(String reason) {
  return CourierError(_transportCode, reason);
}
