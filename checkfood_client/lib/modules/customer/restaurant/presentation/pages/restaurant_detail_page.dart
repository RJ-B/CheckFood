import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/di/injection_container.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/opening_hours.dart';
import '../../../../customer/reservation/presentation/pages/reservation_page.dart';
import '../bloc/restaurant_detail_bloc.dart';
import '../bloc/restaurant_detail_event.dart';
import '../bloc/restaurant_detail_state.dart';

/// Celostránkový detail restaurace.
/// Přijímá [restaurantId] a sám si načte data přes RestaurantDetailBloc.
class RestaurantDetailPage extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RestaurantDetailBloc>()
        ..add(RestaurantDetailEvent.loadRequested(restaurantId: restaurantId)),
      child: Scaffold(
        body: BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (restaurant) => _DetailContent(restaurant: restaurant),
              error: (message) => _ErrorContent(
                message: message,
                onRetry: () => context.read<RestaurantDetailBloc>().add(
                  RestaurantDetailEvent.loadRequested(
                    restaurantId: restaurantId,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail content (scrollable with SliverAppBar)
// ---------------------------------------------------------------------------

class _DetailContent extends StatelessWidget {
  final Restaurant restaurant;

  const _DetailContent({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverToBoxAdapter(child: _buildBody(context)),
      ],
    );
  }

  // --- SLIVER APP BAR with cover image ---

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.9),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            child: IconButton(
              icon: Icon(
                restaurant.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: restaurant.isFavourite ? Colors.red : Colors.black87,
              ),
              onPressed: () => context
                  .read<RestaurantDetailBloc>()
                  .add(const RestaurantDetailEvent.toggleFavourite()),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: restaurant.coverImageUrl != null
            ? CachedNetworkImage(
                imageUrl: restaurant.coverImageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) => _imagePlaceholder(),
                errorWidget: (_, __, ___) => _imagePlaceholder(),
              )
            : _imagePlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.restaurant, size: 64, color: Colors.grey),
      ),
    );
  }

  // --- BODY ---

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Gap(12),
          _buildAddress(),
          if (restaurant.description != null &&
              restaurant.description!.isNotEmpty) ...[
            const Gap(20),
            _buildDescription(context),
          ],
          const Gap(20),
          _buildOpeningHours(context),
          if (restaurant.tags.isNotEmpty) ...[
            const Gap(20),
            _buildTags(),
          ],
          const Gap(32),
          _buildReserveButton(context),
          const Gap(20),
        ],
      ),
    );
  }

  // --- HEADER: name, cuisine, rating ---

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(6),
        Row(
          children: [
            if (restaurant.rating != null) ...[
              const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
              const Gap(4),
              Text(
                restaurant.rating!.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              _dot(),
            ],
            Text(
              restaurant.cuisineType.displayName,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            _dot(),
            _buildOpenNowBadge(),
          ],
        ),
      ],
    );
  }

  Widget _dot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '\u00B7',
        style: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildOpenNowBadge() {
    final now = DateTime.now();
    final todayHours = _getTodayHours(now.weekday);

    final bool isOpen;
    if (todayHours == null || todayHours.isClosed) {
      isOpen = false;
    } else {
      isOpen = _isCurrentlyOpen(todayHours, now);
    }

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isOpen ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(4),
        Text(
          isOpen ? 'Otevřeno' : 'Zavřeno',
          style: TextStyle(
            color: isOpen ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  bool _isCurrentlyOpen(OpeningHours hours, DateTime now) {
    if (hours.openAt == null || hours.closeAt == null) return false;
    final open = _parseTime(hours.openAt!);
    final close = _parseTime(hours.closeAt!);
    if (open == null || close == null) return false;

    final nowMinutes = now.hour * 60 + now.minute;
    return nowMinutes >= open && nowMinutes < close;
  }

  int? _parseTime(String time) {
    final parts = time.split(':');
    if (parts.length < 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return h * 60 + m;
  }

  OpeningHours? _getTodayHours(int weekday) {
    // weekday: 1=Monday ... 7=Sunday (matches entity dayOfWeek)
    try {
      return restaurant.openingHours.firstWhere(
        (h) => h.dayOfWeek == weekday,
      );
    } catch (_) {
      return null;
    }
  }

  // --- ADDRESS ---

  Widget _buildAddress() {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 18),
        const Gap(6),
        Expanded(
          child: Text(
            restaurant.address.fullAddress,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
        ),
      ],
    );
  }

  // --- DESCRIPTION ---

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O restauraci',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Text(
          restaurant.description!,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // --- OPENING HOURS ---

  Widget _buildOpeningHours(BuildContext context) {
    final dayNames = [
      'Pondělí',
      'Úterý',
      'Středa',
      'Čtvrtek',
      'Pátek',
      'Sobota',
      'Neděle',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Otevírací doba',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(10),
        ...List.generate(7, (i) {
          final dayOfWeek = i + 1; // 1=Monday
          final hours = _getTodayHours(dayOfWeek);
          final isToday = DateTime.now().weekday == dayOfWeek;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    dayNames[i],
                    style: TextStyle(
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                      color: isToday ? Colors.teal : Colors.black87,
                    ),
                  ),
                ),
                Text(
                  hours?.formattedHours ?? 'Zavřeno',
                  style: TextStyle(
                    fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                    color: isToday ? Colors.teal : Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // --- TAGS ---

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: restaurant.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.teal,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- RESERVE BUTTON ---

  Widget _buildReserveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ReservationPage(restaurantId: restaurant.id),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text('Rezervovat stůl'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error fallback
// ---------------------------------------------------------------------------

class _ErrorContent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorContent({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Zkusit znovu'),
            ),
          ],
        ),
      ),
    );
  }
}
