import 'package:messeenger_flutter/models/user_model.dart';

class MessageModel {
  String id;
  String content;
  String type;
  String? deletedAt;

  UserModel createdBy;

  MessageModel({
    required this.id,
    required this.content,
    required this.type,
    required this.createdBy,
    required this.deletedAt,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      id: json['_id'],
      content: json['content'] ?? '',
      type: json['type'],
      createdBy: UserModel.fromJson(json['createdBy']),
      deletedAt: json['deletedAt'],
    );
  }
}
