//
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use loginRequestDescriptor instead')
const LoginRequest$json = {
  '1': 'LoginRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `LoginRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginRequestDescriptor = $convert.base64Decode(
    'CgxMb2dpblJlcXVlc3QSGwoJY2xpZW50X2lkGAEgASgJUghjbGllbnRJZBIaCgh1c2VybmFtZR'
    'gCIAEoCVIIdXNlcm5hbWU=');

@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = {
  '1': 'LoginResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode(
    'Cg1Mb2dpblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSFwoHdXNlcl9pZBgCIA'
    'EoCVIGdXNlcklkEhQKBWVycm9yGAMgASgJUgVlcnJvcg==');

@$core.Deprecated('Use logoutRequestDescriptor instead')
const LogoutRequest$json = {
  '1': 'LogoutRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
  ],
};

/// Descriptor for `LogoutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutRequestDescriptor = $convert.base64Decode(
    'Cg1Mb2dvdXRSZXF1ZXN0EhsKCWNsaWVudF9pZBgBIAEoCVIIY2xpZW50SWQ=');

@$core.Deprecated('Use logoutResponseDescriptor instead')
const LogoutResponse$json = {
  '1': 'LogoutResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `LogoutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logoutResponseDescriptor = $convert.base64Decode(
    'Cg5Mb2dvdXRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNz');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'content', '3': 3, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSGwoJY2xpZW50X2lkGAEgASgJUghjbGllbnRJZBIXCgdyb2'
    '9tX2lkGAIgASgJUgZyb29tSWQSGAoHY29udGVudBgDIAEoCVIHY29udGVudA==');

@$core.Deprecated('Use sendMessageResponseDescriptor instead')
const SendMessageResponse$json = {
  '1': 'SendMessageResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message_id', '3': 2, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `SendMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageResponseDescriptor = $convert.base64Decode(
    'ChNTZW5kTWVzc2FnZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSHQoKbWVzc2'
    'FnZV9pZBgCIAEoCVIJbWVzc2FnZUlkEhQKBWVycm9yGAMgASgJUgVlcnJvcg==');

@$core.Deprecated('Use chatMessageDescriptor instead')
const ChatMessage$json = {
  '1': 'ChatMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'room_id', '3': 4, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'content', '3': 5, '4': 1, '5': 9, '10': 'content'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ChatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMessageDescriptor = $convert.base64Decode(
    'CgtDaGF0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh'
    'oKCHVzZXJuYW1lGAMgASgJUgh1c2VybmFtZRIXCgdyb29tX2lkGAQgASgJUgZyb29tSWQSGAoH'
    'Y29udGVudBgFIAEoCVIHY29udGVudBIcCgl0aW1lc3RhbXAYBiABKANSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use getMessagesRequestDescriptor instead')
const GetMessagesRequest$json = {
  '1': 'GetMessagesRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZXNzYWdlc1JlcXVlc3QSGwoJY2xpZW50X2lkGAEgASgJUghjbGllbnRJZBIXCgdyb2'
    '9tX2lkGAIgASgJUgZyb29tSWQSFAoFbGltaXQYAyABKAVSBWxpbWl0');

@$core.Deprecated('Use getMessagesResponseDescriptor instead')
const GetMessagesResponse$json = {
  '1': 'GetMessagesResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.chat.ChatMessage', '10': 'messages'},
  ],
};

/// Descriptor for `GetMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZXNzYWdlc1Jlc3BvbnNlEi0KCG1lc3NhZ2VzGAEgAygLMhEuY2hhdC5DaGF0TWVzc2'
    'FnZVIIbWVzc2FnZXM=');

@$core.Deprecated('Use listRoomsRequestDescriptor instead')
const ListRoomsRequest$json = {
  '1': 'ListRoomsRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
  ],
};

/// Descriptor for `ListRoomsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomsRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0Um9vbXNSZXF1ZXN0EhsKCWNsaWVudF9pZBgBIAEoCVIIY2xpZW50SWQ=');

