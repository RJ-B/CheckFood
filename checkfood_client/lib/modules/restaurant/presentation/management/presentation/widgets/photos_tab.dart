import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/di/injection_container.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../security/config/security_endpoints.dart';
import '../../domain/entities/my_restaurant.dart';
import '../../../../domain/entities/restaurant_photo.dart';
import '../bloc/my_restaurant_bloc.dart';
import '../bloc/my_restaurant_event.dart';
import './panorama_tab.dart';

/// Záložka pro správu galerie fotek a panoramatu restaurace.
///
/// Zobrazuje mřížku nahraných fotek s možností přidání (max 30) a smazání.
/// Obsahuje také embedded [PanoramaTab] pro správu panoramatických snímků.
class PhotosTab extends StatefulWidget {
  final MyRestaurant restaurant;
  final bool isOwner;

  const PhotosTab({
    super.key,
    required this.restaurant,
    required this.isOwner,
  });

  @override
  State<PhotosTab> createState() => _PhotosTabState();
}

class _PhotosTabState extends State<PhotosTab> {
  bool _isUploading = false;

  static const int _maxPhotos = 30;

  /// Otevře výběr fotek z galerie a nahraje vybranou fotku.
  Future<void> _uploadGalleryPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() => _isUploading = true);
    try {
      final bytes = await picked.readAsBytes();
      final filename = picked.name.isNotEmpty ? picked.name : 'photo.jpg';
      final dio = sl<Dio>();
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: filename),
      });
      await dio.post(
        SecurityEndpoints.ownerRestaurantGallery(widget.restaurant.id),
        data: formData,
      );
      if (!mounted) return;
      // Znovunačtení dat restaurace pro aktualizaci galerie
      context.read<MyRestaurantBloc>().add(const LoadMyRestaurant());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotka byla přidána.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nahrávání selhalo: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  /// Zobrazí potvrzovací dialog a smaže vybranou fotku z galerie.
  Future<void> _deleteGalleryPhoto(RestaurantPhoto photo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Smazat fotku?'),
        content: const Text('Tato akce je nevratná.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Zrušit'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Smazat',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      final dio = sl<Dio>();
      await dio.delete(
        SecurityEndpoints.ownerRestaurantGalleryPhoto(
          widget.restaurant.id,
          photo.id,
        ),
      );
      if (!mounted) return;
      context.read<MyRestaurantBloc>().add(const LoadMyRestaurant());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotka byla smazána.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mazání selhalo: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gallery = widget.restaurant.gallery;
    final isFull = gallery.length >= _maxPhotos;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Sekce Galerie ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Galerie restaurace',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${gallery.length} / $_maxPhotos fotek',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Mřížka fotek
          if (gallery.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'Zatím nejsou nahrány žádné fotky.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: gallery.length,
              itemBuilder: (context, index) {
                final photo = gallery[index];
                return GestureDetector(
                  onLongPress: () => _deleteGalleryPhoto(photo),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: photo.url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.borderLight,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.borderLight,
                        child: const Icon(
                          Icons.broken_image,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          const SizedBox(height: 12),

          // Tlačítko Přidat fotku
          FilledButton.icon(
            onPressed: (isFull || _isUploading) ? null : _uploadGalleryPhoto,
            icon: _isUploading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.add_photo_alternate),
            label: Text(
              isFull
                  ? 'Maximální počet fotek dosažen'
                  : _isUploading
                      ? 'Nahrávám...'
                      : 'Přidat fotku',
            ),
          ),

          if (gallery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Dlouhým stiskem fotku smažete.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                textAlign: TextAlign.center,
              ),
            ),

          // --- Sekce Panorama ---
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Panorama',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 500,
            child: PanoramaTab(
              activePanoramaUrl: widget.restaurant.panoramaUrl,
            ),
          ),
        ],
      ),
    );
  }
}
