import 'dart:ui';
import 'package:flutter/material.dart';
import 'secret_file_home_screen.dart';

class SecretFilePasswordScreen extends StatefulWidget {
  const SecretFilePasswordScreen({super.key});

  @override
  State<SecretFilePasswordScreen> createState() =>
      _SecretFilePasswordScreenState();
}

class _SecretFilePasswordScreenState
    extends State<SecretFilePasswordScreen> {
  final String _correctPassword = "276436";
  String _input = "";

  void _tap(String n) {
    if (_input.length >= 6) return;

    setState(() => _input += n);

    if (_input == _correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SecretFileHomeScreen(),
        ),
      );
    }
  }

  void _delete() {
    if (_input.isEmpty) return;
    setState(() => _input = _input.substring(0, _input.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌸 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/her.png", // same image you already use
              fit: BoxFit.cover,
            ),
          ),

          /// 🌸 BLUR + PINK OVERLAY
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                color: Colors.pinkAccent.withOpacity(0.18),
              ),
            ),
          ),

          /// 🌸 CONTENT
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),

                /// TITLE
                const Text(
                  "🔐 Secret Files",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFB03060),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Only for my pookie 💕",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30),

                /// PASSWORD DOTS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < _input.length
                            ? Colors.white
                            : Colors.white38,
                        boxShadow: i < _input.length
                            ? [
                                const BoxShadow(
                                  color: Colors.pinkAccent,
                                  blurRadius: 6,
                                )
                              ]
                            : [],
                      ),
                    );
                  }),
                ),

                const Spacer(),

                /// KEYPAD
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    children: [
                      for (var row in [
                        ["1", "2", "3"],
                        ["4", "5", "6"],
                        ["7", "8", "9"],
                      ])
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: row
                              .map(
                                (n) => _PookieButton(
                                  text: n,
                                  onTap: _tap,
                                ),
                              )
                              .toList(),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 70),
                          _PookieButton(text: "0", onTap: _tap),
                          IconButton(
                            onPressed: _delete,
                            icon: const Icon(
                              Icons.backspace_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🌸 PINK POOKIE BUTTON
class _PookieButton extends StatelessWidget {
  final String text;
  final Function(String) onTap;

  const _PookieButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFFC1DA),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFDB7FA8),
              offset: Offset(4, 6),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white54,
              offset: Offset(-4, -4),
              blurRadius: 8,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7A294F),
          ),
        ),
      ),
    );
  }
}
