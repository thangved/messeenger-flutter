import 'dart:convert';

import 'package:http_interceptor/extensions/extensions.dart';
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/models/user_model.dart';
import 'package:messeenger_flutter/utils/client_util.dart';

class UserService {
  static Future<List<UserModel>> search(String searchText) async {
    final response =
        await client.get('$baseUrl/users/search?q=$searchText'.toUri());

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<UserModel>((item) {
        return UserModel.fromJson(item);
      }).toList();
    }

    throw jsonDecode(response.body);
  }
}
