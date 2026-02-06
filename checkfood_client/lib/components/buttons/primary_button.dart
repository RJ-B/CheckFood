import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/radius.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading;

    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: 56,
        child: Material(
          color: AppColors.primary,
          borderRadius: AppRadius.md,
          child: InkWell(
            borderRadius: AppRadius.md,
            onTap: disabled ? null : onTap,
            splashColor: AppColors.primaryLight.withOpacity(0.2),
            child: Center(
              child:
                  isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            Icon(icon, size: 20, color: Colors.white),
                            const SizedBox(width: AppSpacing.sm),
                          ],
                          Text(
                            label,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
