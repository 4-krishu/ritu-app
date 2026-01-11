import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static const _morningKey = 'morning_enabled';
  static const _nightKey = 'night_enabled';

  static Future<void> setMorningEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_morningKey, value);
  }

  static Future<void> setNightEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_nightKey, value);
  }

  static Future<bool> isMorningEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_morningKey) ?? true;
  }

  static Future<bool> isNightEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_nightKey) ?? true;
  }
}
