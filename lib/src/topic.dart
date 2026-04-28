const String _topicPrefix = 'mrpc';

String requestTopic(String serviceName) {
  return '$_topicPrefix/request/$serviceName';
}

String responseTopic(String clientId) {
  return '$_topicPrefix/response/$clientId';
}

String eventTopic(String serviceName, String eventName) {
  return '$_topicPrefix/event/$serviceName/$eventName';
}
