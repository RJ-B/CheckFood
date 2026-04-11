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

/**
 * Repozitář pro správu entit restaurací. Kombinuje standardní JPA operace se specializovanými
 * prostorovými dotazy PostGIS a podporou synchronizace s Overture Maps.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface RestaurantRepository extends JpaRepository<Restaurant, UUID>, RestaurantRepositoryCustom {

    /**
     * Načte všechny aktivní restaurace s daným statusem.
     *
     * @param status požadovaný status restaurace
     * @return seznam aktivních restaurací
     */
    List<Restaurant> findAllByActiveTrueAndStatus(RestaurantStatus status);

    /**
     * Ověří, zda restaurace s daným názvem již existuje.
     *
     * @param name název restaurace
     * @return {@code true} pokud restaurace s tímto názvem existuje
     */
    boolean existsByName(String name);

    // findAllByOwnerId + existsByIdAndOwnerId removed Apr 2026.
    // Ownership is now resolved via RestaurantEmployeeRepository
    // (findAllByUserIdAndRole / existsByUserIdAndRestaurantId).

    /**
     * Vyhledá restauraci podle IČO.
     *
     * @param ico osmimístné IČO
     * @return Optional obsahující restauraci, nebo prázdný pokud neexistuje
     */
    Optional<Restaurant> findByIco(String ico);

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
                SELECT id, location, name, logo_url
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
                    name,
                    logo_url,
                    ST_ClusterDBScan(location, eps := :distance, minpoints := 1) OVER () AS cluster_id
                FROM filtered_restaurants
            )
            SELECT
                CASE WHEN COUNT(*) = 1 THEN CAST(MAX(CAST(id AS TEXT)) AS UUID) ELSE NULL END as id,
                ST_Y(ST_Centroid(ST_Collect(location))) as latitude,
                ST_X(ST_Centroid(ST_Collect(location))) as longitude,
                CAST(COUNT(*) AS INTEGER) as count,
                CASE WHEN COUNT(*) = 1 THEN MAX(name) ELSE NULL END as name,
                CASE WHEN COUNT(*) = 1 THEN MAX(logo_url) ELSE NULL END as logo_url
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
                   CAST(1 AS INTEGER) as count, name, logo_url
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
     * Vrací všechny aktivní restaurace jako odlehčené markery (bez bounding-box filtru).
     * Slouží pro endpoint /all-markers — klient si stáhne jednou a cachuje lokálně.
     */
    @Query(value = """
            SELECT id, ST_Y(location) as latitude, ST_X(location) as longitude,
                   CAST(1 AS INTEGER) as count, name, logo_url
            FROM restaurant
            WHERE is_active = true
            ORDER BY name
            """, nativeQuery = true)
    List<Object[]> findAllActiveMarkers();

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