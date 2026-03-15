package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface RestaurantRepository extends JpaRepository<Restaurant, UUID>, RestaurantRepositoryCustom {

    // OPRAVENO: Odstraněno "Is". Spring hledá field 'active', ne getter 'isActive'.
    List<Restaurant> findAllByActiveTrueAndStatus(RestaurantStatus status);

    List<Restaurant> findAllByOwnerId(UUID ownerId);

    boolean existsByName(String name);

    boolean existsByIdAndOwnerId(UUID id, UUID ownerId);

    Optional<Restaurant> findByIco(String ico);

    // ===================================================================================
    // SYNCHRONIZACE S OVERTURE MAPS (UPSERT & SOFT-DELETE)
    // ===================================================================================

    /**
     * Dávkové vyhledání restaurací podle jejich unikátního Overture ID.
     * Slouží k detekci, zda má systém provést INSERT nebo UPDATE.
     */
    List<Restaurant> findByOvertureIdIn(Collection<String> overtureIds);

    /**
     * Hromadný Soft-Delete pro zastaralé záznamy z Overture Maps.
     * Anotace @Modifying je nutná, protože tento dotaz mění stav databáze (UPDATE).
     * Hibernate 6 automaticky přeloží řetězec 'CLOSED' na odpovídající Enum hodnotu.
     */
    @Modifying
    @Query("""
            UPDATE Restaurant r SET r.active = false, r.status = 'CLOSED', \
            r.updatedAt = CURRENT_TIMESTAMP \
            WHERE r.overtureId IS NOT NULL AND r.updatedAt < :syncStartTime""")
    int deactivateObsoleteOvertureRestaurants(@Param("syncStartTime") LocalDateTime syncStartTime);

    // ===================================================================================
    // PROSTOROVÉ (SPATIAL) DOTAZY - POSTGIS
    // ===================================================================================

    /**
     * Inteligentní prostorové shlukování (Clustering) na straně databáze.
     * Používá algoritmus DBScan pro seskupení blízkých bodů a výpočet jejich těžiště.
     */
    @Query(value = """
            WITH filtered_restaurants AS (
                SELECT id, location
                FROM restaurant
                WHERE is_active = true
                  AND location && ST_MakeEnvelope(:minLng, :minLat, :maxLng, :maxLat, 4326)
                ORDER BY id
                LIMIT :inputLimit
            ),
            clusters AS (
                SELECT
                    id,
                    location,
                    ST_ClusterDBScan(location, eps := :distance, minpoints := 1) OVER () AS cluster_id
                FROM filtered_restaurants
            )
            SELECT
                CASE WHEN COUNT(*) = 1 THEN CAST(MAX(CAST(id AS TEXT)) AS UUID) ELSE NULL END as id,
                ST_Y(ST_Centroid(ST_Collect(location))) as latitude,
                ST_X(ST_Centroid(ST_Collect(location))) as longitude,
                CAST(COUNT(*) AS INTEGER) as count
            FROM clusters
            GROUP BY cluster_id
            """, nativeQuery = true)
    List<Object[]> findClusteredMarkers(
            @Param("minLat") double minLat,
            @Param("maxLat") double maxLat,
            @Param("minLng") double minLng,
            @Param("maxLng") double maxLng,
            @Param("distance") double distance,
            @Param("inputLimit") int inputLimit
    );

    /**
     * Vrací jednotlivé body (bez shlukování) pro vysoké úrovně zoomu.
     * Používá se při zoom >= MAX_CLUSTER_ZOOM, kdy je DBSCAN zbytečný.
     */
    @Query(value = """
            SELECT id, ST_Y(location) as latitude, ST_X(location) as longitude,
                   CAST(1 AS INTEGER) as count
            FROM restaurant
            WHERE is_active = true
              AND location && ST_MakeEnvelope(:minLng, :minLat, :maxLng, :maxLat, 4326)
            ORDER BY id
            LIMIT :pointLimit
            """, nativeQuery = true)
    List<Object[]> findMarkersInBounds(
            @Param("minLat") double minLat,
            @Param("maxLat") double maxLat,
            @Param("minLng") double minLng,
            @Param("maxLng") double maxLng,
            @Param("pointLimit") int pointLimit
    );

    /**
     * Nativní PostGIS dotaz pro nejbližší restaurace pomocí K-NN.
     */
    @Query(value = """
            SELECT * FROM restaurant r
            WHERE r.is_active = true
            ORDER BY r.location <-> ST_SetSRID(ST_MakePoint(:lng, :lat), 4326)
            """,
            countQuery = "SELECT count(*) FROM restaurant r WHERE r.is_active = true",
            nativeQuery = true)
    Page<Restaurant> findNearestRestaurants(
            @Param("lat") double lat,
            @Param("lng") double lng,
            Pageable pageable
    );
}