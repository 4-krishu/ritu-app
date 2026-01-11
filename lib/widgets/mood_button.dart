import 'package:flutter/material.dart';
import '../models/mood.dart';

class MoodButton extends StatelessWidget {
  final Mood mood;
  final VoidCallback onTap;

  const MoodButton({
    super.key,
    required this.mood,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(mood.icon, size: 32, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              mood.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
