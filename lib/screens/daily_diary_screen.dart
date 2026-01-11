import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/daily_entry.dart';

class DailyDiaryScreen extends StatefulWidget {
  const DailyDiaryScreen({super.key});

  @override
  State<DailyDiaryScreen> createState() => _DailyDiaryScreenState();
}

class _DailyDiaryScreenState extends State<DailyDiaryScreen> {
  late Box<DailyEntry> box;
  late String today;

  final morningCtrl = TextEditingController();
  final nightCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    box = Hive.box<DailyEntry>('daily_diary');
    today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final entry = box.get(today);
    if (entry != null) {
      morningCtrl.text = entry.morningText;
      nightCtrl.text = entry.nightText;
    }
  }

  void _save() {
    box.put(
      today,
      DailyEntry(
        date: today,
        morningText: morningCtrl.text.trim(),
        nightText: nightCtrl.text.trim(),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text('My Day 💖'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section('🌞 Morning Plan', morningCtrl),
              const SizedBox(height: 18),
              _section('🌙 Night Reflection', nightCtrl),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Save 💕'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          maxLines: 4,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
