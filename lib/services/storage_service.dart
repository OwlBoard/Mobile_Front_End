import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyToken = 'token';
  static const String _keyEmail = 'email';

  // Save user data
  static Future<void> saveUserData({
    String? userId,
    String? userName,
    String? token,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (userId != null) await prefs.setString(_keyUserId, userId);
    if (userName != null) await prefs.setString(_keyUserName, userName);
    if (token != null) await prefs.setString(_keyToken, token);
    if (email != null) await prefs.setString(_keyEmail, email);
  }

  // Get user ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // Get email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null && userId.isNotEmpty;
  }

  // Clear all user data (logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyToken);
    await prefs.remove(_keyEmail);
  }

  // Get all user data at once
  static Future<Map<String, String?>> getAllUserData() async {
    return {
      'userId': await getUserId(),
      'userName': await getUserName(),
      'token': await getToken(),
      'email': await getEmail(),
    };
  }
}
