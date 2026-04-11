import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/theme/colors.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/entities/opening_hours.dart';
import '../../../../order/domain/entities/menu_category.dart';
import '../../../../order/domain/entities/menu_item.dart';
import '../../../../order/domain/usecases/get_menu_usecase.dart';
import '../../../../reservation/presentation/customer/pages/reservation_page.dart';
import '../bloc/restaurant_detail_bloc.dart';
import '../bloc/restaurant_detail_event.dart';
import '../bloc/restaurant_detail_state.dart';
import '../../../../../l10n/generated/app_localizations.dart';

/// Celoobrazkový detail restaurace, který načítá data přes [RestaurantDetailBloc] pomocí zadaného [restaurantId].
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

/// Scrollovatelné tělo detailu zobrazené po úspěšném načtení restaurace.
/// Obsahuje dva taby: Informace a Menu.
class _DetailContent extends StatefulWidget {
  final Restaurant restaurant;

  const _DetailContent({required this.restaurant});

  @override
  State<_DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<_DetailContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Menu state
  List<MenuCategory>? _menuCategories;
  bool _menuLoading = false;
  String? _menuError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    // Načteme menu až když uživatel přepne na tab Menu (index 1)
    if (_tabController.index == 1 && _menuCategories == null && !_menuLoading) {
      _loadMenu();
    }
  }

  Future<void> _loadMenu() async {
    setState(() {
      _menuLoading = true;
      _menuError = null;
    });
    try {
      final useCase = sl<GetMenuUseCase>();
      final categories = await useCase(widget.restaurant.id);
      if (mounted) {
        setState(() {
          _menuCategories = categories;
          _menuLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _menuError = e.toString();
          _menuLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        _buildAppBar(context, innerBoxIsScrolled),
        SliverPersistentHeader(
          pinned: true,
          delegate: _TabBarDelegate(
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: S.of(context).information),
                Tab(text: S.of(context).menu),
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInfoTab(context),
          _buildMenuTab(context),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, bool innerBoxIsScrolled) {
    final restaurant = widget.restaurant;
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      forceElevated: innerBoxIsScrolled,
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
                color: restaurant.isFavourite
                    ? AppColors.error
                    : AppColors.textPrimary,
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
      color: AppColors.borderLight,
      child: const Center(
        child: Icon(Icons.restaurant, size: 64, color: AppColors.textMuted),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tab 0 — Informace
  // ---------------------------------------------------------------------------

  Widget _buildInfoTab(BuildContext context) {
    final restaurant = widget.restaurant;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, restaurant),
          const Gap(12),
          _buildAddress(restaurant),
          if (restaurant.description != null &&
              restaurant.description!.isNotEmpty) ...[
            const Gap(20),
            _buildDescription(context, restaurant),
          ],
          const Gap(20),
          _buildOpeningHours(context, restaurant),
          if (restaurant.tags.isNotEmpty) ...[
            const Gap(20),
            _buildTags(restaurant),
          ],
          const Gap(32),
          _buildReserveButton(context, restaurant),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Restaurant restaurant) {
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
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 14),
            ),
            _dot(),
            _buildOpenNowBadge(context, restaurant),
          ],
        ),
      ],
    );
  }

  Widget _dot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        '\u00B7',
        style: TextStyle(
          color: AppColors.textMuted,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildOpenNowBadge(BuildContext context, Restaurant restaurant) {
    final l = S.of(context);
    final now = DateTime.now();
    final todayHours = _getTodayHours(restaurant, now.weekday);

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
            color: isOpen ? AppColors.success : AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const Gap(4),
        Text(
          isOpen ? l.open : l.closed,
          style: TextStyle(
            color: isOpen ? AppColors.primaryDark : AppColors.error,
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

  OpeningHours? _getTodayHours(Restaurant restaurant, int weekday) {
    try {
      return restaurant.openingHours.firstWhere(
        (h) => h.dayOfWeek == weekday,
      );
    } catch (_) {
      return null;
    }
  }

  Widget _buildAddress(Restaurant restaurant) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined,
            color: AppColors.textSecondary, size: 18),
        const Gap(6),
        Expanded(
          child: Text(
            restaurant.address.fullAddress,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).aboutRestaurant,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Text(
          restaurant.description!,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOpeningHours(BuildContext context, Restaurant restaurant) {
    final l = S.of(context);
    final dayNames = [
      l.dayMonday,
      l.dayTuesday,
      l.dayWednesday,
      l.dayThursday,
      l.dayFriday,
      l.daySaturday,
      l.daySunday,
    ];

    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.openingHoursLabel,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(10),
        ...List.generate(7, (i) {
          final dayDate = monday.add(Duration(days: i));
          final dayOfWeek = i + 1;
          final isToday =
              dayDate.day == now.day && dayDate.month == now.month;
          final dateStr = '${dayDate.day}.${dayDate.month}.';

          final dateIso =
              '${dayDate.year}-${dayDate.month.toString().padLeft(2, '0')}-${dayDate.day.toString().padLeft(2, '0')}';
          final specialDay = restaurant.specialDays
              .where((sd) => sd['date'] == dateIso)
              .firstOrNull;

          String hoursText;
          Color textColor;
          bool isSpecial = false;

          if (specialDay != null) {
            isSpecial = true;
            final isClosed = specialDay['closed'] as bool? ?? true;
            if (isClosed) {
              final note = specialDay['note'] as String?;
              hoursText = 'Zavřeno${note != null ? " — $note" : ""}';
              textColor = AppColors.error;
            } else {
              final open =
                  (specialDay['openAt'] as String?)?.substring(0, 5) ?? '';
              final close =
                  (specialDay['closeAt'] as String?)?.substring(0, 5) ?? '';
              final note = specialDay['note'] as String?;
              hoursText =
                  '$open – $close${note != null ? " — $note" : ""}';
              textColor = Colors.orange.shade700;
            }
          } else {
            final hours = _getTodayHours(restaurant, dayOfWeek);
            hoursText = hours?.formattedHours ?? l.closed;
            textColor =
                isToday ? AppColors.primary : AppColors.textSecondary;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    dateStr,
                    style: TextStyle(
                      fontSize: 12,
                      color: isToday
                          ? AppColors.primary
                          : AppColors.textMuted,
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  child: Text(
                    dayNames[i],
                    style: TextStyle(
                      fontWeight:
                          isToday ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                      color: isToday
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    hoursText,
                    style: TextStyle(
                      fontWeight: isToday || isSpecial
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTags(Restaurant restaurant) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: restaurant.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildReserveButton(BuildContext context, Restaurant restaurant) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  ReservationPage(restaurantId: restaurant.id),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(S.of(context).reserveTable),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tab 1 — Menu
  // ---------------------------------------------------------------------------

  Widget _buildMenuTab(BuildContext context) {
    if (_menuLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_menuError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  size: 48, color: AppColors.error),
              const Gap(16),
              Text(
                _menuError!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: _loadMenu,
                child: Text(S.of(context).retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_menuCategories == null) {
      // Menu se načítá teprve při přepnutí na tab — zobrazíme prázdný stav.
      return Center(
        child: Text(
          S.of(context).menuEmpty,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    if (_menuCategories!.isEmpty) {
      return Center(
        child: Text(
          S.of(context).menuEmpty,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _menuCategories!.length,
      itemBuilder: (context, index) {
        return _MenuCategorySection(category: _menuCategories![index]);
      },
    );
  }
}

/// Záhlaví kategorie a seznam položek menu — pouze pro čtení (bez košíku).
class _MenuCategorySection extends StatelessWidget {
  final MenuCategory category;

  const _MenuCategorySection({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableItems =
        category.items.where((item) => item.available).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            category.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        if (availableItems.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              S.of(context).menuEmpty,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          )
        else
          ...availableItems.map((item) => _MenuItemRow(item: item)),
      ],
    );
  }
}

/// Jeden řádek položky menu: název vlevo, cena vpravo.
class _MenuItemRow extends StatelessWidget {
  final MenuItem item;

  const _MenuItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (item.description != null &&
                    item.description!.isNotEmpty) ...[
                  const Gap(2),
                  Text(
                    item.description!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const Gap(12),
          Text(
            item.formattedPrice,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pomocný delegate pro přichycený TabBar v NestedScrollView
// ---------------------------------------------------------------------------

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) =>
      tabBar != oldDelegate.tabBar;
}

/// Chybový pohled zobrazený, pokud se nepodaří načíst detail restaurace.
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
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const Gap(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      ),
    );
  }
}
