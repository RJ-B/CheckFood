package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.AllMarkersResponse;
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
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

/**
 * Implementace {@link RestaurantService} pro správu restaurací.
 * Obsahuje logiku pro CRUD operace, pokročilé geoprostorové vyhledávání a správu verzí markerů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class RestaurantServiceImpl implements RestaurantService {

    private final RestaurantRepository restaurantRepository;
    private final RestaurantMapper restaurantMapper;
    private final UserService userService;

    private final AtomicLong markerVersion = new AtomicLong(1);
    private volatile List<RestaurantMarkerResponse> cachedAllMarkers;
    private volatile long cacheTimestamp;
    private static final long CACHE_TTL_MS = 300_000;

    /** Od tohoto zoomu se vrací přímo jednotlivé body bez DBSCAN shlukování. */
    private static final int MAX_CLUSTER_ZOOM = 19;

    /**
     * Vypočítá dynamický poloměr shlukování v pixelech pomocí asymetrické Gaussovy funkce.
     * Vrchol je na zoom 13 (~42px). Strmý nárůst vlevo (sigma=0.9), pozvolný pokles vpravo (sigma=5.0).
     * Baseline=22px, amplituda=20px.
     *
     * @param zoom úroveň přiblížení mapy
     * @return poloměr shlukování v pixelech
     */
    private double dynamicRadiusPx(double zoom) {
        double peak = 13.0;
        double diff = zoom - peak;
        double sigma = diff < 0 ? 0.9 : 5.0; // strmý nárůst vlevo, pozvolný pokles vpravo
        return 22.0 + 20.0 * Math.exp(-(diff * diff) / (2.0 * sigma * sigma));
    }

    /**
     * Vrátí limit vstupních bodů pro DBSCAN CTE. Roste lineárně se zoomem.
     *
     * @param zoom úroveň přiblížení mapy
     * @return maximální počet restaurací vstupujících do shlukování
     */
    private int inputLimitForZoom(int zoom) {
        return Math.min(2000 + zoom * 400, 10000);
    }

    /**
     * Vrátí limit bodů pro přímý výpis (bez shlukování) na vysokých zoomech.
     *
     * @param zoom úroveň přiblížení mapy
     * @return maximální počet vrácených bodů
     */
    private int pointLimitForZoom(int zoom) {
        return 1500;
    }

    @Override
    public RestaurantResponse createRestaurant(RestaurantRequest request, UUID ownerId) {
        var restaurant = restaurantMapper.toEntity(request);

        restaurant.setOwnerId(ownerId);
        restaurant.setStatus(RestaurantStatus.PENDING);
        restaurant.setActive(true);

        var savedRestaurant = restaurantRepository.save(restaurant);
        incrementMarkerVersion();
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
        incrementMarkerVersion();
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
        incrementMarkerVersion();
    }

    @Override
    @Transactional(readOnly = true)
    public AllMarkersResponse getAllActiveMarkers() {
        if (cachedAllMarkers != null && System.currentTimeMillis() - cacheTimestamp < CACHE_TTL_MS) {
            return AllMarkersResponse.builder()
                    .version(markerVersion.get())
                    .data(cachedAllMarkers)
                    .build();
        }
        List<Object[]> raw = restaurantRepository.findAllActiveMarkers();
        cachedAllMarkers = restaurantMapper.toMarkerResponseList(raw);
        cacheTimestamp = System.currentTimeMillis();
        return AllMarkersResponse.builder()
                .version(markerVersion.get())
                .data(cachedAllMarkers)
                .build();
    }

    @Override
    public long getMarkerVersion() {
        return markerVersion.get();
    }

    @Override
    public void incrementMarkerVersion() {
        markerVersion.incrementAndGet();
        cachedAllMarkers = null;
    }

    /**
     * {@inheritDoc}
     * Při zoom >= MAX_CLUSTER_ZOOM vrací přímo jednotlivé body bez DBSCAN shlukování.
     * Na nižších zoomech vypočítá epsilon z pixelového poloměru a spustí DBSCAN na straně databáze.
     */
    @Override
    @Transactional(readOnly = true)
    public List<RestaurantMarkerResponse> getMarkersInBounds(
            double minLat,
            double maxLat,
            double minLng,
            double maxLng,
            int zoom,
            Double clusterRadius
    ) {
        double effectiveRadius = (clusterRadius != null) ? clusterRadius : dynamicRadiusPx(zoom);

        // Úroveň ulice: přímé body bez DBSCAN
        if (zoom >= MAX_CLUSTER_ZOOM) {
            int limit = pointLimitForZoom(zoom);
            List<Object[]> raw = restaurantRepository.findMarkersInBounds(
                    minLat, maxLat, minLng, maxLng, limit
            );
            List<RestaurantMarkerResponse> result = restaurantMapper.toMarkerResponseList(raw);
            return result;
        }

        // Adaptivní DBSCAN: poloměr a vstupní limit závisí na úrovni zoomu
        double eps = computeClusterEps(zoom, effectiveRadius);
        int inputLimit = inputLimitForZoom(zoom);

        List<Object[]> rawResults = restaurantRepository.findClusteredMarkers(
                minLat, maxLat, minLng, maxLng, eps, inputLimit
        );

        List<RestaurantMarkerResponse> result = restaurantMapper.toMarkerResponseList(rawResults);

        return result;
    }

    /**
     * Převede pixelový poloměr shlukování na geografické stupně pro daný zoom.
     * Vzorec: eps = radiusPx * 360 / (256 * 2^zoom)
     *
     * @param zoom     úroveň přiblížení mapy
     * @param radiusPx poloměr shlukování v pixelech
     * @return epsilon pro DBSCAN v geografických stupních
     */
    private double computeClusterEps(int zoom, double radiusPx) {
        return radiusPx * 360.0 / (256.0 * Math.pow(2, zoom));
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