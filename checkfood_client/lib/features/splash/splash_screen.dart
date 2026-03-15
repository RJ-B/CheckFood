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
  // Phase 1: Background solid → gradient
  late final AnimationController _bgController;
  late final Animation<double> _bgProgress;

  // Phase 1: Logo moves from center upward
  late final AnimationController _logoMoveController;
  late final Animation<double> _logoOffset;

  // Phase 2: Glow expands behind logo
  late final AnimationController _glowController;
  late final Animation<double> _glowOpacity;

  // Continuous: Logo gentle breathing pulse
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  // Phase 3: Text slides up + fades in
  late final AnimationController _textController;
  late final Animation<double> _textSlide;
  late final Animation<double> _textOpacity;

  // Phase 4: Tagline fades in
  late final AnimationController _taglineController;
  late final Animation<double> _taglineOpacity;

  // Phase 5: Loader fades in
  late final AnimationController _loaderController;
  late final Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();

    // Background: solid #0F2027 → gradient
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _bgProgress = CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeInOut,
    );

    // Logo: slides upward from center
    _logoMoveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoOffset = Tween<double>(begin: 0, end: -80).animate(
      CurvedAnimation(parent: _logoMoveController, curve: Curves.easeInOutCubic),
    );

    // Glow behind logo
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );

    // Continuous breathing pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Text: slide up + fade in
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

    // Tagline: fade in
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
    // Frame 0: logo centered on solid dark bg — identical to native splash
    // Small pause to let Flutter settle and ensure seamless handoff
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    // Phase 1: Background fades to gradient + logo slides upward (simultaneously)
    _bgController.forward();
    _logoMoveController.forward();
    _glowController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    // Phase 2: Text slides up
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    // Phase 3: Tagline fades in
    _taglineController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // Phase 4: Loader appears
    _loaderController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoMoveController.dispose();
    _glowController.dispose();
    _pulseController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(milliseconds: 2800));
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
        body: AnimatedBuilder(
          animation: _bgProgress,
          builder: (context, child) {
            // Interpolate from solid #0F2027 to gradient
            final t = _bgProgress.value;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(
                      const Color(0xFF0F2027),
                      const Color(0xFF0F2027),
                      t,
                    )!,
                    Color.lerp(
                      const Color(0xFF0F2027),
                      const Color(0xFF203A43),
                      t,
                    )!,
                    Color.lerp(
                      const Color(0xFF0F2027),
                      const Color(0xFF2C5364),
                      t,
                    )!,
                  ],
                ),
              ),
              child: child,
            );
          },
          child: SafeArea(
            child: Stack(
              children: [
                // -- Logo layer: starts centered, moves up --
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _logoMoveController,
                    _pulseController,
                    _glowController,
                  ]),
                  builder: (context, child) {
                    return Center(
                      child: Transform.translate(
                        offset: Offset(0, _logoOffset.value),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo + glow
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Glow
                                  Opacity(
                                    opacity: _glowOpacity.value,
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
                                  // Logo SVG with pulse
                                  Transform.scale(
                                    scale: _pulse.value,
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

                            // Text "CheckFood"
                            Opacity(
                              opacity: _textOpacity.value,
                              child: Transform.translate(
                                offset: Offset(0, _textSlide.value),
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
                            ),

                            const SizedBox(height: 14),

                            // Tagline
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
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // -- Loader at bottom --
                Positioned(
                  bottom: 48,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FadeTransition(
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
                  ),
                ),
              ],
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
