import 'package:checkfood_client/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    // Skládáme jméno pro zobrazení, protože v entitě už fullName nemáme
    final String displayFullName =
        '${profile.firstName} ${profile.lastName}'.trim();
    final String initials = _getInitials(profile.firstName, profile.lastName);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Column(
        children: [
          // --- AVATAR ---
          CircleAvatar(
            radius: 45,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // --- JMÉNO ---
          Text(
            displayFullName.isNotEmpty ? displayFullName : 'Uživatel bez jména',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          // --- EMAIL ---
          Text(
            profile.email,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),

          // --- STATUS NEAKTIVNÍHO ÚČTU ---
          if (!profile.isActive) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: Colors.orange.shade800,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Neaktivní účet',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Generování iniciál přímo z rozdělených jmen
  String _getInitials(String firstName, String lastName) {
    final String f = firstName.trim();
    final String l = lastName.trim();

    if (f.isEmpty && l.isEmpty) return '?';
    if (f.isNotEmpty && l.isEmpty) return f[0].toUpperCase();
    if (f.isEmpty && l.isNotEmpty) return l[0].toUpperCase();

    return '${f[0]}${l[0]}'.toUpperCase();
  }
}
