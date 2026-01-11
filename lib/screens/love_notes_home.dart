import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/private_note.dart';
import 'daily_diary_screen.dart';

class LoveNotesHomeScreen extends StatelessWidget {
  const LoveNotesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE4EE),
      appBar: AppBar(
        title: const Text("Love Notes 💖"),
        backgroundColor: const Color(0xFFFFC1DA),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _SectionCard(
              title: "Daily Diary 📖",
              subtitle: "Morning & Night thoughts",
              buttonText: "Write today",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DailyDiaryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 22),
            _SectionCard(
              title: "Private Notes 💌",
              subtitle: "Your personal feelings",
              buttonText: "Add note",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivateNoteWriteScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A2C3A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7A4A5C),
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- PRIVATE NOTE WRITE ----------------

class PrivateNoteWriteScreen extends StatefulWidget {
  const PrivateNoteWriteScreen({super.key});

  @override
  State<PrivateNoteWriteScreen> createState() =>
      _PrivateNoteWriteScreenState();
}

class _PrivateNoteWriteScreenState extends State<PrivateNoteWriteScreen> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  void _saveNote() {
    final title = titleCtrl.text.trim();
    final content = contentCtrl.text.trim();

    if (title.isEmpty && content.isEmpty) return;

    final box = Hive.box<PrivateNote>('private_note');

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    box.put(
      id,
      PrivateNote(
        id: id,
        title: title,
        content: content,
        createdAt: DateTime.now(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved 💖"),
        backgroundColor: Colors.pinkAccent,
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
        title: const Text("Private Note 💗"),
        backgroundColor: const Color(0xFFFFC1DA),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              TextField(
                controller: titleCtrl,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: "Headline",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: TextField(
                  controller: contentCtrl,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Write your private note here...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Save 💕"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
