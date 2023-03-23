import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/models/message_model.dart';
import 'package:messeenger_flutter/utils/client_util.dart';

class MessageService {
  static sendMessage({
    String content = '',
    String url = '',
    required String groupId,
    String type = "text",
  }) async {
    final res = await client.post(
      '$baseUrl/messages'.toUri(),
      body: {
        'content': content,
        'url': url,
        'groupId': groupId,
        'type': type,
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    throw jsonDecode(res.body)['message'];
  }

  static Future<MessageModel> getMessage(String messageId) async {
    final res = await client.get('$baseUrl/messages/$messageId'.toUri());

    if (res.statusCode == 200) {
      return MessageModel.fromJson(jsonDecode(res.body));
    }

    throw jsonDecode(res.body)['message'];
  }
}
