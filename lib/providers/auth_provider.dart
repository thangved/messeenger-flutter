import 'package:flutter/material.dart';
import 'package:messeenger_flutter/models/user_model.dart';
import 'package:messeenger_flutter/services/auth_service.dart';
import 'package:messeenger_flutter/utils/socket_util.dart';
import 'package:messeenger_flutter/utils/token_util.dart';

class AuthProvider with ChangeNotifier {
  bool _logged = false;
  bool _tested = false;

  UserModel _currentUser = UserModel(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    avatar: '',
    username: '',
    friend: false,
    requested: false,
  );

  UserModel get currentUser => _currentUser;

  bool get logged {
    if (_tested) return _logged;
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
      socket.emit('join', _currentUser.id);
      _logged = true;
    } finally {
      _tested = true;
    }
    notifyListeners();
  }
}
