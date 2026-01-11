import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(settings);
  }

  /// Call this AFTER app UI loads (NOT in main)
  static Future<void> scheduleDiaryNotifications() async {
    // ❗ Android 12+ alarm restriction protection
    if (Platform.isAndroid) {
      try {
        const androidDetails = AndroidNotificationDetails(
          'daily_diary',
          'Daily Diary',
          channelDescription: 'Morning and Night diary reminders',
          importance: Importance.high,
          priority: Priority.high,
        );

        const details = NotificationDetails(android: androidDetails);

        // Morning reminder
        await _notifications.show(
          101,
          'Good morning baccha 🌸',
          'aaj ka kya plan hai?',
          details,
        );

        // Night reminder
        await _notifications.show(
          102,
          'Good night baccha 🌙',
          'aaj kya kya hua?',
          details,
        );
      } catch (e) {
        // 🚫 DO NOTHING — never crash the app
        return;
      }
    }
  }
}
