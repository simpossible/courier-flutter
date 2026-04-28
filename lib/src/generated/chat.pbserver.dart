//
//  Generated code. Do not modify.
//  source: chat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'chat.pb.dart' as $0;
import 'chat.pbjson.dart';

export 'chat.pb.dart';

abstract class ChatServiceBase extends $pb.GeneratedService {
  $async.Future<$0.LoginResponse> login($pb.ServerContext ctx, $0.LoginRequest request);
  $async.Future<$0.LogoutResponse> logout($pb.ServerContext ctx, $0.LogoutRequest request);
  $async.Future<$0.SendMessageResponse> sendMessage($pb.ServerContext ctx, $0.SendMessageRequest request);
  $async.Future<$0.GetMessagesResponse> getMessages($pb.ServerContext ctx, $0.GetMessagesRequest request);
  $async.Future<$0.ListRoomsResponse> listRooms($pb.ServerContext ctx, $0.ListRoomsRequest request);
  $async.Future<$0.JoinRoomResponse> joinRoom($pb.ServerContext ctx, $0.JoinRoomRequest request);
  $async.Future<$0.LeaveRoomResponse> leaveRoom($pb.ServerContext ctx, $0.LeaveRoomRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Login': return $0.LoginRequest();
      case 'Logout': return $0.LogoutRequest();
      case 'SendMessage': return $0.SendMessageRequest();
      case 'GetMessages': return $0.GetMessagesRequest();
      case 'ListRooms': return $0.ListRoomsRequest();
      case 'JoinRoom': return $0.JoinRoomRequest();
      case 'LeaveRoom': return $0.LeaveRoomRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Login': return this.login(ctx, request as $0.LoginRequest);
      case 'Logout': return this.logout(ctx, request as $0.LogoutRequest);
      case 'SendMessage': return this.sendMessage(ctx, request as $0.SendMessageRequest);
      case 'GetMessages': return this.getMessages(ctx, request as $0.GetMessagesRequest);
      case 'ListRooms': return this.listRooms(ctx, request as $0.ListRoomsRequest);
      case 'JoinRoom': return this.joinRoom(ctx, request as $0.JoinRoomRequest);
      case 'LeaveRoom': return this.leaveRoom(ctx, request as $0.LeaveRoomRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ChatServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => ChatServiceBase$messageJson;
}

