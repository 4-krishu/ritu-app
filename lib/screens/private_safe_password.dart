import 'package:flutter/material.dart';
import 'private_safe_home.dart';

class PrivateSafePasswordScreen extends StatefulWidget {
  const PrivateSafePasswordScreen({super.key});

  @override
  State<PrivateSafePasswordScreen> createState() =>
      _PrivateSafePasswordScreenState();
}

class _PrivateSafePasswordScreenState
    extends State<PrivateSafePasswordScreen> {
  static const String _correctPassword = "276436";
  String _input = "";

  void _onKeyTap(String value) {
    if (_input.length >= 6) return;

    setState(() {
      _input += value;
    });

    if (_input.length == 6 && _input == _correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PrivateSafeHomeScreen(),
        ),
      );
    }
  }

  void _delete() {
    if (_input.isEmpty) return;
    setState(() {
      _input = _input.substring(0, _input.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Private Safe 🔒",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A2C3A),
              ),
            ),
            const SizedBox(height: 30),

            /// DOTS
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
                        ? Colors.pinkAccent
                        : Colors.pink.shade200,
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
                          .map((n) => _KeyButton(n, _onKeyTap))
                          .toList(),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 70),
                      _KeyButton("0", _onKeyTap),
                      IconButton(
                        icon: const Icon(Icons.backspace_rounded),
                        onPressed: _delete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String text;
  final Function(String) onTap;

  const _KeyButton(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.pinkAccent,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
