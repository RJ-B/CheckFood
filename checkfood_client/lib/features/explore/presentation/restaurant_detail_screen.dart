import 'package:flutter/material.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';
import '../../../components/layout/section_header.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/secondary_button.dart';

import '../domain/restaurant_model.dart';
import 'menu_screen.dart';

import 'table_selection_screen.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /* ------------------------------------------------------------------ */
          /* HEADER / IMAGE */
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // později: toggle favorite
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // později: share
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.borderLight,
                child: const Center(child: Icon(Icons.restaurant, size: 64)),
              ),
            ),
          ),

          /* ------------------------------------------------------------------ */
          /* CONTENT */
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* NAME */
                  Text(restaurant.name, style: AppTypography.titleLg),
                  const SizedBox(height: AppSpacing.sm),

                  /* CUISINE */
                  Text(
                    restaurant.cuisine,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  /* META */
                  Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating.toString(),
                        style: AppTypography.bodyMd,
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      const Icon(Icons.place, size: 18),
                      const SizedBox(width: 4),
                      Text(restaurant.distance, style: AppTypography.bodyMd),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  /* DESCRIPTION */
                  Text(
                    'This restaurant offers a curated menu made from fresh ingredients, '
                    'a welcoming atmosphere and excellent service.',
                    style: AppTypography.bodyMd,
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  /* INFO */
                  const SectionHeader(title: 'Information'),
                  const SizedBox(height: AppSpacing.sm),

                  const _InfoRow(
                    icon: Icons.schedule,
                    label: 'Opening hours',
                    value: '9:00 AM – 10:00 PM',
                  ),
                  const _InfoRow(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: '+420 123 456 789',
                  ),
                  const _InfoRow(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: 'Main Street 12, Prague',
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),

      /* ------------------------------------------------------------------ */
      /* BOTTOM ACTION BAR */
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: 'Reserve Table',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TableSelectionScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PrimaryButton(
                    label: 'Menu',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MenuScreen(restaurant: restaurant),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* INFO ROW */

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text('$label: $value', style: AppTypography.bodySm)),
        ],
      ),
    );
  }
}
