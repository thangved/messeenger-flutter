import 'package:messeenger_flutter/models/user_model.dart';

class MessageModel {
  String id;
  String content;
  String type;
  DateTime createdAt;
  UserModel createdBy;

  DateTime? deletedAt;
  String? url;

  MessageModel({
    required this.id,
    required this.content,
    required this.type,
    required this.createdBy,
    required this.createdAt,
    this.deletedAt,
    this.url,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      id: json['_id'],
      content: json['content'] ?? '',
      type: json['type'],
      createdBy: UserModel.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      url: json['url'],
    );
  }
}
