import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showText = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => showText = true);
    });

    Future.delayed(const Duration(seconds: 2), () {
      // zatím jen přechod na testovací home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                scale: 1,
                child: const Icon(
                  Icons.restaurant,
                  size: 120,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AnimatedOpacity(
                opacity: showText ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'CheckFood',
                  style: AppTypography.display.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TempHome extends StatelessWidget {
  const _TempHome();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home placeholder')));
  }
}
