import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 4 Circles merging into one
          ...List.generate(4, (index) {
            final double beginX = (index % 2 == 0) ? -200 : 200;
            final double beginY = (index < 2) ? -200 : 200;
            return Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              )
                  .animate()
                  .move(
                begin: Offset(beginX, beginY),
                end: Offset.zero,
                duration: 1200.ms,
                curve: Curves.elasticOut,
              )
                  .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.5, 1.5),
                duration: 1200.ms,
              ),
            );
          }),

          // The circle turning white
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            )
                .animate(delay: 1200.ms)
                .fadeIn(duration: 300.ms)
                .scale(
              begin: const Offset(1, 1),
              end: const Offset(10, 10),
              duration: 800.ms,
              curve: Curves.easeInOutQuart,
            ),
          ),

          // Logo and Slogan
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/logo.png',
                  width: 180,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.timer, size: 120, color: AppColors.primaryDark),
                )
                    .animate(delay: 2000.ms)
                    .fadeIn(duration: 600.ms)
                    .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
                const SizedBox(height: 20),
                const Text(
                  'ready to target your focus',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                )
                    .animate(delay: 2400.ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.5, end: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
