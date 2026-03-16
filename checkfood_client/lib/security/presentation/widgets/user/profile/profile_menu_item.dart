import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? iconColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: iconColor ?? AppColors.textSecondary),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle:
          subtitle != null
              ? Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              )
              : null,
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted),
      onTap: onTap,
    );
  }
}
