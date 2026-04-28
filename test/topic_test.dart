import 'package:courier/src/topic.dart';
import 'package:test/test.dart';

void main() {
  test('requestTopic', () {
    expect(requestTopic('ChatService'), equals('mrpc/request/ChatService'));
  });

  test('responseTopic', () {
    expect(responseTopic('client-001'), equals('mrpc/response/client-001'));
  });

  test('eventTopic', () {
    expect(
      eventTopic('ChatService', 'NewMessage'),
      equals('mrpc/event/ChatService/NewMessage'),
    );
  });
}
