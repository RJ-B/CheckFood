package com.checkfood.checkfoodservice.module.restaurant.logging;

import com.checkfood.checkfoodservice.infrastructure.logging.AppLogger;
import org.springframework.stereotype.Component;
import java.util.UUID;

/**
 * Specializovaný logger pro doménové události modulu restaurací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class RestaurantLogger extends AppLogger {

    /**
     * Zaloguje úspěšné vytvoření nové restaurace.
     *
     * @param id      UUID nové restaurace
     * @param name    název restaurace
     * @param ownerId UUID majitele
     */
    public void logRestaurantCreated(UUID id, String name, UUID ownerId) {
        this.info("Nová restaurace '{}' (ID: {}) byla úspěšně vytvořena majitelem {}.", name, id, ownerId);
    }

    /**
     * Zaloguje přidání nového stolu do restaurace.
     *
     * @param restaurantId UUID restaurace
     * @param label        označení nového stolu
     */
    public void logTableAdded(UUID restaurantId, String label) {
        this.info("Ke restauraci {} byl přidán nový stůl '{}'.", restaurantId, label);
    }

    /**
     * Zaloguje vytvoření nového sezení (skupiny stolů) v restauraci.
     *
     * @param restaurantId UUID restaurace
     * @param groupId      UUID nového sezení
     */
    public void logTableGroupCreated(UUID restaurantId, UUID groupId) {
        this.info("V restauraci {} bylo vytvořeno nové sezení (TableGroup ID: {}).", restaurantId, groupId);
    }
}