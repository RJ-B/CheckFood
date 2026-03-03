package com.checkfood.checkfoodservice.module.restaurant.logging;

import com.checkfood.checkfoodservice.module.logging.AppLogger;
import org.springframework.stereotype.Component;
import java.util.UUID;

@Component
public class RestaurantLogger extends AppLogger {

    public void logRestaurantCreated(UUID id, String name, UUID ownerId) {
        this.info("Nová restaurace '{}' (ID: {}) byla úspěšně vytvořena majitelem {}.", name, id, ownerId);
    }

    public void logTableAdded(UUID restaurantId, String label) {
        this.info("Ke restauraci {} byl přidán nový stůl '{}'.", restaurantId, label);
    }

    public void logTableGroupCreated(UUID restaurantId, UUID groupId) {
        this.info("V restauraci {} bylo vytvořeno nové sezení (TableGroup ID: {}).", restaurantId, groupId);
    }
}