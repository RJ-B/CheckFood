import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String cuisine;
  final double rating;
  final String distance;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.distance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Icon(Icons.restaurant, size: 48)),
              ),
              const SizedBox(height: AppSpacing.base),
              Text(name, style: AppTypography.titleSm),
              const SizedBox(height: AppSpacing.xs),
              Text(
                cuisine,
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(rating.toString()),
                  const Spacer(),
                  Text(
                    distance,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
