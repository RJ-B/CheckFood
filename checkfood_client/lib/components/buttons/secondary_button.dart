import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onTap,
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
          color: Colors.transparent,
          borderRadius: AppRadius.md,
          child: InkWell(
            borderRadius: AppRadius.md,
            onTap: disabled ? null : onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, width: 1.5),
                borderRadius: AppRadius.md,
              ),
              child: Center(
                child:
                    isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Text(
                          label,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
