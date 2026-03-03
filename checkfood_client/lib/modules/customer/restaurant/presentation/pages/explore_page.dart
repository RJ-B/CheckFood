import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:gap/gap.dart';

import '../../../../../components/dialogs/location_permission_dialog.dart';
import '../../data/models/request/map_params_model.dart';
import '../../domain/entities/restaurant_marker.dart';
import '../../domain/entities/explore_data.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';
import '../widgets/restaurant_card.dart';
import '../utils/map_marker_helper.dart';
import 'restaurant_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final Completer<GoogleMapController> _mapController = Completer();
  final PanelController _panelController = PanelController();

  // --- STAV MAPY ---
  Set<Marker> _markers = {};
  double _currentZoom = 14.0;
  bool _initialCameraSet = false;

  // --- VIEWPORT BUFFER ---
  LatLngBounds? _lastFetchedBounds;
  int? _lastFetchedZoom;

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(const ExploreEvent.initializeRequested());
  }

  /// Atomic marker update: prepares the full marker set asynchronously,
  /// then swaps it in a single setState to avoid flickering.
  Future<void> _updateMarkers(List<RestaurantMarker> backendMarkers) async {
    final Set<Marker> freshMarkers = {};

    final List<Future<void>> markerTasks =
        backendMarkers.map((item) async {
          if (item.isCluster) {
            // Stable cluster ID based on coordinates (~11 m precision)
            final clusterId =
                'cluster_${(item.latitude * 100000).round()}_${(item.longitude * 100000).round()}';

            // Icon size scales with real count for density distinction
            final iconSize = MapMarkerHelper.clusterIconSize(item.count);

            final icon = await MapMarkerHelper.getClusterBitmap(
              iconSize,
              text: item.clusterLabel,
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
              // Aktualizace markerů probíhá na pozadí bez blokování UI
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
        // Horní vyhledávací lišta
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          right: 16,
          child: _buildTopSearchBar(),
        ),
        // ✅ NOVÉ: Indikátor aktualizace mapy na pozadí
        _buildMapLoadingIndicator(data.isMapLoading),
      ],
    );
  }

  /// Elegantní indikátor načítání v horní části mapy
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
        const Gap(18),
        _buildPanelHeader(),
        Expanded(
          child: ListView.builder(
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

    // Skip API call only when zoom is unchanged AND visible area fits
    // inside the previously fetched buffer. A zoom change always triggers
    // a re-fetch because server-side clustering parameters change with zoom.
    final zoomUnchanged = _lastFetchedZoom == zoom;
    if (zoomUnchanged &&
        _lastFetchedBounds != null &&
        _isContained(bounds, _lastFetchedBounds!)) {
      dev.log('viewport skip: zoom=$zoom (contained in buffer)', name: 'CheckFood.Map');
      return;
    }

    // Expand bounds by 30% as buffer for small panning movements
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

  /// Checks whether [inner] bounds are fully contained within [outer] bounds.
  bool _isContained(LatLngBounds inner, LatLngBounds outer) {
    return inner.southwest.latitude >= outer.southwest.latitude &&
        inner.southwest.longitude >= outer.southwest.longitude &&
        inner.northeast.latitude <= outer.northeast.latitude &&
        inner.northeast.longitude <= outer.northeast.longitude;
  }

  /// Expands [bounds] by [factor] (0.3 = 30%) in each direction.
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

  // --- UI WIDGETY ---

  Widget _buildTopSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Text(
            "Search for restaurants...",
            style: TextStyle(color: Colors.grey),
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
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildPanelHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Best places nearby",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Row(
            children: [
              Icon(Icons.search, color: Colors.teal),
              SizedBox(width: 16),
              Icon(Icons.tune, color: Colors.teal),
            ],
          ),
        ],
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
