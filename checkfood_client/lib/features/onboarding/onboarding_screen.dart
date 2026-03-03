import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Nutný import pro uložení stavu

import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/colors.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/ghost_button.dart';
import '../../security/presentation/pages/auth/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_OnboardingPageData> pages = const [
    _OnboardingPageData(
      icon: Icons.map,
      title: 'Discover Restaurants',
      subtitle: 'Find the perfect spot for any occasion',
    ),
    _OnboardingPageData(
      icon: Icons.calendar_today,
      title: 'Easy Reservations',
      subtitle: 'Book tables instantly, anytime',
    ),
    _OnboardingPageData(
      icon: Icons.shopping_bag,
      title: 'Order Delicious Food',
      subtitle: 'Delivery, takeaway, or dine-in',
    ),
    _OnboardingPageData(
      icon: Icons.notifications_active,
      title: 'Track Everything',
      subtitle: 'Real-time updates on orders and reservations',
    ),
  ];

  bool get isLast => _index == pages.length - 1;

  void _next() {
    if (isLast) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// ✅ Tato metoda nyní uloží do paměti, že uživatel onboarding viděl.
  Future<void> _finish() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_seen', true);
    } catch (e) {
      debugPrint('Chyba při ukládání onboarding stavu: $e');
    }

    if (!mounted) return;

    // Přesměrování na Login Page
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => _OnboardingPage(data: pages[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: Row(
                children: [
                  // Indikátor stránek (tečky)
                  Row(
                    children: List.generate(
                      pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 6),
                        width: _index == i ? 16 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color:
                              _index == i
                                  ? AppColors.primary
                                  : AppColors.border,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Tlačítko Skip
                  if (!isLast)
                    GhostButton(
                      label: 'Skip',
                      // Skip jen přeskočí na poslední slide.
                      // Pokud bys chtěl, aby Skip rovnou ukončil onboarding,
                      // změň to na: onTap: _finish,
                      onTap: () => _controller.jumpToPage(pages.length - 1),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Hlavní tlačítko Next / Get Started
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: PrimaryButton(
                label: isLast ? 'Get Started' : 'Next',
                onTap: _next,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */

class _OnboardingPage extends StatelessWidget {
  final _OnboardingPageData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, size: 160, color: AppColors.primary),
          const SizedBox(height: AppSpacing.xl),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTypography.titleLg,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLg.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
