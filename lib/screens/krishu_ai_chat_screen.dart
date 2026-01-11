import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'secret_file_password_screen.dart';

class KrishuAIChatScreen extends StatefulWidget {
  const KrishuAIChatScreen({super.key});

  @override
  State<KrishuAIChatScreen> createState() => _KrishuAIChatScreenState();
}

class _KrishuAIChatScreenState extends State<KrishuAIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _secretOpened = false;
  bool _aiTyping = false;

  final List<Map<String, String>> _messages = [
    {
      "from": "ai",
      "text":
          "Baccha maine ye tumhare liye banaya hai, jab mai baat na kar paun to yahan aa kar mere AI version se baat kar lena.\nYe bilkul mere jaise baat karega tumse 💖"
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final userText = _controller.text.trim();
    _controller.clear();

    setState(() {
      _messages.add({"from": "user", "text": userText});
      _aiTyping = true;
    });

    /// ⏳ Fake typing delay
    Timer(const Duration(milliseconds: 1200), () {
      setState(() {
        _aiTyping = false;
        _messages.add({
          "from": "ai",
          "text":
              "Baccha ye function avi under development hai, next update me isko fix kar dunga 💕"
        });
      });
    });
  }

  void _openVoiceChat() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFFFEEF5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mic_rounded,
                color: Colors.pinkAccent, size: 42),
            SizedBox(height: 12),
            Text(
              "Switching to voice chat 🎧",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A2C3A),
              ),
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 900), () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const _VoiceChatDummyScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌸 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/her.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🌸 BLUR + OVERLAY
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: const Color.fromARGB(255, 244, 40, 108).withOpacity(0.18),
              ),
            ),
          ),

          /// 🌸 MAIN UI
          GestureDetector(
            onScaleUpdate: (details) {
              /// 🔓 PINCH OUT → SECRET FILE
              if (details.scale > 1.15 && !_secretOpened) {
                _secretOpened = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SecretFilePasswordScreen(),
                  ),
                ).then((_) => _secretOpened = false);
              }
            },
            child: Column(
              children: [
                /// APP BAR
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Krishu AI 💖",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4A2C3A),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic_rounded,
                              color: Colors.pinkAccent),
                          onPressed: _openVoiceChat,
                        ),
                      ],
                    ),
                  ),
                ),

                /// CHAT LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        _messages.length + (_aiTyping ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (_aiTyping &&
                          index == _messages.length) {
                        return const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Krishu is typing...",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(179, 233, 8, 162),
                              ),
                            ),
                          ),
                        );
                      }

                      final msg = _messages[index];
                      final isUser = msg["from"] == "user";

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          constraints:
                              const BoxConstraints(maxWidth: 260),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.pinkAccent
                                : Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                          child: Text(
                            msg["text"]!,
                            style: TextStyle(
                              color: isUser
                                  ? Colors.white
                                  : const Color.fromARGB(255, 226, 62, 139),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// INPUT
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText:
                                "Type here baccha...",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send_rounded,
                            color: Colors.pinkAccent),
                        onPressed: _sendMessage,
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

/// 🎧 VOICE CHAT DUMMY
class _VoiceChatDummyScreen extends StatelessWidget {
  const _VoiceChatDummyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text("Voice Chat 🎧"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: const Center(
        child: Text(
          "Voice chat is under development 💕",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF4A2C3A),
          ),
        ),
      ),
    );
  }
}
