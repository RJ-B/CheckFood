import 'package:flutter/material.dart';

import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/colors.dart';

import '../../features/explore/domain/menu_item_model.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onTap;

  const MenuItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Opacity(
        opacity: item.isAvailable ? 1 : 0.5,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: item.isAvailable ? onTap : null,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* IMAGE PLACEHOLDER */
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.fastfood),
                  ),

                  const SizedBox(width: AppSpacing.base),

                  /* CONTENT */
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: AppTypography.bodyLg),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: AppTypography.bodyMd.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            if (item.isAvailable)
                              Icon(Icons.add_circle, color: AppColors.primary)
                            else
                              Text(
                                'Unavailable',
                                style: AppTypography.bodySm.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
