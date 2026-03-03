package com.checkfood.checkfoodservice.module.initializer;

import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
@Profile("!test")
public class RestaurantDataInitializer {

    private final RestaurantRepository restaurantRepository;
    private final OvertureDataSyncService overtureDataSyncService;
    private final JdbcTemplate jdbcTemplate; // Slouží pro přímé volání nativního SQL

    @EventListener(ApplicationReadyEvent.class)
    public void initializeDataAfterStartup() {

        // 1. Zajištění existence optimalizovaných databázových indexů
        createSpatialIndex();

        // 2. Prvotní import dat
        if (restaurantRepository.count() == 0) {
            log.info("Databáze je prázdná. Zahajuji prvotní import dat z Overture Maps...");
            try {
                overtureDataSyncService.syncRestaurantsFromOverture();
            } catch (Exception e) {
                log.error("Selhal prvotní import dat při startu aplikace: ", e);
            }
        } else {
            log.info("Databáze již obsahuje data ({} restaurací), import přeskakuji.", restaurantRepository.count());
        }
    }

    /**
     * Vytvoří částečný GiST index pro PostGIS, pokud ještě neexistuje.
     * Toto řešení obchází omezení anotace @Index v JPA a zajišťuje
     * automatické nasazení bez nutnosti ručních zásahů do databáze.
     */
    private void createSpatialIndex() {
        try {
            log.info("Kontrola a konfigurace částečného PostGIS GiST indexu pro aktivní restaurace...");

            // IF NOT EXISTS zaručuje, že příkaz neselže při opakovaném startu aplikace
            String sql = """
                CREATE INDEX IF NOT EXISTS idx_active_restaurants_location 
                ON restaurant USING GIST (location) 
                WHERE is_active = true;
                """;

            jdbcTemplate.execute(sql);
            log.info("PostGIS index je úspěšně připraven.");

        } catch (Exception e) {
            log.warn("Prostorový index nebyl vytvořen. Bude vytvořen při dalším startu, jakmile Hibernate vygeneruje tabulku. Detail: {}", e.getMessage());
        }
    }
}