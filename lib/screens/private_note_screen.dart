import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/private_note.dart';

class PrivateNoteScreen extends StatefulWidget {
  const PrivateNoteScreen({super.key});

  @override
  State<PrivateNoteScreen> createState() => _PrivateNoteScreenState();
}

class _PrivateNoteScreenState extends State<PrivateNoteScreen> {
  late Box<PrivateNote> box;

  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    box = Hive.box<PrivateNote>('private_notes');
  }

  void _saveNote() {
    if (contentCtrl.text.trim().isEmpty) return;

    final note = PrivateNote(
      id: const Uuid().v4(),
      title: titleCtrl.text.trim(),
      content: contentCtrl.text.trim(),
      createdAt: DateTime.now(),
    );

    box.put(note.id, note);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text("Private Note 💗"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                hintText: "Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: contentCtrl,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Write your private note here...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: const Text(
                "Save 💕",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
