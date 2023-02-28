import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:messeenger_flutter/configs/http-config.dart';
import 'package:messeenger_flutter/models/user-model.dart';

class AuthService {
  static login(username, password) async {
    final response = await http
        .post(Uri.parse(HttpConfig.backendUrl + "auth?type=username"), body: {
      "username": username,
      "password": password,
    });

    if (response.statusCode != 200) {
      throw jsonDecode(response.body);
    }

    return jsonDecode(response.body);
  }

  static Future<UserModel> auth(token) async {
    final res =
        await http.get(Uri.parse(HttpConfig.backendUrl + 'auth'), headers: {
      'Authorization': 'Bearer $token'.toString(),
    });
    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(jsonDecode(res.body));
    }
  }
}
