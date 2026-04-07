import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkfood_client/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/entities/user_profile.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_event.dart';
import '../../../../../l10n/generated/app_localizations.dart';

/// Hlavička profilu zobrazující avatar (s možností změny fotografie), jméno, e-mail a stav účtu.
class ProfileHeader extends StatelessWidget {
  final UserProfile profile;

  const ProfileHeader({super.key, required this.profile});

  Future<void> _onAvatarTap(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (image == null) return;

    final Uint8List bytes = await image.readAsBytes();
    final String filename = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';

    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final userBloc = context.read<UserBloc>();
      userBloc.add(UserEvent.profilePhotoUploadRequested(bytes, filename));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).photoUploadError(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayFullName =
        '${profile.firstName} ${profile.lastName}'.trim();
    final String initials = _getInitials(profile.firstName, profile.lastName);
    final bool hasPhoto =
        profile.profileImageUrl != null && profile.profileImageUrl!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _onAvatarTap(context),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  backgroundImage: hasPhoto
                      ? CachedNetworkImageProvider(profile.profileImageUrl!)
                      : null,
                  child: hasPhoto
                      ? null
                      : Text(
                          initials,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            displayFullName.isNotEmpty ? displayFullName : S.of(context).userNoName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            profile.email,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),

          if (!profile.isActive) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warningLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    S.of(context).inactiveAccount,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.warning,
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

  String _getInitials(String firstName, String lastName) {
    final String f = firstName.trim();
    final String l = lastName.trim();

    if (f.isEmpty && l.isEmpty) return '?';
    if (f.isNotEmpty && l.isEmpty) return f[0].toUpperCase();
    if (f.isEmpty && l.isNotEmpty) return l[0].toUpperCase();

    return '${f[0]}${l[0]}'.toUpperCase();
  }
}
