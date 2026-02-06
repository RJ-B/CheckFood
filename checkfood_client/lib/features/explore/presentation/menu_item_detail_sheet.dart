import 'package:flutter/material.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/theme/colors.dart';

import '../domain/menu_item_model.dart';
import '../../../components/buttons/primary_button.dart';

class MenuItemDetailSheet extends StatefulWidget {
  final MenuItem item;

  const MenuItemDetailSheet({super.key, required this.item});

  @override
  State<MenuItemDetailSheet> createState() => _MenuItemDetailSheetState();
}

class _MenuItemDetailSheetState extends State<MenuItemDetailSheet> {
  int _quantity = 1;

  void _increment() {
    setState(() => _quantity++);
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.item.price * _quantity;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* DRAG HANDLE */
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            /* TITLE */
            Text(widget.item.name, style: AppTypography.titleLg),
            const SizedBox(height: AppSpacing.sm),

            /* DESCRIPTION */
            Text(
              widget.item.description,
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            /* QUANTITY */
            Row(
              children: [
                IconButton(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(_quantity.toString(), style: AppTypography.titleMd),
                IconButton(
                  onPressed: _increment,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                const Spacer(),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: AppTypography.titleMd,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            /* ADD BUTTON */
            PrimaryButton(
              label: 'Add to cart',
              onTap: () {
                // zatím jen zavřeme sheet
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
