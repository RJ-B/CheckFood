import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/colors.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/ghost_button.dart';
import '../../security/presentation/pages/auth/login_page.dart';
import '../../l10n/generated/app_localizations.dart';

/// Vícestránkový onboarding zobrazený novým uživatelům při prvním spuštění.
///
/// Po dokončení uloží příznak do [SharedPreferences], aby se onboarding
/// při dalším spuštění přeskočil.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

/// Stav pro [OnboardingScreen]: sleduje index aktuální stránky a řídí
/// přechody mezi stránkami a dokončení onboardingu.
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  List<_OnboardingPageData> _buildPages(S l) => [
    _OnboardingPageData(
      icon: Icons.map,
      title: l.onboardingTitle1,
      subtitle: l.onboardingDesc1,
    ),
    _OnboardingPageData(
      icon: Icons.calendar_today,
      title: l.onboardingTitle2,
      subtitle: l.onboardingDesc2,
    ),
    _OnboardingPageData(
      icon: Icons.shopping_bag,
      title: l.onboardingTitle3,
      subtitle: l.onboardingDesc3,
    ),
    _OnboardingPageData(
      icon: Icons.notifications_active,
      title: l.onboardingTitle4,
      subtitle: l.onboardingDesc4,
    ),
  ];

  bool _isLast(int pageCount) => _index == pageCount - 1;

  void _next(int pageCount) {
    if (_isLast(pageCount)) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// Označí onboarding jako zobrazený a přejde na [LoginPage].
  Future<void> _finish() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_seen', true);
    } catch (_) {}

    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final pages = _buildPages(l);
    final isLast = _isLast(pages.length);

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
                  if (!isLast)
                    GhostButton(
                      label: l.skip,
                      onTap: () => _controller.jumpToPage(pages.length - 1),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: PrimaryButton(
                label: isLast ? l.getStarted : l.next,
                onTap: () => _next(pages.length),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

/// Jedna stránka onboardingového karuselu zobrazující ikonu, nadpis a podnadpis.
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

/// Datový kontejner pro ikonu, nadpis a podnadpis jedné onboardingové stránky.
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
