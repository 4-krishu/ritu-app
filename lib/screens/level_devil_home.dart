import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'level_select_screen.dart';

class LevelDevilHome extends StatefulWidget {
  const LevelDevilHome({super.key});

  @override
  State<LevelDevilHome> createState() => _LevelDevilHomeState();
}

class _LevelDevilHomeState extends State<LevelDevilHome> {
  @override
  void initState() {
    super.initState();

    // 🔒 LOCK ENTIRE LEVEL DEVIL MODULE TO LANDSCAPE
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // 🔓 UNLOCK WHEN EXIT GAME MODULE
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.videogame_asset_rounded,
              size: 90,
              color: Colors.pinkAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              "Level Devil 😈💗",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A2C3A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Cute game. Evil lies.",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF7A4A5C),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LevelSelectScreen(),
                  ),
                );
              },
              child: const Text(
                "START GAME 💗",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
