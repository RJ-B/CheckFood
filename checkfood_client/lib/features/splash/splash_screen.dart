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
  // Logo starts visible (matching native splash), then pulses
  late final AnimationController _logoPulseController;
  late final Animation<double> _logoPulse;

  // Logo glow expands after initial appearance
  late final AnimationController _glowController;
  late final Animation<double> _glowOpacity;
  late final Animation<double> _glowScale;

  // Text "CheckFood" slides up + fades in
  late final AnimationController _textController;
  late final Animation<double> _textSlide;
  late final Animation<double> _textOpacity;

  // Tagline fades in
  late final AnimationController _taglineController;
  late final Animation<double> _taglineOpacity;

  // Loader fades in last
  late final AnimationController _loaderController;
  late final Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();

    // Logo gentle pulse (continuous, subtle breathing effect)
    _logoPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _logoPulse = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _logoPulseController, curve: Curves.easeInOut),
    );

    // Glow behind logo: expands outward
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _glowOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );
    _glowScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOutCubic),
    );

    // Text: slides up from below + fades in
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textSlide = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
    _textOpacity = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // Tagline: simple fade in
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = CurvedAnimation(
      parent: _taglineController,
      curve: Curves.easeIn,
    );

    // Loader: fade in
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _loaderOpacity = CurvedAnimation(
      parent: _loaderController,
      curve: Curves.easeIn,
    );

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Short pause — logo is already visible, matching native splash
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // Glow expands behind logo
    _glowController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    // Text slides up
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    // Tagline fades in
    _taglineController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // Loader appears
    _loaderController.forward();
  }

  @override
  void dispose() {
    _logoPulseController.dispose();
    _glowController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // Wait for animations to mostly finish
        await Future.delayed(const Duration(milliseconds: 2400));
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

                  // -- Animated Logo with Glow --
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow layer behind logo
                        AnimatedBuilder(
                          animation: _glowController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _glowOpacity.value,
                              child: Transform.scale(
                                scale: _glowScale.value,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF10B981)
                                      .withValues(alpha: 0.25),
                                  blurRadius: 60,
                                  spreadRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Logo with pulse
                        AnimatedBuilder(
                          animation: _logoPulse,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _logoPulse.value,
                              child: child,
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/icons/logo.svg',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // -- Animated "CheckFood" Text --
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
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Food',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF10B981),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // -- Animated Tagline --
                  FadeTransition(
                    opacity: _taglineOpacity,
                    child: const Text(
                      'Reservations & Orders. Simplified.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0x99FFFFFF),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // -- Loading indicator --
                  FadeTransition(
                    opacity: _loaderOpacity,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          initial: () => _buildLoader(),
                          loading: () => _buildLoader(),
                          orElse: () => const SizedBox(height: 24),
                        );
                      },
                    ),
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
      transitionDuration: const Duration(milliseconds: 600),
    );
  }
}
