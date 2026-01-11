import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/daily_entry.dart';
import 'models/private_note.dart';

import 'screens/password_screen.dart';

import 'services/notification_service.dart';
import 'services/notification_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ---------------- HIVE INIT ----------------
  await Hive.initFlutter();

  Hive.registerAdapter(DailyEntryAdapter());
  Hive.registerAdapter(PrivateNoteAdapter());

  await Hive.openBox<DailyEntry>('daily_diary');
  await Hive.openBox<PrivateNote>('private_notes');

  // ---------------- NOTIFICATION INIT ----------------
  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ritu',
      navigatorKey: NotificationRouter.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const PasswordScreen(),
    );
  }
}
