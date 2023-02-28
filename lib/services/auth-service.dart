import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:messeenger_flutter/configs/http-config.dart';

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
}
