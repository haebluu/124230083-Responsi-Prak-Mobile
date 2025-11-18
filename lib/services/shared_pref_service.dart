import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _sessionKey = 'sessionUsername';
  static const String _cartKey = 'cartProduct'; 
  static const String _profileImageKey = 'profileImagePath';

  Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, username);
  }

  Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionKey);
  }

  Future<void> deleteSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  Future<List<String>> getCart() async { 
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cartKey) ?? [];
  }

  Future<void> saveCart(List<String> cartJson) async { 
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_cartKey, cartJson);
  }

  Future<void> saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }
}