import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:gap/gap.dart';

import '../../../../../components/dialogs/location_permission_dialog.dart';
import '../../data/models/request/map_params_model.dart';
import '../../domain/entities/cuisine_type.dart';
import '../../domain/entities/restaurant_filters.dart';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/entities/explore_data.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';
import '../widgets/restaurant_card.dart';
import '../utils/map_marker_helper.dart';
import '../../../../../core/utils/location_service.dart';
import 'restaurant_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final Completer<GoogleMapController> _mapController = Completer();
  final PanelController _panelController = PanelController();
  final TextEditingController _searchController = TextEditingController();

  // --- STAV MAPY ---
  Set<Marker> _markers = {};
  double _currentZoom = 14.0;
  bool _initialCameraSet = false;
  String? _mapStyle;

  // --- VIEWPORT BUFFER ---
  LatLngBounds? _lastFetchedBounds;
  int? _lastFetchedZoom;

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(const ExploreEvent.initializeRequested());
    rootBundle.loadString('assets/map_style.json').then((style) {
      _mapStyle = style;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _updateMarkers(List<RestaurantMarker> backendMarkers) async {
    final Set<Marker> freshMarkers = {};
    final zoom = _currentZoom.round();

    final List<Future<void>> markerTasks =
        backendMarkers.map((item) async {
          if (item.isCluster) {
            final clusterId =
                'cluster_${(item.latitude * 100000).round()}_${(item.longitude * 100000).round()}';

            final iconSize = MapMarkerHelper.clusterIconSize(item.count, zoom: zoom);
            final label = item.count > 999 ? '999+' : item.count.toString();

            final icon = await MapMarkerHelper.getClusterBitmap(
              iconSize,
              text: label,
            );

            freshMarkers.add(
              Marker(
                markerId: MarkerId(clusterId),
                position: LatLng(item.latitude, item.longitude),
                icon: icon,
                zIndexInt: 2,
                onTap: () => _zoomIntoCluster(item),
              ),
            );
          } else {
            freshMarkers.add(
              Marker(
                markerId: MarkerId(item.id ?? 'unknown'),
                position: LatLng(item.latitude, item.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
                zIndexInt: 1,
                onTap: () => _onPinClicked(item.id),
              ),
            );
          }
        }).toList();

    await Future.wait(markerTasks);

    if (mounted) {
      setState(() {
        _markers = freshMarkers;
      });
    }
  }

  Future<void> _zoomIntoCluster(RestaurantMarker cluster) async {
    final controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(cluster.latitude, cluster.longitude),
        _currentZoom + 2.5,
      ),
    );
  }

  void _onPinClicked(String? restaurantId) {
    if (restaurantId == null) return;
    _openRestaurantDetail(restaurantId);
  }

  void _openRestaurantDetail(String restaurantId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RestaurantDetailPage(restaurantId: restaurantId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExploreBloc, ExploreState>(
        listener: (context, state) {
          state.whenOrNull(
            permissionRequired: () => _showPermissionDialog(context),
            loaded: (data) {
              if (!_initialCameraSet) {
                _moveCameraToUser(
                  data.userPosition.latitude,
                  data.userPosition.longitude,
                );
                _initialCameraSet = true;
              }
              _updateMarkers(data.markers);
            },
            error:
                (message) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red),
                ),
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (data) => _buildMainUI(data),
            error: (message) => _buildErrorUI(message),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildMainUI(ExploreData data) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    const panelHeightClosed = 200.0;

    return Stack(
      children: [
        SlidingUpPanel(
          controller: _panelController,
          maxHeight: panelHeightOpen,
          minHeight: panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: .5,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                data.userPosition.latitude,
                data.userPosition.longitude,
              ),
              zoom: _currentZoom,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            style: _mapStyle,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
            onCameraMove: (position) {
              _currentZoom = position.zoom;
            },
            onCameraIdle: () {
              _onMapBoundsChanged();
            },
          ),
          panelBuilder: (sc) => _buildRestaurantList(sc, data),
        ),
        // Search bar + filter chips
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: _buildTopSearchBar(data.filters),
        ),
        Positioned(
          right: 16,
          bottom: panelHeightClosed + 16,
          child: FloatingActionButton.small(
            heroTag: 'myLocation',
            backgroundColor: Colors.white,
            onPressed: _centerOnUser,
            child: const Icon(Icons.my_location, color: Colors.teal),
          ),
        ),
        _buildMapLoadingIndicator(data.isMapLoading),
      ],
    );
  }

  Future<void> _centerOnUser() async {
    try {
      final position = await LocationService().getCurrentLocation();
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Nelze zjistit polohu. Zkontrolujte opravneni.'),
            action: SnackBarAction(
              label: 'Nastaveni',
              onPressed: () => Geolocator.openAppSettings(),
            ),
          ),
        );
      }
    }
  }

  Widget _buildMapLoadingIndicator(bool isLoading) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: isLoading ? MediaQuery.of(context).padding.top + 75 : -50,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              ),
              Gap(10),
              Text(
                "Updating map...",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantList(ScrollController sc, ExploreData data) {
    sc.addListener(() {
      if (sc.position.pixels >= sc.position.maxScrollExtent - 200) {
        context.read<ExploreBloc>().add(const ExploreEvent.loadMoreRequested());
      }
    });

    return Column(
      children: [
        const Gap(12),
        _buildPanelHandle(),
        const Gap(12),
        _buildFilterChips(data.filters),
        const Gap(8),
        Expanded(
          child: data.nearestRestaurants.isEmpty && !data.isPaginationLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'Zadne restaurace nenalezeny.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                )
              : ListView.builder(
                  controller: sc,
                  itemCount:
                      data.nearestRestaurants.length +
                      (data.isPaginationLoading ? 1 : 0),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    if (index < data.nearestRestaurants.length) {
                      final restaurant = data.nearestRestaurants[index];
                      return RestaurantCard(
                        restaurant: restaurant,
                        onTap: () => _openRestaurantDetail(restaurant.id),
                      );
                    }
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _onMapBoundsChanged() async {
    final controller = await _mapController.future;
    final bounds = await controller.getVisibleRegion();
    final zoom = _currentZoom.round();

    final zoomUnchanged = _lastFetchedZoom == zoom;
    if (zoomUnchanged &&
        _lastFetchedBounds != null &&
        _isContained(bounds, _lastFetchedBounds!)) {
      dev.log('viewport skip: zoom=$zoom (contained in buffer)', name: 'CheckFood.Map');
      return;
    }

    final bufferedBounds = _expandBounds(bounds, 0.3);
    _lastFetchedBounds = bufferedBounds;
    _lastFetchedZoom = zoom;

    if (mounted) {
      context.read<ExploreBloc>().add(
        ExploreEvent.mapBoundsChanged(
          params: MapParamsModel(bounds: bufferedBounds, zoom: zoom),
        ),
      );
    }
  }

  bool _isContained(LatLngBounds inner, LatLngBounds outer) {
    return inner.southwest.latitude >= outer.southwest.latitude &&
        inner.southwest.longitude >= outer.southwest.longitude &&
        inner.northeast.latitude <= outer.northeast.latitude &&
        inner.northeast.longitude <= outer.northeast.longitude;
  }

  LatLngBounds _expandBounds(LatLngBounds bounds, double factor) {
    final latDelta =
        (bounds.northeast.latitude - bounds.southwest.latitude) * factor;
    final lngDelta =
        (bounds.northeast.longitude - bounds.southwest.longitude) * factor;
    return LatLngBounds(
      southwest: LatLng(
        bounds.southwest.latitude - latDelta,
        bounds.southwest.longitude - lngDelta,
      ),
      northeast: LatLng(
        bounds.northeast.latitude + latDelta,
        bounds.northeast.longitude + lngDelta,
      ),
    );
  }

  Future<void> _moveCameraToUser(double lat, double lng) async {
    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15));
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => LocationPermissionDialog(
            onConfirm: () {
              Navigator.pop(context);
              context.read<ExploreBloc>().add(
                const ExploreEvent.permissionResultReceived(granted: true),
              );
            },
            onCancel: () {
              Navigator.pop(context);
              context.read<ExploreBloc>().add(
                const ExploreEvent.permissionResultReceived(granted: false),
              );
            },
          ),
    );
  }

  // --- UI WIDGETS ---

  Widget _buildTopSearchBar(RestaurantFilters filters) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Hledat restaurace...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (value) {
                context.read<ExploreBloc>().add(
                  ExploreEvent.searchChanged(query: value),
                );
              },
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                context.read<ExploreBloc>().add(
                  const ExploreEvent.searchChanged(query: ''),
                );
              },
              child: const Icon(Icons.close, color: Colors.grey, size: 20),
            ),
          if (filters.hasActiveFilters)
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${filters.activeFilterCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(RestaurantFilters filters) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildToggleChip(
            label: 'Oblibene',
            icon: Icons.favorite,
            selected: filters.favouritesOnly,
            onTap: () {
              final newFilters = filters.copyWith(
                favouritesOnly: !filters.favouritesOnly,
              );
              context.read<ExploreBloc>().add(
                ExploreEvent.filtersChanged(filters: newFilters),
              );
            },
          ),
          const SizedBox(width: 8),
          _buildToggleChip(
            label: 'Otevreno',
            icon: Icons.access_time,
            selected: filters.openNow,
            onTap: () {
              final newFilters = filters.copyWith(
                openNow: !filters.openNow,
              );
              context.read<ExploreBloc>().add(
                ExploreEvent.filtersChanged(filters: newFilters),
              );
            },
          ),
          const SizedBox(width: 8),
          _buildRatingChip(filters),
          const SizedBox(width: 8),
          _buildCuisineChip(filters),
        ],
      ),
    );
  }

  Widget _buildToggleChip({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.teal : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingChip(RestaurantFilters filters) {
    final hasRating = filters.minRating != null;
    return GestureDetector(
      onTap: () {
        _showRatingPicker(filters);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: hasRating ? Colors.teal : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasRating ? Colors.teal : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: 16,
              color: hasRating ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              hasRating ? '${filters.minRating!.toStringAsFixed(0)}+' : 'Hodnoceni',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: hasRating ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuisineChip(RestaurantFilters filters) {
    final hasCuisine = filters.cuisineTypes.isNotEmpty;
    return GestureDetector(
      onTap: () {
        _showCuisinePicker(filters);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: hasCuisine ? Colors.teal : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasCuisine ? Colors.teal : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 16,
              color: hasCuisine ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              hasCuisine
                  ? '${filters.cuisineTypes.length} kuchyne'
                  : 'Kuchyne',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: hasCuisine ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingPicker(RestaurantFilters filters) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Minimalni hodnoceni',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              for (final rating in [3.0, 3.5, 4.0, 4.5])
                ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber),
                  title: Text('${rating.toStringAsFixed(1)}+'),
                  selected: filters.minRating == rating,
                  onTap: () {
                    Navigator.pop(ctx);
                    final newFilters = filters.copyWith(minRating: rating);
                    context.read<ExploreBloc>().add(
                      ExploreEvent.filtersChanged(filters: newFilters),
                    );
                  },
                ),
              if (filters.minRating != null)
                ListTile(
                  leading: const Icon(Icons.clear),
                  title: const Text('Zrusit filtr'),
                  onTap: () {
                    Navigator.pop(ctx);
                    final newFilters = filters.copyWith(minRating: null);
                    context.read<ExploreBloc>().add(
                      ExploreEvent.filtersChanged(filters: newFilters),
                    );
                  },
                ),
              const Gap(8),
            ],
          ),
        );
      },
    );
  }

  void _showCuisinePicker(RestaurantFilters filters) {
    final selected = Set<CuisineType>.from(filters.cuisineTypes);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return SafeArea(
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.85,
                minChildSize: 0.4,
                expand: false,
                builder: (_, scrollCtrl) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Typ kuchyne',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                final newFilters = filters.copyWith(
                                  cuisineTypes: selected.toList(),
                                );
                                context.read<ExploreBloc>().add(
                                  ExploreEvent.filtersChanged(
                                    filters: newFilters,
                                  ),
                                );
                              },
                              child: const Text('Potvrdit'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollCtrl,
                          children: CuisineType.values.map((type) {
                            final isSelected = selected.contains(type);
                            return CheckboxListTile(
                              title: Text(type.displayName),
                              value: isSelected,
                              onChanged: (val) {
                                setModalState(() {
                                  if (val == true) {
                                    selected.add(type);
                                  } else {
                                    selected.remove(type);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPanelHandle() {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildErrorUI(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const Gap(16),
          Text("Chyba: $message"),
          const Gap(16),
          ElevatedButton(
            onPressed:
                () => context.read<ExploreBloc>().add(
                  const ExploreEvent.initializeRequested(),
                ),
            child: const Text("Zkusit znovu"),
          ),
        ],
      ),
    );
  }
}