@$core.Deprecated('Use roomInfoDescriptor instead')
const RoomInfo$json = {
  '1': 'RoomInfo',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'member_count', '3': 2, '4': 1, '5': 5, '10': 'memberCount'},
  ],
};

/// Descriptor for `RoomInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomInfoDescriptor = $convert.base64Decode(
    'CghSb29tSW5mbxIOCgJpZBgBIAEoCVICaWQSIQoMbWVtYmVyX2NvdW50GAIgASgFUgttZW1iZX'
    'JDb3VudA==');

@$core.Deprecated('Use listRoomsResponseDescriptor instead')
const ListRoomsResponse$json = {
  '1': 'ListRoomsResponse',
  '2': [
    {'1': 'rooms', '3': 1, '4': 3, '5': 11, '6': '.chat.RoomInfo', '10': 'rooms'},
  ],
};

/// Descriptor for `ListRoomsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0Um9vbXNSZXNwb25zZRIkCgVyb29tcxgBIAMoCzIOLmNoYXQuUm9vbUluZm9SBXJvb2'
    '1z');

@$core.Deprecated('Use joinRoomRequestDescriptor instead')
const JoinRoomRequest$json = {
  '1': 'JoinRoomRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `JoinRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRoomRequestDescriptor = $convert.base64Decode(
    'Cg9Kb2luUm9vbVJlcXVlc3QSGwoJY2xpZW50X2lkGAEgASgJUghjbGllbnRJZBIXCgdyb29tX2'
    'lkGAIgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use joinRoomResponseDescriptor instead')
const JoinRoomResponse$json = {
  '1': 'JoinRoomResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'recent_messages', '3': 2, '4': 3, '5': 11, '6': '.chat.ChatMessage', '10': 'recentMessages'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `JoinRoomResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRoomResponseDescriptor = $convert.base64Decode(
    'ChBKb2luUm9vbVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSOgoPcmVjZW50X2'
    '1lc3NhZ2VzGAIgAygLMhEuY2hhdC5DaGF0TWVzc2FnZVIOcmVjZW50TWVzc2FnZXMSFAoFZXJy'
    'b3IYAyABKAlSBWVycm9y');

@$core.Deprecated('Use leaveRoomRequestDescriptor instead')
const LeaveRoomRequest$json = {
  '1': 'LeaveRoomRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `LeaveRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveRoomRequestDescriptor = $convert.base64Decode(
    'ChBMZWF2ZVJvb21SZXF1ZXN0EhsKCWNsaWVudF9pZBgBIAEoCVIIY2xpZW50SWQSFwoHcm9vbV'
    '9pZBgCIAEoCVIGcm9vbUlk');

@$core.Deprecated('Use leaveRoomResponseDescriptor instead')
const LeaveRoomResponse$json = {
  '1': 'LeaveRoomResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `LeaveRoomResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveRoomResponseDescriptor = $convert.base64Decode(
    'ChFMZWF2ZVJvb21SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhQKBWVycm9yGA'
    'IgASgJUgVlcnJvcg==');

@$core.Deprecated('Use newMessageEventDescriptor instead')
const NewMessageEvent$json = {
  '1': 'NewMessageEvent',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.chat.ChatMessage', '10': 'message'},
  ],
};

/// Descriptor for `NewMessageEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newMessageEventDescriptor = $convert.base64Decode(
    'Cg9OZXdNZXNzYWdlRXZlbnQSKwoHbWVzc2FnZRgBIAEoCzIRLmNoYXQuQ2hhdE1lc3NhZ2VSB2'
    '1lc3NhZ2U=');

