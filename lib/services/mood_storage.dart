import 'package:shared_preferences/shared_preferences.dart';

class MoodStorage {
  static const String _key = 'today_mood';

  static Future<void> saveMood(String moodId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, moodId);
  }

  static Future<String?> getMood() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
