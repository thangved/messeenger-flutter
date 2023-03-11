import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/models/chat_group_model.dart';
import 'package:messeenger_flutter/models/message_model.dart';
import 'package:messeenger_flutter/utils/client_util.dart';

class ChatGroupService {
  static Future<List<ChatGroupModel>> getAll() async {
    final response = await client.get('$baseUrl/groups'.toUri());

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<ChatGroupModel>((json) {
        return ChatGroupModel.fromJson(json);
      }).toList();
    }

    throw jsonDecode(response.body);
  }

  static Future<ChatGroupModel> getById(String? chatId) async {
    final res = await client.get('$baseUrl/groups/$chatId'.toUri());

    if (res.statusCode == 200) {
      return ChatGroupModel.fromJson(jsonDecode(res.body));
    }

    throw jsonDecode(res.body)['message'];
  }

  static Future<List<MessageModel>> getAllMessages(String chatId) async {
    final res = await client.get('$baseUrl/groups/$chatId/messages'.toUri());

    if (res.statusCode == 200) {
      return jsonDecode(res.body).map<MessageModel>((json) {
        return MessageModel.fromJson(json);
      }).toList();
    }

    throw jsonDecode(res.body)['message'];
  }
}
