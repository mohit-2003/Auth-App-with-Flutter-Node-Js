import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<bool> setString(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }
}
