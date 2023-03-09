// ignore_for_file: cast_from_null_always_fails

import 'package:messeenger_flutter/models/user_model.dart';

class MessageModel {
  String id;
  String content;
  String type;

  UserModel createdBy;

  MessageModel({
    required this.id,
    required this.content,
    required this.type,
    required this.createdBy,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      id: json['_id'],
      content: json['content'] ?? '',
      type: json['type'],
      createdBy: UserModel.fromJson(json['createdBy']),
    );
  }
}
