import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/models/chat_group_model.dart';
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
}
