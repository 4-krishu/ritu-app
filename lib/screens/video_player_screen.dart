import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String assetPath;

  const VideoPlayerScreen({super.key, required this.assetPath});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  Future<void> _downloadVideo() async {
    if (_downloading) return;

    setState(() => _downloading = true);

    try {
      final byteData = await rootBundle.load(widget.assetPath);

      final dir = await getExternalStorageDirectory();
      if (dir == null) throw Exception("Storage not available");

      final fileName =
          "memory_${DateTime.now().millisecondsSinceEpoch}.mp4";
      final file = File("${dir.path}/$fileName");

      await file.writeAsBytes(byteData.buffer.asUint8List());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Saved to storage 💖\n${file.path}"),
          backgroundColor: Colors.pinkAccent,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to save video"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() => _downloading = false);
    }
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
      body: Stack(
        children: [
          /// VIDEO
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(color: Colors.pink),
          ),

          /// TOP BUTTONS
          Positioned(
            top: 40,
            right: 16,
            child: Row(
              children: [
                /// DOWNLOAD
                IconButton(
                  icon: _downloading
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : const Icon(Icons.download_rounded,
                          color: Colors.white, size: 28),
                  onPressed: _downloading ? null : _downloadVideo,
                ),

                /// CLOSE / SKIP
                IconButton(
                  icon: const Icon(Icons.close,
                      color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
