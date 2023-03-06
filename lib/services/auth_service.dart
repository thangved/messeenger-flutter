import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:messeenger_flutter/configs/http_config.dart';
import 'package:messeenger_flutter/models/user_model.dart';
import 'package:messeenger_flutter/utils/client_util.dart';

class AuthService {
  static login(usernameOrEmail, password) async {
    final type =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(usernameOrEmail)
            ? "email"
            : "username";

    final response =
        await client.post('$baseUrl/auth?type=$type'.toUri(), body: {
      type: usernameOrEmail,
      'password': password,
    });

    if (response.statusCode != 200) {
      throw jsonDecode(response.body)['message'];
    }

    return jsonDecode(response.body);
  }

  static Future<UserModel> auth() async {
    final res = await client.get('$baseUrl/auth'.toUri());
    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(jsonDecode(res.body));
    }
  }

  static register({firstName, lastName, email, username, password}) async {
    final res = await client.post(
      '$baseUrl/auth/register'.toUri(),
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "username": username,
        "password": password,
      },
    );

    if (res.statusCode == 201) {
      return jsonDecode(res.body);
    }

    throw jsonDecode(res.body)['message'];
  }

  static resetPassword({email}) async {
    final res =
        await client.post('$baseUrl/auth/reset-password'.toUri(), body: {
      "email": email,
    });

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    throw jsonDecode(res.body)['message'];
  }
}
