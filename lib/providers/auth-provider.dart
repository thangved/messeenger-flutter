import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/user-model.dart';
import 'package:messeenger_flutter/services/auth-service.dart';
import 'package:messeenger_flutter/utils/token-util.dart';

class AuthProvider with ChangeNotifier {
  bool _logged = false;
  late UserModel _currentUser = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    avatar: '',
    username: '',
  );

  UserModel get currentUser => _currentUser;

  bool get logged {
    setCurrentUser();
    return _logged;
  }

  set accessToken(String newAccessToken) {
    TokenUtil.setToken(newAccessToken);
    setCurrentUser();
    notifyListeners();
  }

  void logout() {
    TokenUtil.remove();
    _logged = false;
    notifyListeners();
  }

  void setCurrentUser() async {
    try {
      _currentUser = await AuthService.auth();
      _logged = true;
    } catch (e) {}
    notifyListeners();
  }
}