@$core.Deprecated('Use userEventDescriptor instead')
const UserEvent$json = {
  '1': 'UserEvent',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'room_id', '3': 3, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `UserEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userEventDescriptor = $convert.base64Decode(
    'CglVc2VyRXZlbnQSGwoJY2xpZW50X2lkGAEgASgJUghjbGllbnRJZBIaCgh1c2VybmFtZRgCIA'
    'EoCVIIdXNlcm5hbWUSFwoHcm9vbV9pZBgDIAEoCVIGcm9vbUlk');

const $core.Map<$core.String, $core.dynamic> ChatServiceBase$json = {
  '1': 'ChatService',
  '2': [
    {'1': 'Login', '2': '.chat.LoginRequest', '3': '.chat.LoginResponse', '4': {}},
    {'1': 'Logout', '2': '.chat.LogoutRequest', '3': '.chat.LogoutResponse', '4': {}},
    {'1': 'SendMessage', '2': '.chat.SendMessageRequest', '3': '.chat.SendMessageResponse', '4': {}},
    {'1': 'GetMessages', '2': '.chat.GetMessagesRequest', '3': '.chat.GetMessagesResponse', '4': {}},
    {'1': 'ListRooms', '2': '.chat.ListRoomsRequest', '3': '.chat.ListRoomsResponse', '4': {}},
    {'1': 'JoinRoom', '2': '.chat.JoinRoomRequest', '3': '.chat.JoinRoomResponse', '4': {}},
    {'1': 'LeaveRoom', '2': '.chat.LeaveRoomRequest', '3': '.chat.LeaveRoomResponse', '4': {}},
  ],
};

@$core.Deprecated('Use chatServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> ChatServiceBase$messageJson = {
  '.chat.LoginRequest': LoginRequest$json,
  '.chat.LoginResponse': LoginResponse$json,
  '.chat.LogoutRequest': LogoutRequest$json,
  '.chat.LogoutResponse': LogoutResponse$json,
  '.chat.SendMessageRequest': SendMessageRequest$json,
  '.chat.SendMessageResponse': SendMessageResponse$json,
  '.chat.GetMessagesRequest': GetMessagesRequest$json,
  '.chat.GetMessagesResponse': GetMessagesResponse$json,
  '.chat.ChatMessage': ChatMessage$json,
  '.chat.ListRoomsRequest': ListRoomsRequest$json,
  '.chat.ListRoomsResponse': ListRoomsResponse$json,
  '.chat.RoomInfo': RoomInfo$json,
  '.chat.JoinRoomRequest': JoinRoomRequest$json,
  '.chat.JoinRoomResponse': JoinRoomResponse$json,
  '.chat.LeaveRoomRequest': LeaveRoomRequest$json,
  '.chat.LeaveRoomResponse': LeaveRoomResponse$json,
};

/// Descriptor for `ChatService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List chatServiceDescriptor = $convert.base64Decode(
    'CgtDaGF0U2VydmljZRI3CgVMb2dpbhISLmNoYXQuTG9naW5SZXF1ZXN0GhMuY2hhdC5Mb2dpbl'
    'Jlc3BvbnNlIgWItRjpBxI6CgZMb2dvdXQSEy5jaGF0LkxvZ291dFJlcXVlc3QaFC5jaGF0Lkxv'
    'Z291dFJlc3BvbnNlIgWItRjqBxJJCgtTZW5kTWVzc2FnZRIYLmNoYXQuU2VuZE1lc3NhZ2VSZX'
    'F1ZXN0GhkuY2hhdC5TZW5kTWVzc2FnZVJlc3BvbnNlIgWItRjrBxJJCgtHZXRNZXNzYWdlcxIY'
    'LmNoYXQuR2V0TWVzc2FnZXNSZXF1ZXN0GhkuY2hhdC5HZXRNZXNzYWdlc1Jlc3BvbnNlIgWItR'
    'jsBxJDCglMaXN0Um9vbXMSFi5jaGF0Lkxpc3RSb29tc1JlcXVlc3QaFy5jaGF0Lkxpc3RSb29t'
    'c1Jlc3BvbnNlIgWItRjtBxJACghKb2luUm9vbRIVLmNoYXQuSm9pblJvb21SZXF1ZXN0GhYuY2'
    'hhdC5Kb2luUm9vbVJlc3BvbnNlIgWItRjuBxJDCglMZWF2ZVJvb20SFi5jaGF0LkxlYXZlUm9v'
    'bVJlcXVlc3QaFy5jaGF0LkxlYXZlUm9vbVJlc3BvbnNlIgWItRjvBw==');

