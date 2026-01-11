import 'package:flutter/material.dart';
import 'video_player_screen.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  // 🔒 FIXED ASSET VIDEOS
  static const List<String> videos = [
    'assets/videos/memory1.mp4',
    'assets/videos/memory2.mp4',
    'assets/videos/memory3.mp4',
    'assets/videos/memory4.mp4',
    'assets/videos/memory5.mp4',
    'assets/videos/memory6.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE4EE),
      appBar: AppBar(
        title: const Text("Memories 💞"),
        backgroundColor: const Color(0xFFFFC1DA),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: videos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerScreen(
                      assetPath: videos[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: 56,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
