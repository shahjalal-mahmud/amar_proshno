import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE1D5F5), // light lavender top
              Color(0xFFCFBEF0), // slightly deeper mid
              Color(0xFFBFA8E8), // deeper purple bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Brain + gears illustration area
              SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer faint ring
                    Container(
                      width: 210,
                      height: 210,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF9575CD).withValues(alpha: 0.12),
                      ),
                    ),
                    // Inner ring
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF9575CD).withValues(alpha: 0.15),
                      ),
                    ),
                    // Icon stack
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Gears row
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.settings_rounded,
                              size: 28,
                              color: const Color(0xFF7E57C2).withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.settings_rounded,
                              size: 20,
                              color: const Color(0xFF7E57C2).withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Brain icon
                        Icon(
                          Icons.psychology_rounded,
                          size: 64,
                          color: const Color(0xFF6A3FA6).withValues(alpha: 0.75),
                        ),
                        const SizedBox(height: 6),
                        // Wings / sparkle row
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 22,
                              color: const Color(0xFF7E57C2).withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 18,
                              color: const Color(0xFF7E57C2).withValues(alpha: 0.45),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // QUIZ title
              const Text(
                'QUIZ',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5E35B1),
                  letterSpacing: 6,
                ),
              ),

              const Spacer(flex: 2),

              // START button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, anim, __) => const QuizScreen(),
                          transitionsBuilder: (_, anim, __, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration: const Duration(milliseconds: 350),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9575CD),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'START',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}