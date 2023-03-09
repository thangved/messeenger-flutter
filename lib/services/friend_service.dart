import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/models/user_model.dart';
import 'package:messeenger_flutter/utils/client_util.dart';

class FriendService {
  static requestAddFriend(userId) async {
    final res = await client.post('$baseUrl/friends/$userId'.toUri());

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }

  static void acceptAddFriend(userId) async {
    final res = await client.put('$baseUrl/friends/$userId'.toUri());

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }

  static removeFriend(userId) async {
    final res = await client.delete('$baseUrl/friends/$userId'.toUri());

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }

  static Future<List<UserModel>> getAllFriends() async {
    final res = await client.get('$baseUrl/friends'.toUri());

    if (res.statusCode == 200) {
      return jsonDecode(res.body).map<UserModel>((json) {
        return UserModel.fromJson(json);
      }).toList();
    }

    throw jsonDecode(res.body)['message'];
  }

  static Future<List<UserModel>> getAllRequests() async {
    final res = await client.get('$baseUrl/friends/request'.toUri());

    if (res.statusCode == 200) {
      return jsonDecode(res.body).map<UserModel>((json) {
        return UserModel.fromJson(json);
      }).toList();
    }

    throw jsonDecode(res.body)['message'];
  }

  static Future<List<UserModel>> getAllMyRequests() async {
    final res = await client.get('$baseUrl/friends/my-request'.toUri());

    if (res.statusCode == 200) {
      return jsonDecode(res.body).map<UserModel>((json) {
        return UserModel.fromJson(json);
      }).toList();
    }

    throw jsonDecode(res.body)['message'];
  }
}
