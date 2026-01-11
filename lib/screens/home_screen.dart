import 'package:flutter/material.dart';

import 'private_safe_password.dart';
import 'love_notes_home.dart';
import 'memories_screen.dart';
import 'krishu_ai_chat_screen.dart';
import 'level_devil_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _safeOpened = false;

  void _showSecretDialog() {
  showDialog(
    context: context,
    builder: (_) {
      bool showError = false;

      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: const Color(0xFFFFEEF5),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "🔒 Secret Message",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A2C3A),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "This message will open\n"
                  "after our first meet up 💞\n\n"
                  "Need Krishu's fingerprint",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7A4A5C),
                  ),
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    // show error
                    setDialogState(() {
                      showError = true;
                    });

                    // hide after 0.8 sec
                    Future.delayed(
                      const Duration(milliseconds: 800),
                      () {
                        if (context.mounted) {
                          setDialogState(() {
                            showError = false;
                          });
                        }
                      },
                    );
                  },
                  child: const Icon(
                    Icons.fingerprint_rounded,
                    size: 44,
                    color: Colors.pinkAccent,
                  ),
                ),

                const SizedBox(height: 6),

                if (showError)
                  const Text(
                    "Fingerprint doesn't match ❌",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.pinkAccent,
                    ),
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}


  void _showComingSoon() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: const Color(0xFFFFEEF5),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, color: Colors.pinkAccent, size: 36),
            SizedBox(height: 10),
            Text(
              "Coming Soon 💖",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A2C3A),
              ),
            ),
            SizedBox(height: 6),
            Text(
              "This feature is under development 🧸",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF7A4A5C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onScaleUpdate: (details) {
          if (details.scale < 0.8 && !_safeOpened) {
            _safeOpened = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivateSafePasswordScreen(),
              ),
            ).then((_) => _safeOpened = false);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC1DA),
                Color(0xFFFFE4EE),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      "Hi Pookie ❤️",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A2C3A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "I made this just for you",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7A4A5C),
                      ),
                    ),

                    const SizedBox(height: 28),

                    _BannerCard(
                      image: "lib/assets/banners/banner_love.png",
                      icon: Icons.favorite_rounded,
                      title: "Love Note",
                      subtitle: "Something sweet for you",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LoveNotesHomeScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    _BannerCard(
                      image: "lib/assets/banners/banner_memory.png",
                      icon: Icons.photo_camera_rounded,
                      title: "Memories",
                      subtitle: "Little moments we share",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MemoriesScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    _BannerCard(
                      image: "lib/assets/banners/banner_birthday.png",
                      icon: Icons.lock_rounded,
                      title: "Secret Message",
                      subtitle: "Locked for now 🔒",
                      onTap: _showSecretDialog,
                    ),

                    const SizedBox(height: 30),

                    /// CHAT WITH KRISHU AI
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const KrishuAIChatScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 26),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius:
                              BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat_bubble_rounded,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Chat with Krishu AI 💖",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// 🔹 APPS GRID (3 + 6)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        children: [
                          // Games
                          _MiniApp(
                            label: "Level Devil",
                            icon: Icons.videogame_asset_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const LevelDevilHome(),
                                ),
                              );
                            },
                          ),
                          _MiniApp(
                            label: "Subway Run",
                            icon: Icons.train_rounded,
                            onTap: _showComingSoon,
                          ),
                          _MiniApp(
                            label: "Candy Pop",
                            icon: Icons.cake_rounded,
                            onTap: _showComingSoon,
                          ),

                          // Love apps
                          _MiniApp(
                            label: "Love Letters",
                            icon: Icons.mail_rounded,
                            onTap: _showComingSoon,
                          ),
                          _MiniApp(
                            label: "Our Promises",
                            icon: Icons.handshake_rounded,
                            onTap: _showComingSoon,
                          ),
                          _MiniApp(
                            label: "Mood Tracker",
                            icon: Icons.mood_rounded,
                            onTap: _showComingSoon,
                          ),
                          _MiniApp(
                            label: "Sweet Reminders",
                            icon: Icons.alarm_rounded,
                            onTap: _showComingSoon,
                          ),
                          _MiniApp(
                            label: "Heart Vault",
                            icon: Icons.security_rounded,
                            onTap: _showComingSoon,
                          ),
                          _MiniApp(
                            label: "Forever Us",
                            icon: Icons.favorite_rounded,
                            onTap: _showComingSoon,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "Made with 🩷",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7A4A5C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------- MINI APP ---------------- */

class _MiniApp extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MiniApp({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD6E8),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFB03060),
              size: 30,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7A4A5C),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- BANNER CARD ---------------- */

class _BannerCard extends StatelessWidget {
  final String image;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BannerCard({
    required this.image,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.75),
                  Colors.white.withOpacity(0.25),
                ],
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFFFFD6E8),
                  child: Icon(icon,
                      color: const Color(0xFFB03060)),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A2C3A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7A4A5C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
