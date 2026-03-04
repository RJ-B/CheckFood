package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantMarkerResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementace služeb pro správu restaurací.
 * Obsahuje logiku pro CRUD operace a pokročilé geoprostorové vyhledávání.
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class RestaurantServiceImpl implements RestaurantService {

    private final RestaurantRepository restaurantRepository;
    private final RestaurantMapper restaurantMapper;
    private final UserService userService;

    // ── Zoom-adaptive clustering configuration ──────────────────────────
    // Each bucket defines: maxZoom (inclusive), radiusPx for DBSCAN, inputLimit
    // for the CTE that feeds DBSCAN, and pointLimit for raw-point mode.
    //
    // | Zoom   | Mode    | radiusPx | inputLimit | pointLimit |
    // |--------|---------|----------|------------|------------|
    // | 0-7    | CLUSTER | 120      | 3000       | n/a        |
    // | 8-10   | CLUSTER | 100      | 4000       | n/a        |
    // | 11-13  | CLUSTER | 60       | 5000       | n/a        |
    // | 14-16  | CLUSTER | 40       | 6000       | n/a        |
    // | 17+    | POINTS  | n/a      | n/a        | 1000       |

    private static final int MAX_CLUSTER_ZOOM = 17;

    private int radiusPxForZoom(int zoom) {
        if (zoom <= 7)  return 120;
        if (zoom <= 10) return 100;
        if (zoom <= 13) return 60;
        return 40; // 14-16
    }

    private int inputLimitForZoom(int zoom) {
        if (zoom <= 7)  return 3000;
        if (zoom <= 10) return 4000;
        if (zoom <= 13) return 5000;
        return 6000; // 14-16
    }

    private int pointLimitForZoom(int zoom) {
        if (zoom <= 17) return 1000;
        return 1500; // very close street view
    }

    // --- CRUD OPERACE (beze změny) ---

    @Override
    public RestaurantResponse createRestaurant(RestaurantRequest request, UUID ownerId) {
        var restaurant = restaurantMapper.toEntity(request);

        restaurant.setOwnerId(ownerId);
        restaurant.setStatus(RestaurantStatus.PENDING);
        restaurant.setActive(true);

        var savedRestaurant = restaurantRepository.save(restaurant);
        return restaurantMapper.toResponse(savedRestaurant);
    }

    @Override
    @Transactional(readOnly = true)
    public RestaurantResponse getRestaurantById(UUID id) {
        return restaurantRepository.findById(id)
                .map(restaurantMapper::toResponse)
                .orElseThrow(() -> RestaurantException.notFound(id));
    }

    @Override
    public RestaurantResponse updateRestaurant(UUID id, RestaurantRequest request, UUID ownerId) {
        var restaurant = restaurantRepository.findById(id)
                .orElseThrow(() -> RestaurantException.notFound(id));

        if (!restaurant.getOwnerId().equals(ownerId)) {
            throw RestaurantException.accessDenied();
        }

        var updatedEntity = restaurantMapper.toEntity(request);
        updatedEntity.setId(restaurant.getId());
        updatedEntity.setOwnerId(restaurant.getOwnerId());
        updatedEntity.setStatus(restaurant.getStatus());
        updatedEntity.setRating(restaurant.getRating());

        var saved = restaurantRepository.save(updatedEntity);
        return restaurantMapper.toResponse(saved);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RestaurantResponse> getMyRestaurants(UUID ownerId) {
        return restaurantRepository.findAllByOwnerId(ownerId).stream()
                .map(restaurantMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteRestaurant(UUID id, UUID ownerId) {
        var restaurant = restaurantRepository.findById(id)
                .orElseThrow(() -> RestaurantException.notFound(id));

        if (!restaurant.getOwnerId().equals(ownerId)) {
            throw RestaurantException.accessDenied();
        }

        restaurant.setActive(false);
        restaurant.setStatus(RestaurantStatus.ARCHIVED);
        restaurantRepository.save(restaurant);
    }

    // --- GEO METODY (POSTGIS SMART CLUSTERING) ---

    /**
     * Vrací shluky (clustery) nebo jednotlivé markery pro zobrazení na mapě.
     * Při zoom >= MAX_CLUSTER_ZOOM vrací přímo jednotlivé body bez shlukování.
     * Jinak vypočítá DBSCAN epsilon z úrovně zoomu pro konzistentní velikost shluků.
     */
    @Override
    @Transactional(readOnly = true)
    public List<RestaurantMarkerResponse> getMarkersInBounds(
            double minLat,
            double maxLat,
            double minLng,
            double maxLng,
            int zoom
    ) {
        long start = System.currentTimeMillis();

        // Street level: raw points without DBSCAN
        if (zoom >= MAX_CLUSTER_ZOOM) {
            int limit = pointLimitForZoom(zoom);
            List<Object[]> raw = restaurantRepository.findMarkersInBounds(
                    minLat, maxLat, minLng, maxLng, limit
            );
            List<RestaurantMarkerResponse> result = restaurantMapper.toMarkerResponseList(raw);
            log.debug("markers zoom={} mode=POINTS limit={} returned={} ms={}",
                    zoom, limit, result.size(), System.currentTimeMillis() - start);
            return result;
        }

        // Adaptive DBSCAN: radius and input limit depend on zoom
        double eps = computeClusterEps(zoom);
        int inputLimit = inputLimitForZoom(zoom);

        List<Object[]> rawResults = restaurantRepository.findClusteredMarkers(
                minLat, maxLat, minLng, maxLng, eps, inputLimit
        );

        List<RestaurantMarkerResponse> result = restaurantMapper.toMarkerResponseList(rawResults);

        // Log cluster stats: max count shows if real counts flow through
        int maxCount = result.stream().mapToInt(RestaurantMarkerResponse::getCount).max().orElse(0);
        int clusterCount = (int) result.stream().filter(RestaurantMarkerResponse::isCluster).count();
        int pointCount = result.size() - clusterCount;
        log.debug("markers zoom={} mode=CLUSTER radiusPx={} eps={} inputLimit={} clusters={} points={} maxCount={} ms={}",
                zoom, radiusPxForZoom(zoom), String.format("%.6f", eps), inputLimit,
                clusterCount, pointCount, maxCount, System.currentTimeMillis() - start);

        return result;
    }

    /**
     * Converts zoom level to DBSCAN epsilon in geographic degrees.
     * Uses zoom-adaptive radiusPx so higher zooms produce tighter, smaller clusters.
     * Formula: eps = radiusPx * 360 / (256 * 2^zoom)
     */
    private double computeClusterEps(int zoom) {
        return radiusPxForZoom(zoom) * 360.0 / (256.0 * Math.pow(2, zoom));
    }

    @Override
    @Transactional(readOnly = true)
    public List<RestaurantResponse> getNearestRestaurants(double userLat, double userLng, int page, int size,
                                                          String searchQuery, List<String> cuisineTypes,
                                                          Double minRating, Boolean openNow) {
        return getNearestRestaurants(userLat, userLng, page, size, searchQuery, cuisineTypes, minRating, openNow, null);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RestaurantResponse> getNearestRestaurants(double userLat, double userLng, int page, int size,
                                                          String searchQuery, List<String> cuisineTypes,
                                                          Double minRating, Boolean openNow,
                                                          Set<UUID> favouriteIds) {
        Pageable pageable = PageRequest.of(page, size);

        return restaurantRepository.findNearestWithFilters(
                        userLat, userLng, searchQuery, cuisineTypes, minRating, openNow, favouriteIds, pageable)
                .stream()
                .map(restaurantMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity resolveUser(String email) {
        return userService.findByEmail(email);
    }
}