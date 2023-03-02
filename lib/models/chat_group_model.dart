import 'package:messeenger_flutter/models/message_model.dart';

class ChatGroupModel {
  String id;
  String type;
  String avatar;
  String name;

  MessageModel lastMessage;

  ChatGroupModel({
    required this.id,
    required this.type,
    required this.avatar,
    required this.name,
    required this.lastMessage,
  });

  factory ChatGroupModel.fromJson(Map<String, dynamic> json) {
    return ChatGroupModel(
      id: json['_id'],
      type: json['type'],
      avatar: json.containsKey('avatar') ? json['avatar'] : "",
      name: json['name'],
      lastMessage: MessageModel.fromJson(json['lastMessage']),
    );
  }
}
