import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'home_screen.dart';

class SpecialForBirthdayScreen extends StatefulWidget {
  const SpecialForBirthdayScreen({super.key});

  @override
  State<SpecialForBirthdayScreen> createState() =>
      _SpecialForBirthdayScreenState();
}

class _SpecialForBirthdayScreenState
    extends State<SpecialForBirthdayScreen> {
  VideoPlayerController? _controller;
  bool _showVideo = false;

  void _playSurprise() {
    setState(() => _showVideo = true);

    _controller = VideoPlayerController.asset(
      'assets/videos/surprise.mp4',
    )..initialize().then((_) {
        setState(() {});
        _controller!.play();

        _controller!.addListener(() {
          if (_controller!.value.isInitialized &&
              _controller!.value.position >=
                  _controller!.value.duration) {
            _goHome();
          }
        });
      });
  }

  void _goHome() {
    _controller?.pause();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/her2.jpg',
              fit: BoxFit.cover,
            ),
          ),

          /// BLUR
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.25)),
            ),
          ),

          /// CONTENT
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: _showVideo ? _buildVideo() : _buildMessage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🎂 MESSAGE SCREEN
  Widget _buildMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "🎂 Happy Birthday\nMy Baccha 💕",
          textAlign: TextAlign.center,
          style: GoogleFonts.dancingScript(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: Colors.pinkAccent,
          ),
        ),

        const SizedBox(height: 25),

        Text(
          "Today is not just your birthday.\n"
          "It’s the day my world became cuter.\n"
          "every moment with you is a treasure.\n"
          "every smile of yours brightens my day.\n"
          "i cherish you more than words can say.\n"
          "even more with each passing day.\n"
          "so, i made this app specially for you.\n"
          "i cant wait to create more beautiful memories with you.\n"
          "i love you so much baby 💖\n"
          "ummmmmaaaaaaaahhhhhhhhh...😘.",
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            color: const Color.fromARGB(237, 254, 254, 36),
          ),
        ),

        const SizedBox(height: 30),

        Text(
          "💖Watch a small surprise my baccha💖",
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
            fontSize: 17,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 30),

        GestureDetector(
          onTap: _playSurprise,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 6),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Text(
              "💝 View Surprise",
              style: GoogleFonts.quicksand(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🎥 VIDEO + SKIP BUTTON
  Widget _buildVideo() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.pink),
      );
    }

    return Stack(
      children: [
        /// FULL SCREEN VIDEO
        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),

        /// SKIP BUTTON
        Positioned(
          top: -10,
          right: -11,
          child: GestureDetector(
            onTap: _goHome,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 0, 0, 0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "✕",
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
