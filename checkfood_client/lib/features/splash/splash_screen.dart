import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../navigation/main_shell.dart';
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/auth/auth_state.dart';
import '../onboarding/onboarding_screen.dart';
import '../../security/presentation/pages/auth/login_page.dart';

/// Native Android 12 splash shows the logo at ~200dp, centered on the full
/// screen (ignoring status bar). This screen starts with the EXACT same
/// layout so the handoff is invisible, then animates to the branded layout.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // How big the logo is on the native splash (dp).
  static const double _nativeLogoSize = 200;
  // Final (smaller) logo size after the animation.
  static const double _finalLogoSize = 150;

  // Master transition: drives logo scale + position + bg gradient
  late final AnimationController _transitionController;
  late final Animation<double> _logoScale;   // 1.0 → _finalLogoSize/_nativeLogoSize
  late final Animation<double> _logoVerticalShift; // 0 → negative (moves up)
  late final Animation<double> _bgGradient;  // 0 → 1

  // Glow behind logo
  late final AnimationController _glowController;
  late final Animation<double> _glowOpacity;

  // Continuous breathing pulse (starts after transition)
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  // Text "CheckFood" slides up + fades in
  late final AnimationController _textController;
  late final Animation<double> _textSlide;
  late final Animation<double> _textOpacity;

  // Tagline fades in
  late final AnimationController _taglineController;
  late final Animation<double> _taglineOpacity;

  // Loader fades in
  late final AnimationController _loaderController;
  late final Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();

    // --- Master transition (logo scale + move + bg) ---
    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Logo shrinks from native size to final size
    _logoScale = Tween<double>(
      begin: 1.0,
      end: _finalLogoSize / _nativeLogoSize, // 0.75
    ).animate(CurvedAnimation(
      parent: _transitionController,
      curve: Curves.easeInOutCubic,
    ));

    // Logo moves upward (pixels) — value determined at build time via screen height
    _logoVerticalShift = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Background gradient blend
    _bgGradient = CurvedAnimation(
      parent: _transitionController,
      curve: Curves.easeInOut,
    );

    // --- Glow ---
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );

    // --- Pulse (delayed start) ---
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _pulse = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // --- Text ---
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
    _textOpacity = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // --- Tagline ---
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = CurvedAnimation(
      parent: _taglineController,
      curve: Curves.easeIn,
    );

    // --- Loader ---
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
    // Hold the native-splash-identical frame for a moment
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    // Phase 1: Logo shrinks + moves up + bg gradient fades in + glow appears
    _transitionController.forward();
    _glowController.forward();

    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    // Phase 2: Text slides up
    _textController.forward();
    // Start the gentle pulse now
    _pulseController.repeat(reverse: true);

    await Future.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;

    // Phase 3: Tagline
    _taglineController.forward();

    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;

    // Phase 4: Loader
    _loaderController.forward();
  }

  @override
  void dispose() {
    _transitionController.dispose();
    _glowController.dispose();
    _pulseController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate how far up the logo needs to travel.
    // Native splash: logo center = screen center (ignoring status bar, since
    // native splash is full-screen).
    // Final position: we want the logo+text group vertically centered, which
    // means the logo itself sits above true center.  The text block height is
    // roughly 40(text) + 14(gap) + 15(tagline) ≈ 70dp.  So the logo should
    // end up about  (70/2) + 20 ≈ 55dp above true center.  Plus some extra
    // breathing room → 80dp above center feels right.
    const double targetVerticalShift = -80;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(milliseconds: 3000));
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
        // No SafeArea on purpose — native splash is full-screen, so our
        // initial frame must match exactly (logo at true screen center).
        body: AnimatedBuilder(
          animation: Listenable.merge([
            _transitionController,
            _glowController,
            _pulseController,
            _textController,
            _taglineController,
            _loaderController,
          ]),
          builder: (context, _) {
            final t = _bgGradient.value;
            final shift = _logoVerticalShift.value * targetVerticalShift;
            final scale = _logoScale.value;
            final currentLogoSize = _nativeLogoSize * scale;
            final pulseScale = _pulse.value;

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(const Color(0xFF0F2027), const Color(0xFF0F2027), t)!,
                    Color.lerp(const Color(0xFF0F2027), const Color(0xFF203A43), t)!,
                    Color.lerp(const Color(0xFF0F2027), const Color(0xFF2C5364), t)!,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // === Logo + text group — starts at true center ===
                  Align(
                    alignment: Alignment.center,
                    child: Transform.translate(
                      offset: Offset(0, shift),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // -- Logo with glow --
                          SizedBox(
                            width: _nativeLogoSize,
                            height: _nativeLogoSize,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Glow
                                Opacity(
                                  opacity: _glowOpacity.value,
                                  child: Container(
                                    width: currentLogoSize * 1.3,
                                    height: currentLogoSize * 1.3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF10B981)
                                              .withValues(alpha: 0.25),
                                          blurRadius: 60,
                                          spreadRadius: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SVG logo
                                Transform.scale(
                                  scale: scale * pulseScale,
                                  child: SvgPicture.asset(
                                    'assets/icons/logo.svg',
                                    width: _nativeLogoSize,
                                    height: _nativeLogoSize,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 36),

                          // -- "CheckFood" text --
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

                          // -- Tagline --
                          Opacity(
                            opacity: _taglineOpacity.value,
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
                  ),

                  // === Loader at bottom ===
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Opacity(
                        opacity: _loaderOpacity.value,
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
            );
          },
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
