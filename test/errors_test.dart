import 'package:courier/src/errors.dart';
import 'package:test/test.dart';

void main() {
  test('timeoutError has code 408', () {
    final err = timeoutError(5000);
    expect(err.code, equals(408));
    expect(err.message, contains('5000'));
  });

  test('cancelError has code 499', () {
    final err = cancelError();
    expect(err.code, equals(499));
  });

  test('transportError has code 503', () {
    final err = transportError('connection lost');
    expect(err.code, equals(503));
    expect(err.message, contains('connection lost'));
  });

  test('CourierError toString format', () {
    final err = CourierError(400, 'bad request');
    expect(err.toString(), contains('code=400'));
    expect(err.toString(), contains('bad request'));
  });
}
