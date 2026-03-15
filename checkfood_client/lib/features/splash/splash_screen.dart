import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // Android 12 renders the icon at 288dp but with 25% padding the
  // visible logo is 216dp. Match this exactly for seamless handoff.
  static const double _nativeLogoSize = 216;
  static const double _finalLogoSize = 120;
  static const double _logoRiseDistance = 80;

  // Master transition: logo scale + position + background
  late final AnimationController _transitionCtrl;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoRise;
  late final Animation<double> _bgBlend;

  // Glow behind logo
  late final AnimationController _glowCtrl;
  late final Animation<double> _glowOpacity;

  // Continuous pulse
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

    _logoRise = CurvedAnimation(
      parent: _transitionCtrl,
      curve: Curves.easeInOutCubic,
    );

    _bgBlend = CurvedAnimation(
      parent: _transitionCtrl,
      curve: Curves.easeInOut,
    );

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeOut),
    );

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _pulse = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic),
    );
    _textOpacity = CurvedAnimation(parent: _textCtrl, curve: Curves.easeIn);

    _taglineCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = CurvedAnimation(parent: _taglineCtrl, curve: Curves.easeIn);

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

    // Phase 1: logo shrinks + rises + bg gradient
    _transitionCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 750));
    if (!mounted) return;

    // Phase 2: text + glow + pulse
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
                  // ===== LOGO =====
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
                              // PNG logo
                              Transform.scale(
                                scale: scale,
                                child: Image.asset(
                                  'assets/icons/splash_logo.png',
                                  width: _nativeLogoSize,
                                  height: _nativeLogoSize,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ===== TEXT =====
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          -_logoRiseDistance + _nativeLogoSize / 2 + 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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

                  // ===== LOADER =====
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
