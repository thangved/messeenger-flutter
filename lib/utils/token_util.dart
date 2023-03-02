import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static const _accessTokenName = '@accessToken';

  static void setToken(token) async {
    (await _prefs).setString(_accessTokenName, token);
  }

  static getToken() async {
    return (await _prefs).getString(_accessTokenName);
  }

  static remove() async {
    (await _prefs).remove(_accessTokenName);
  }
}
