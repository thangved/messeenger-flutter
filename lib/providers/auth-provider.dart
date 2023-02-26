import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _logged = false;
  String _accessToken = "";

  bool get logged => _logged;

  String get accessToken => _accessToken;

  void set accessToken(String newAccessToken) {
    this._accessToken = newAccessToken;
    this._logged = true;
    notifyListeners();
  }
}
