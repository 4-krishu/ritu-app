import 'dart:async';
import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  final int levelIndex;
  const LevelScreen({super.key, required this.levelIndex});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  // player position
  double playerX = -0.8;
  double playerY = 0.6;

  double velocityY = 0;
  bool isJumping = false;

  bool started = false;
  bool dead = false;
  bool win = false;

  Timer? loop;

  static const gravity = 0.015;
  static const jumpForce = -0.28;

  @override
  void initState() {
    super.initState();
    _startLoop();
  }

  void _startLoop() {
    loop = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!started || dead || win) return;

      setState(() {
        velocityY += gravity;
        playerY += velocityY;

        // ground (left platform)
        if (playerX < -0.1 && playerY >= 0.6) {
          playerY = 0.6;
          velocityY = 0;
          isJumping = false;
        }

        // ground (right platform)
        if (playerX > 0.2 && playerY >= 0.6) {
          playerY = 0.6;
          velocityY = 0;
          isJumping = false;
        }

        // fall into gap
        if (playerY > 1.2) {
          _die();
        }
      });
    });
  }

  void move(double dx) {
    if (!started || dead || win) return;

    setState(() {
      playerX += dx;

      // check win
      if (playerX > 0.75 && playerY <= 0.6) {
        win = true;
      }
    });
  }

  void jump() {
    if (!started || dead || isJumping || win) return;

    velocityY = jumpForce;
    isJumping = true;
  }

  void _die() {
    setState(() {
      dead = true;
    });
  }

  void restart() {
    setState(() {
      playerX = -0.8;
      playerY = 0.6;
      velocityY = 0;
      isJumping = false;
      dead = false;
      win = false;
      started = false;
    });
  }

  @override
  void dispose() {
    loop?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!started) {
          setState(() => started = true);
        } else if (dead) {
          restart();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFEEF5),
        body: Stack(
          children: [
            /// LEFT GROUND
            Align(
              alignment: const Alignment(-0.55, 0.9),
              child: Container(
                width: 220,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            /// RIGHT GROUND
            Align(
              alignment: const Alignment(0.65, 0.9),
              child: Container(
                width: 220,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            /// KRISHU (GOAL)
            const Align(
              alignment: Alignment(0.85, 0.45),
              child: Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: 40,
              ),
            ),

            /// PLAYER
            AnimatedAlign(
              duration: const Duration(milliseconds: 60),
              alignment: Alignment(playerX, playerY),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            /// CONTROLS
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  _btn(Icons.arrow_left_rounded, () => move(-0.06)),
                  const SizedBox(width: 14),
                  _btn(Icons.arrow_right_rounded, () => move(0.06)),
                ],
              ),
            ),

            Positioned(
              bottom: 20,
              right: 20,
              child: _btn(Icons.arrow_upward_rounded, jump, big: true),
            ),

            /// START OVERLAY
            if (!started)
              _overlay(
                "You have to reach Krishu 💗",
                "Tap anywhere to start",
              ),

            /// DEATH OVERLAY
            if (dead)
              _overlay(
                "Oops baby 💔",
                "Tap anywhere to restart",
              ),

            /// WIN OVERLAY
            if (win)
              _overlay(
                "You reached Krishu 💖",
                "Level Complete",
              ),
          ],
        ),
      ),
    );
  }

  Widget _overlay(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF7A4A5C),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap, {bool big = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: big ? 64 : 54,
        height: big ? 64 : 54,
        decoration: BoxDecoration(
          color: const Color(0xFFFFC1DA),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFB03060),
          size: big ? 30 : 26,
        ),
      ),
    );
  }
}
