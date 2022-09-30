import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Future<SharedPreferences> _getPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setToken(String token) async {
    final pref = await _getPreference();
    pref.setString('token', token);
  }

  Future<String?> getToken() async {
    final pref = await _getPreference();
    final token = pref.getString('token');
    return token;
  }

  Future<void> logout() async {
    final pref = await _getPreference();
    await pref.remove('token');
    await pref.reload();
  }
}
