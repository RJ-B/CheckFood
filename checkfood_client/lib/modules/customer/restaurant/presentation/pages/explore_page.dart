import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:gap/gap.dart';

import '../../../../../components/dialogs/location_permission_dialog.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/entities/explore_data.dart';
import '../../domain/entities/restaurant.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';
import '../widgets/place_card.dart';
import '../utils/map_marker_helper.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/location_service.dart';
import 'restaurant_detail_page.dart';

/// Celoobrazkový pohled mapy pro objevování restaurací v okolí, s klientským
/// clusterováním markerů, vysouvacím panelem seznamu restaurací a textovým vyhledáváním.
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

/// Stav pro [ExplorePage]: spravuje controller Google Maps, animace panelu,
/// vstup vyhledávání a životní cyklus clusterování markerů.
class _ExplorePageState extends State<ExplorePage> with TickerProviderStateMixin {
  GoogleMapController? _googleMapController;
  final PanelController _panelController = PanelController();
  final TextEditingController _searchController = TextEditingController();
  late final ScrollController _listScrollController;

  Set<Marker> _markers = {};
  double _currentZoom = 14.0;
  bool _initialCameraSet = false;
  String? _mapStyle;
  bool _panelFullyOpen = false;
  bool _showDebugPanel = false;
  double _debugClusterRadius = 30.0;
  bool _debugRadiusOverride = false;

  late final AnimationController _fadeController;
  double? _previousZoomForFade;

  @override
  void initState() {
    super.initState();

    _listScrollController = ScrollController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    context.read<ExploreBloc>().add(const ExploreEvent.initializeRequested());

    rootBundle.loadString('assets/map_style.json').then((style) {
      if (mounted) setState(() => _mapStyle = style);
    });

    MapMarkerHelper.preGeneratePins();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _searchController.dispose();
    _listScrollController.dispose();
    _googleMapController?.dispose();
    super.dispose();
  }

  List<RestaurantMarker>? _lastBackendMarkers;
  String? _lastSelectedId;

  Future<void> _updateMarkers(
    List<RestaurantMarker> backendMarkers,
    String? selectedRestaurantId,
  ) async {
    if (identical(_lastBackendMarkers, backendMarkers) &&
        _lastSelectedId == selectedRestaurantId) {
      return;
    }
    _lastBackendMarkers = backendMarkers;
    _lastSelectedId = selectedRestaurantId;

    final Set<Marker> freshMarkers = {};
    final zoom = _currentZoom.floor();

    final List<Future<void>> markerTasks = backendMarkers.map((item) async {
      if (item.isCluster) {
        final clusterId =
            'cluster_${(item.latitude * 100000).round()}_${(item.longitude * 100000).round()}';

        final iconSize =
            MapMarkerHelper.clusterIconSize(item.count, zoom: zoom);
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
        final isSelected = item.id == selectedRestaurantId;

        final icon = await MapMarkerHelper.getRestaurantBitmap(
          id: item.id ?? 'unknown',
          name: item.name,
          logoUrl: item.logoUrl,
          isSelected: isSelected,
        );

        freshMarkers.add(
          Marker(
            markerId: MarkerId(item.id ?? 'unknown'),
            position: LatLng(item.latitude, item.longitude),
            icon: icon,
            zIndexInt: isSelected ? 3 : 1,
            onTap: () => _onPinTapped(item.id),
          ),
        );
      }
    }).toList();

    await Future.wait(markerTasks);

    if (!mounted) return;

    final zoomChanged = _previousZoomForFade != null &&
        (_previousZoomForFade! - _currentZoom).abs() >= 0.5;
    _previousZoomForFade = _currentZoom;

    if (zoomChanged && _markers.isNotEmpty) {
      setState(() => _markers = _setAlpha(_markers, 0.01));
      await Future.delayed(const Duration(milliseconds: 80));
      if (!mounted) return;
      setState(() => _markers = _setAlpha(freshMarkers, 0.01));
      await Future.delayed(const Duration(milliseconds: 40));
      if (!mounted) return;
      setState(() => _markers = freshMarkers);
    } else {
      setState(() => _markers = freshMarkers);
    }
  }

  /// Vytvoří kopii markerů se zadanou hodnotou alfa. Levné — bez regenerace bitmapy.
  Set<Marker> _setAlpha(Set<Marker> markers, double alpha) {
    return markers.map((m) => Marker(
      markerId: m.markerId,
      position: m.position,
      icon: m.icon,
      alpha: alpha.clamp(0.01, 1.0),
      zIndexInt: m.zIndexInt,
      onTap: m.onTap,
    )).toSet();
  }


