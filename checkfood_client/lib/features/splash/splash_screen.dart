import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../navigation/main_shell.dart';
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/auth/auth_state.dart';
import '../onboarding/onboarding_screen.dart';
import '../../security/presentation/pages/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final AnimationController _taglineController;
  late final AnimationController _shimmerController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _textSlide;
  late final Animation<double> _textOpacity;
  late final Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    // Logo: scale up + fade in (0ms -> 800ms)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoScale = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );
    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    // Text "CheckFood": slide up + fade in (400ms -> 1000ms)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
    _textOpacity = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // Tagline: fade in (800ms -> 1400ms)
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = CurvedAnimation(
      parent: _taglineController,
      curve: Curves.easeIn,
    );

    // Shimmer on logo (continuous subtle pulse)
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    _taglineController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // Wait for animations to finish
        await Future.delayed(const Duration(milliseconds: 2200));
        if (!mounted) return;

        await state.maybeMap(
          authenticated: (_) async {
            Navigator.of(context).pushReplacement(
              _fadeRoute(const MainShell()),
            );
          },
          unauthenticated: (_) async {
            final prefs = await SharedPreferences.getInstance();
            final seenOnboarding = prefs.getBool('onboarding_seen') ?? false;
            if (!mounted) return;

            Navigator.of(context).pushReplacement(
              _fadeRoute(
                seenOnboarding ? const LoginPage() : const OnboardingScreen(),
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // ── Animated Logo ──
                  AnimatedBuilder(
                    animation: Listenable.merge([_logoController, _shimmerController]),
                    builder: (context, child) {
                      final shimmer = 0.95 + (_shimmerController.value * 0.05);
                      return Opacity(
                        opacity: _logoOpacity.value,
                        child: Transform.scale(
                          scale: _logoScale.value * shimmer,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.3),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/logo.svg',
                        width: 140,
                        height: 140,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Animated "CheckFood" Text ──
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textOpacity.value,
                        child: Transform.translate(
                          offset: Offset(0, _textSlide.value),
                          child: child,
                        ),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Check',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: 'Food',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF10B981),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Animated Tagline ──
                  FadeTransition(
                    opacity: _taglineOpacity,
                    child: const Text(
                      'Reservations & Orders. Simplified.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0x99FFFFFF),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // ── Loading indicator ──
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        initial: () => _buildLoader(),
                        loading: () => _buildLoader(),
                        orElse: () => const SizedBox(height: 24),
                      );
                    },
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        color: Color(0xFF10B981),
        strokeWidth: 2.5,
      ),
    );
  }

  Route _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
