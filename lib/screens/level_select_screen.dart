import 'package:flutter/material.dart';
import './level_devil/level_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text("Choose Level 💕"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (_, index) {
          final level = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LevelScreen(levelIndex: index),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFC1DA),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "$level",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A2C3A),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