  Future<void> _zoomIntoCluster(RestaurantMarker cluster) async {
    _googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(cluster.latitude, cluster.longitude),
        _currentZoom + 2.5,
      ),
    );
  }

  void _onPinTapped(String? restaurantId) {
    if (restaurantId == null) return;
    context.read<ExploreBloc>().add(
          ExploreEvent.markerSelected(restaurantId: restaurantId),
        );
  }

  void _deselectMarker() {
    context.read<ExploreBloc>().add(
          const ExploreEvent.markerSelected(restaurantId: null),
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
              _updateMarkers(data.markers, data.selectedRestaurantId);
            },
            error: (message) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error,
              ),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final panelHeightOpen = screenHeight * 0.8;
    const panelHeightClosed = 60.0;
    final snapFraction = 200.0 / panelHeightOpen;

    return Stack(
      children: [
        SlidingUpPanel(
          controller: _panelController,
          maxHeight: panelHeightOpen,
          minHeight: panelHeightClosed,
          snapPoint: snapFraction,
          defaultPanelState: PanelState.CLOSED,
          parallaxEnabled: true,
          parallaxOffset: .5,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
          onPanelSlide: (position) {
            final isOpen = position >= 0.99;
            if (isOpen != _panelFullyOpen) {
              setState(() => _panelFullyOpen = isOpen);
            }
          },
          body: GestureDetector(
            onTap: data.selectedRestaurantId != null ? _deselectMarker : null,
            child: GoogleMap(
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
                _googleMapController = controller;
              },
              onCameraMove: (position) {
                _currentZoom = position.zoom;
                if (_showDebugPanel) {
                  setState(() {});
                }
              },
              onCameraIdle: () {
                _onMapBoundsChanged();
              },
            ),
          ),
          panelBuilder: (_) => _buildRestaurantList(data),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: _buildTopSearchBar(),
        ),
        Positioned(
          right: 16,
          bottom: panelHeightClosed + 16,
          child: FloatingActionButton.small(
            heroTag: 'myLocation',
            backgroundColor: Colors.white,
            onPressed: _centerOnUser,
            child: const Icon(Icons.my_location, color: AppColors.primary),
          ),
        ),
        _buildMapLoadingIndicator(data.isMapLoading),
        Positioned(
          left: 16,
          bottom: panelHeightClosed + 16,
          child: FloatingActionButton.small(
            heroTag: 'debugToggle',
            backgroundColor: _showDebugPanel ? AppColors.primary : Colors.white,
            onPressed: () => setState(() => _showDebugPanel = !_showDebugPanel),
            child: Icon(Icons.tune, color: _showDebugPanel ? Colors.white : AppColors.textMuted),
          ),
        ),
        if (_showDebugPanel)
          Positioned(
            left: 16,
            right: 16,
            bottom: panelHeightClosed + 60,
            child: _buildDebugPanel(),
          ),
      ],
    );
  }

  double _computeGaussianRadius(double zoom) {
    return context.read<ExploreBloc>().clusterManager.dynamicRadiusPx(zoom);
  }

  Widget _buildDebugPanel() {
    final gaussianRadius = _computeGaussianRadius(_currentZoom);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'zoom: ${_currentZoom.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              Text(
                'Gauss: ${gaussianRadius.toStringAsFixed(1)}px',
                style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
              if (_debugRadiusOverride) ...[
                const SizedBox(width: 8),
                Text(
                  '→ override: ${_debugClusterRadius.round()}px',
                  style: const TextStyle(fontSize: 12, color: AppColors.error, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Radius:', style: TextStyle(fontSize: 11)),
              Expanded(
                child: Slider(
                  value: _debugClusterRadius,
                  min: 1,
                  max: 100,
                  divisions: 99,
                  label: _debugClusterRadius.round().toString(),
                  onChanged: (v) => setState(() => _debugClusterRadius = v),
                ),
              ),
              Text(
                '${_debugClusterRadius.round()}px',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_debugRadiusOverride)
                TextButton(
                  onPressed: () {
                    setState(() => _debugRadiusOverride = false);
                    context.read<ExploreBloc>().clusterManager.radiusOverride = null;
                    MapMarkerHelper.clearCache();
                    _onMapBoundsChanged();
                  },
                  child: const Text('Zrušit override', style: TextStyle(fontSize: 12)),
                ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  setState(() => _debugRadiusOverride = true);
                  context.read<ExploreBloc>().clusterManager.radiusOverride = _debugClusterRadius;
                  MapMarkerHelper.clearCache();
                  _onMapBoundsChanged();
                },
                child: const Text('Použít', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInlineRestaurantPreview(ExploreData data) {
    final restaurant = data.selectedRestaurant!;
    final imageUrl = restaurant.coverImageUrl ?? restaurant.logoUrl;
    final address = restaurant.address.fullAddress;

    return GestureDetector(
      onTap: () => _navigateToDetail(restaurant.id),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 48,
                height: 48,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _previewPlaceholder(),
                      )
                    : _previewPlaceholder(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (address.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      address,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (restaurant.rating != null) ...[
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          restaurant.rating!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: _deselectMarker,
              child: const Icon(Icons.close, size: 18, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewPlaceholder() {
    return Container(
      color: AppColors.borderLight,
      child: const Icon(
        Icons.restaurant,
        color: AppColors.textMuted,
        size: 24,
      ),
    );
  }

  Future<void> _centerOnUser() async {
    try {
      final position = await LocationService().getCurrentLocation();
      _googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).cannotGetLocation),
            action: SnackBarAction(
              label: S.of(context).settings,
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              Gap(10),
              Text(
                'Aktualizuji mapu...',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantList(ExploreData data) {
    final hasMore = data.restaurants.length >= 20;

    return Column(
      children: [
        const Gap(12),
        _buildPanelHandle(),
        if (data.selectedRestaurant != null)
          _buildInlineRestaurantPreview(data),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Restaurace v okolí',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                hasMore
                    ? '20+ nalezeno'
                    : '${data.restaurants.length} nalezeno',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        if (hasMore)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
            child: Row(
              children: [
                const Icon(Icons.zoom_in, size: 14, color: AppColors.primary),
                const SizedBox(width: 4),
                const Text(
                  'Přibližte mapu pro zobrazení dalších',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        const Gap(8),
        Expanded(
          child: data.restaurants.isEmpty && !data.isMapLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'Žádné restaurace nenalezeny.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _listScrollController,
                  physics: _panelFullyOpen
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemCount: data.restaurants.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final restaurant = data.restaurants[index];
                    return RestaurantListCard(
                      restaurant: restaurant,
                      onTap: () => _selectRestaurantFromList(restaurant),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _selectRestaurantFromList(Restaurant restaurant) {
    _panelController.close();
    _googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(restaurant.address.latitude ?? 0, restaurant.address.longitude ?? 0),
        18.0,
      ),
    );
    context.read<ExploreBloc>().add(
      ExploreEvent.markerSelected(restaurantId: restaurant.id),
    );
  }

  void _navigateToDetail(String restaurantId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RestaurantDetailPage(restaurantId: restaurantId),
      ),
    );
  }

  void _onMapBoundsChanged({bool forceRefresh = false}) async {
    if (_googleMapController == null) return;
    final bounds = await _googleMapController!.getVisibleRegion();
    final zoom = _currentZoom.floor();

    if (forceRefresh) {
      MapMarkerHelper.clearCache();
    }

    if (mounted) {
      context.read<ExploreBloc>().add(
        ExploreEvent.viewportChanged(
          minLat: bounds.southwest.latitude,
          maxLat: bounds.northeast.latitude,
          minLng: bounds.southwest.longitude,
          maxLng: bounds.northeast.longitude,
          zoom: zoom,
        ),
      );
    }
  }

  Future<void> _moveCameraToUser(double lat, double lng) async {
    _googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationPermissionDialog(
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

  Widget _buildTopSearchBar() {
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
          const Icon(Icons.search, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: S.of(context).searchRestaurants,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
              child: const Icon(
                Icons.close,
                color: AppColors.textMuted,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPanelHandle() {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildErrorUI(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const Gap(16),
          Text(S.of(context).errorGeneric(message)),
          const Gap(16),
          ElevatedButton(
            onPressed: () => context.read<ExploreBloc>().add(
                  const ExploreEvent.initializeRequested(),
                ),
            child: Text(S.of(context).retry),
          ),
        ],
      ),
    );
  }
}
