import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/user-model.dart';
import 'package:messeenger_flutter/services/auth-service.dart';

class AuthProvider with ChangeNotifier {
  bool _logged = false;
  String _accessToken = "";
  late UserModel _currentUser = UserModel(
      firstName: '', lastName: '', email: '', avatar: '', username: '');

  UserModel get currentUser => _currentUser;

  bool get logged => _logged;

  String get accessToken => _accessToken;

  void set accessToken(String newAccessToken) {
    this._accessToken = newAccessToken;
    this._logged = true;
    this.setCurrentUser();
    notifyListeners();
  }

  void logout() {
    this._accessToken = "";
    this._logged = false;
    notifyListeners();
  }

  void setCurrentUser() async {
    UserModel currentUser = await AuthService.auth(_accessToken);
    _currentUser = currentUser;
  }
}
