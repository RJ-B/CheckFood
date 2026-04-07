package com.checkfood.checkfoodservice.module.initializer;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.*;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.*;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Služba pro synchronizaci dat restaurací z Overture Maps pomocí DuckDB a S3 Parquet souborů.
 * Provádí upsert (vložení nových + aktualizace existujících) a soft-delete zaniklých podniků.
 * Nespouští se v testovacím profilu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Profile("!test")
public class OvertureDataSyncService {

    private final RestaurantRepository restaurantRepository;
    private final GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);
    private static final UUID SYSTEM_OWNER_ID = UUID.fromString("00000000-0000-0000-0000-000000000000");

    @Value("${overture.release.path:s3://overturemaps-us-west-2/release/2026-*/theme=places/type=place/*.parquet}")
    private String overturePath;

    /**
     * Pravidelná synchronizace dat spouštěná každé pondělí ve 3:00.
     */
    @Scheduled(cron = "0 0 3 * * MON")
    @Transactional
    public void scheduledSync() {
        log.info("Spouštím pravidelnou plánovanou synchronizaci restaurací...");
        syncRestaurantsFromOverture();
    }

    /**
     * Provede synchronizaci dat restaurací z Overture Maps Parquet souborů přes DuckDB.
     * Nové záznamy jsou vloženy, existující aktualizovány, zaniklé deaktivovány.
     */
    @Transactional
    public void syncRestaurantsFromOverture() {
        log.info("Zahajuji synchronizaci dat z Overture Maps (Upsert strategie)...");

        final LocalDateTime syncStartTime = LocalDateTime.now();
        int totalProcessed = 0;

        try (Connection conn = DriverManager.getConnection("jdbc:duckdb:")) {
            setupDuckDB(conn);

            String query = """
                SELECT
                    id AS overture_id,
                    names.primary AS name,
                    categories.primary AS category,
                    ST_X(geometry) AS lon,
                    ST_Y(geometry) AS lat,
                    addresses[1].freeform AS address_full,
                    addresses[1].locality AS city,
                    addresses[1].postcode AS postcode,
                    websites[1] AS website
                FROM read_parquet(?, filename=true)
                WHERE addresses[1].country = 'CZ'
                AND categories.primary IN ('restaurant', 'cafe', 'pub', 'bar', 'fast_food')
                ORDER BY filename DESC
                """;

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, overturePath);

                try (ResultSet rs = stmt.executeQuery()) {
                    List<Restaurant> batch = new ArrayList<>();

                    while (rs.next()) {
                        batch.add(mapToTransientEntity(rs));

                        if (batch.size() >= 1000) {
                            processBatch(batch);
                            totalProcessed += batch.size();
                            batch.clear();
                            log.info("Zpracováno {} záznamů...", totalProcessed);
                        }
                    }

                    if (!batch.isEmpty()) {
                        processBatch(batch);
                        totalProcessed += batch.size();
                    }

                    log.info("Import dat dokončen. Celkem zpracováno {} restaurací. Zahajuji proces Soft-Delete.", totalProcessed);

                    if (totalProcessed > 0) {
                        int deactivatedCount = restaurantRepository.deactivateObsoleteOvertureRestaurants(syncStartTime);
                        log.info("Deaktivováno {} zaniklých podniků.", deactivatedCount);
                    }
                }
            }

        } catch (SQLException e) {
            log.error("Chyba SQL DuckDB při synchronizaci: {}", e.getMessage());
        } catch (Exception e) {
            log.error("Kritická chyba při importu dat: ", e);
        }
    }

    private void processBatch(List<Restaurant> incomingBatch) {
        Set<String> overtureIds = incomingBatch.stream()
                .map(Restaurant::getOvertureId)
                .collect(Collectors.toSet());

        Map<String, Restaurant> existingRestaurants = restaurantRepository.findByOvertureIdIn(overtureIds).stream()
                .collect(Collectors.toMap(Restaurant::getOvertureId, r -> r));

        List<Restaurant> entitiesToSave = new ArrayList<>();

        for (Restaurant incoming : incomingBatch) {
            Restaurant existing = existingRestaurants.get(incoming.getOvertureId());

            if (existing != null) {
                existing.setName(incoming.getName());
                existing.setCuisineType(incoming.getCuisineType());
                existing.setAddress(incoming.getAddress());
                existing.setTags(incoming.getTags());
                existing.setActive(true);
                existing.setStatus(RestaurantStatus.ACTIVE);
                existing.setUpdatedAt(LocalDateTime.now());
                entitiesToSave.add(existing);
            } else {
                incoming.setUpdatedAt(LocalDateTime.now());
                entitiesToSave.add(incoming);
            }
        }

        restaurantRepository.saveAll(entitiesToSave);
    }

    private void setupDuckDB(Connection conn) throws SQLException {
        Statement stmt = conn.createStatement();
        stmt.execute("INSTALL spatial; LOAD spatial;");
        stmt.execute("INSTALL httpfs; LOAD httpfs;");
        stmt.execute("SET s3_region='us-west-2';");
        stmt.execute("SET s3_access_key_id='';");
        stmt.execute("SET s3_secret_access_key='';");
        stmt.execute("SET s3_session_token='';");
    }

    private Restaurant mapToTransientEntity(ResultSet rs) throws SQLException {
        String overtureId = rs.getString("overture_id");
        String name = rs.getString("name");
        String category = rs.getString("category");
        String city = rs.getString("city");
        String fullAddress = rs.getString("address_full");
        String postcode = rs.getString("postcode");

        if (name != null && name.length() > 140) name = name.substring(0, 140);

        if (city == null) {
            city = "Neznámé město";
        } else if (city.length() > 140) {
            city = city.substring(0, 140);
        }

        if (fullAddress != null && fullAddress.length() > 250) {
            fullAddress = fullAddress.substring(0, 250);
        }

        if (postcode != null && postcode.length() > 40) {
            postcode = postcode.substring(0, 40);
        }

        CuisineType cuisineType = mapCuisine(category);

        Address address = Address.builder()
                .street(fullAddress)
                .city(city)
                .postalCode(postcode)
                .country("Česká republika")
                .location(createPoint(rs.getDouble("lat"), rs.getDouble("lon")))
                .build();

        List<OpeningHours> hours = new ArrayList<>();
        for (int i = 1; i <= 7; i++) {
            hours.add(OpeningHours.builder()
                    .dayOfWeek(DayOfWeek.of(i))
                    .openAt(LocalTime.of(10, 0))
                    .closeAt(LocalTime.of(22, 0))
                    .closed(false)
                    .build());
        }

        String description = String.format("Importováno z Overture Maps (%s)", category);

        return Restaurant.builder()
                .overtureId(overtureId)
                .ownerId(SYSTEM_OWNER_ID)
                .name(name != null ? name : "Neznámý podnik")
                .description(description)
                .cuisineType(cuisineType)
                .address(address)
                .rating(new BigDecimal("0.0"))
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .openingHours(hours)
                .tags(new HashSet<>(List.of(cuisineType.name().toLowerCase())))
                .build();
    }

    private CuisineType mapCuisine(String category) {
        if (category == null) return CuisineType.OTHER;
        return switch (category.toLowerCase()) {
            case "restaurant" -> CuisineType.CZECH;
            case "cafe", "coffee_shop", "tea_house" -> CuisineType.CAFE_DESSERT;
            case "pub", "bar", "gastropub", "fast_food" -> CuisineType.STREET_FOOD;
            case "pizzeria", "pizza_restaurant" -> CuisineType.PIZZA;
            case "burger_restaurant" -> CuisineType.BURGER;
            default -> CuisineType.OTHER;
        };
    }

    private Point createPoint(double lat, double lon) {
        return geometryFactory.createPoint(new Coordinate(lon, lat));
    }
}