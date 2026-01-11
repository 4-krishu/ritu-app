import 'package:flutter/material.dart';

class Mood {
  final String id;
  final String label;
  final IconData icon;

  const Mood({
    required this.id,
    required this.label,
    required this.icon,
  });
}

const moods = [
  Mood(id: 'happy', label: 'Happy', icon: Icons.sentiment_satisfied_alt),
  Mood(id: 'calm', label: 'Calm', icon: Icons.self_improvement),
  Mood(id: 'low', label: 'Low', icon: Icons.sentiment_dissatisfied),
  Mood(id: 'angry', label: 'Angry', icon: Icons.sentiment_very_dissatisfied),
  Mood(id: 'tired', label: 'Tired', icon: Icons.bedtime),
];
