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
  // Android 12 renders windowSplashScreenAnimatedIcon at 288dp.
  // We must start at the same size so the handoff is invisible.
  static const double _nativeLogoSize = 288;
  static const double _finalLogoSize = 150;
  static const double _logoRiseDistance = 100;

  // Start with PNG (identical to native splash), switch to SVG during animation.
  bool _usePng = true;

  // Master transition: logo scale + position + background
  late final AnimationController _transitionCtrl;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoRise;
  late final Animation<double> _bgBlend;

  // Glow behind logo
  late final AnimationController _glowCtrl;
  late final Animation<double> _glowOpacity;

  // Continuous pulse (starts after transition)
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulse;

  // Text "CheckFood"
  late final AnimationController _textCtrl;
  late final Animation<double> _textSlide;
  late final Animation<double> _textOpacity;

  // Tagline
  late final AnimationController _taglineCtrl;
  late final Animation<double> _taglineOpacity;

  // Loader
  late final AnimationController _loaderCtrl;
  late final Animation<double> _loaderOpacity;

  @override
  void initState() {
    super.initState();

    // --- Master transition (1s) ---
    _transitionCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoScale = Tween<double>(
      begin: 1.0,
      end: _finalLogoSize / _nativeLogoSize,
    ).animate(CurvedAnimation(
      parent: _transitionCtrl,
      curve: Curves.easeInOutCubic,
    ));

    // 0 → 1 drives the vertical rise
    _logoRise = CurvedAnimation(
      parent: _transitionCtrl,
      curve: Curves.easeInOutCubic,
    );

    _bgBlend = CurvedAnimation(
      parent: _transitionCtrl,
      curve: Curves.easeInOut,
    );

    // --- Glow ---
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeOut),
    );

    // --- Pulse ---
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _pulse = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    // --- Text ---
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic),
    );
    _textOpacity = CurvedAnimation(parent: _textCtrl, curve: Curves.easeIn);

    // --- Tagline ---
    _taglineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = CurvedAnimation(parent: _taglineCtrl, curve: Curves.easeIn);

    // --- Loader ---
    _loaderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _loaderOpacity = CurvedAnimation(parent: _loaderCtrl, curve: Curves.easeIn);

    _runSequence();
  }

  void _runSequence() async {
    // Hold the native-splash-identical frame.
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    // Switch to SVG during motion — any micro-difference is hidden by animation.
    setState(() => _usePng = false);

    // Phase 1: logo shrinks + rises + bg gradient
    _transitionCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 750));
    if (!mounted) return;

    // Phase 2: text appears + glow + pulse (glow starts AFTER transition)
    _glowCtrl.forward();
    _textCtrl.forward();
    _pulseCtrl.repeat(reverse: true);

    await Future.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;

    // Phase 3: tagline
    _taglineCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;

    // Phase 4: loader
    _loaderCtrl.forward();
  }

  @override
  void dispose() {
    _transitionCtrl.dispose();
    _glowCtrl.dispose();
    _pulseCtrl.dispose();
    _textCtrl.dispose();
    _taglineCtrl.dispose();
    _loaderCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(milliseconds: 3200));
        if (!mounted) return;

        await state.maybeMap(
          authenticated: (_) async {
            Navigator.of(context).pushReplacement(_fadeRoute(const MainShell()));
          },
          unauthenticated: (_) async {
            final prefs = await SharedPreferences.getInstance();
            final seenOnboarding = prefs.getBool('onboarding_seen') ?? false;
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              _fadeRoute(seenOnboarding ? const LoginPage() : const OnboardingScreen()),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        body: AnimatedBuilder(
          animation: Listenable.merge([
            _transitionCtrl, _glowCtrl, _pulseCtrl,
            _textCtrl, _taglineCtrl, _loaderCtrl,
          ]),
          builder: (context, _) {
            final bgT = _bgBlend.value;
            final rise = _logoRise.value * _logoRiseDistance;
            final scale = _logoScale.value * _pulse.value;

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(const Color(0xFF0F2027), const Color(0xFF0F2027), bgT)!,
                    Color.lerp(const Color(0xFF0F2027), const Color(0xFF203A43), bgT)!,
                    Color.lerp(const Color(0xFF0F2027), const Color(0xFF2C5364), bgT)!,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // ===== LOGO — positioned at true screen center, then rises =====
                  // Using Positioned.fill + Align ensures the logo sits at exact
                  // center of the entire screen (no SafeArea, no Column siblings).
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0, -rise),
                        child: SizedBox(
                          width: _nativeLogoSize,
                          height: _nativeLogoSize,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Glow
                              Opacity(
                                opacity: _glowOpacity.value,
                                child: Container(
                                  width: _nativeLogoSize,
                                  height: _nativeLogoSize,
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
                              // Logo — starts as PNG (identical to native splash),
                              // switches to SVG during animation.
                              Transform.scale(
                                scale: scale,
                                child: _usePng
                                    ? Image.asset(
                                        'assets/icons/splash_logo.png',
                                        width: _nativeLogoSize,
                                        height: _nativeLogoSize,
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/logo.svg',
                                        width: _nativeLogoSize,
                                        height: _nativeLogoSize,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ===== TEXT — independent layer, positioned below final logo =====
                  // The final logo center is at (screenCenter - _logoRiseDistance).
                  // Text should start below that.
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.translate(
                        // Position text below the final logo position:
                        // logo center moved up by _logoRiseDistance, logo half-height
                        // is _nativeLogoSize/2, then some gap.
                        offset: Offset(
                          0,
                          -_logoRiseDistance + _nativeLogoSize / 2 + 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // "CheckFood"
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
                  ),

                  // ===== LOADER at bottom =====
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
