import 'package:flutter/material.dart';

class KrishuAIChatScreen extends StatefulWidget {
  const KrishuAIChatScreen({super.key});

  @override
  State<KrishuAIChatScreen> createState() => _KrishuAIChatScreenState();
}

class _KrishuAIChatScreenState extends State<KrishuAIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "from": "ai",
      "text":
          "Baccha maine ye tumhare liye banaya hai, jab mai baat na kar paun to yahan aa kar mere AI version se baat kar lena.\nYe bilkul mere jaise baat karega tumse 💖"
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({"from": "user", "text": _controller.text.trim()});
      _messages.add({
        "from": "ai",
        "text":
            "Baccha ye function avi under development hai, next update me isko fix kar dunga 💕"
      });
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text("Krishu AI 💖"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final msg = _messages[index];
                final isUser = msg["from"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    constraints:
                        const BoxConstraints(maxWidth: 260),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.pinkAccent
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : const Color(0xFF4A2C3A),
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
                      hintText: "Type here baccha...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
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
    );
  }
}
