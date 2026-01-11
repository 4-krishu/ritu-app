import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'special_for_birthday.dart';


class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final String _correctPassword = "8825";
  String _input = "";

  void _tap(String n) {
    if (_input.length >= 4) return;

    setState(() => _input += n);

    if (_input == _correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SpecialForBirthdayScreen(),
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
          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/her.jpg',
              fit: BoxFit.cover,
            ),
          ),

          /// BLUR
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),

          /// CONTENT
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),

                /// TITLE
                Text(
                  "  💕Hello Bacchu💕",
                  style: GoogleFonts.dancingScript(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 214, 67, 109),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "You can open this my cutie",
                  style: GoogleFonts.quicksand(
                    fontSize: 21,
                    color: const Color.fromARGB(179, 255, 255, 255),
                  ),
                ),

                const SizedBox(height: 30),

                /// PASSWORD DOTS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < _input.length
                            ? Colors.white
                            : Colors.white38,
                      ),
                    );
                  }),
                ),

                const Spacer(),

                /// KEYPAD
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
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
                              .map((n) =>
                                  _Pink3DButton(text: n, onTap: _tap))
                              .toList(),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 80),
                          _Pink3DButton(text: "0", onTap: _tap),
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

/// 🌸 3D PINK BUTTON
class _Pink3DButton extends StatelessWidget {
  final String text;
  final Function(String) onTap;

  const _Pink3DButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFFC1D9),
          boxShadow: const [
            /// bottom shadow (depth)
            BoxShadow(
              color: Color(0xFFDB7FA8),
              offset: Offset(4, 6),
              blurRadius: 10,
            ),
            /// top highlight
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
          style: GoogleFonts.quicksand(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF7A294F),
          ),
        ),
      ),
    );
  }
}
