import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/theme/colors.dart';
import '../../domain/entities/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Position? userPosition; // Přidáno pro dynamický výpočet vzdálenosti
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.userPosition,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildInfoSection(context)],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: AspectRatio(
            aspectRatio: 16 / 8,
            child:
                restaurant.coverImageUrl != null
                    ? CachedNetworkImage(
                      imageUrl: restaurant.coverImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => _buildPlaceholder(),
                      errorWidget: (_, __, ___) => _buildPlaceholder(),
                    )
                    : _buildPlaceholder(),
          ),
        ),
        if (restaurant.tags.isNotEmpty)
          Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children:
                  restaurant.tags
                      .take(2)
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: _buildTag(tag.toUpperCase(), Colors.black87),
                        ),
                      )
                      .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final distance = _calculateDistance();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap(4),
          Row(
            children: [
              Text(
                "${restaurant.cuisineType.name} • ",
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              Text(
                distance,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Gap(8),
          _buildOpeningStatus(),
        ],
      ),
    );
  }

  Widget _buildOpeningStatus() {
    // Zde by byla reálná logika z OpeningHoursUtils
    // Prozatím implementováno staticky pro ukázku designu
    const bool isOpen = true;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isOpen ? AppColors.success : AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(6),
        Text(
          isOpen ? "Open now" : "Closed",
          style: TextStyle(
            color: isOpen ? AppColors.primaryDark : AppColors.error,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const Gap(4),
        Text(
          "• Closes 22:00",
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  String _calculateDistance() {
    if (userPosition == null || restaurant.address.latitude == null) {
      return "";
    }

    final double meters = Geolocator.distanceBetween(
      userPosition!.latitude,
      userPosition!.longitude,
      restaurant.address.latitude!,
      restaurant.address.longitude!,
    );

    if (meters < 1000) {
      return "${meters.round()} m";
    } else {
      return "${(meters / 1000).toStringAsFixed(1)} km";
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.borderLight,
      child: const Center(
        child: Icon(Icons.restaurant, color: AppColors.textMuted, size: 40),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
