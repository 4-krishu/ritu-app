import 'package:flutter/material.dart';

class SecretFileHomeScreen extends StatelessWidget {
  const SecretFileHomeScreen({super.key});

  static const List<String> _images = [
    "assets/secret/secret1.jpg",
    "assets/secret/secret2.jpg",
    "assets/secret/secret3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEF5),
      appBar: AppBar(
        title: const Text("Secret Files 💕"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: List.generate(
          _images.length,
          (index) => _SecretImage(
            path: _images[index],
            index: index,
            images: _images,
          ),
        ),
      ),
    );
  }
}

/// ---------------- GRID IMAGE ----------------

class _SecretImage extends StatelessWidget {
  final String path;
  final int index;
  final List<String> images;

  const _SecretImage({
    required this.path,
    required this.index,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _FullScreenViewer(
              images: images,
              initialIndex: index,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// ---------------- FULL SCREEN VIEWER ----------------

class _FullScreenViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<_FullScreenViewer> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          itemBuilder: (_, index) {
            return Center(
              child: Image.asset(
                widget.images[index],
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
