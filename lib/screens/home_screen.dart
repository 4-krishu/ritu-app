import 'package:flutter/material.dart';

import 'private_safe_password.dart';
import 'love_notes_home.dart';
import 'memories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _safeOpened = false;

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
            ).then((_) {
              _safeOpened = false;
            });
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

                /// LOVE NOTES
                _BannerCard(
                  image: "lib/assets/banners/banner_love.png",
                  icon: Icons.favorite_rounded,
                  title: "Love Note",
                  subtitle: "Something sweet for you",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoveNotesHomeScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 18),

                /// MEMORIES (ASSET VIDEOS)
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

                /// BIRTHDAY (LOCKED)
                const _BannerCard(
                  image: "lib/assets/banners/banner_birthday.png",
                  icon: Icons.cake_rounded,
                  title: "Birthday Surprise",
                  subtitle: "Locked for now 🎀",
                  locked: true,
                ),

                const Spacer(),

                const Text(
                  "Made with 🩷",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7A4A5C),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final String image;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool locked;
  final VoidCallback? onTap;

  const _BannerCard({
    required this.image,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.locked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: locked ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.35),
                blurRadius: 18,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.6),
                blurRadius: 6,
                offset: const Offset(-2, -2),
              ),
            ],
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
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
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
                  child: Icon(
                    locked ? Icons.lock_rounded : icon,
                    color: const Color(0xFFB03060),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
