package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;

import java.util.List;
import java.util.UUID;

/**
 * Rozhraní pro správu fyzických stolů a jejich obsazenosti.
 */
public interface TableManagementService {

    // --- Správa inventáře (Fyzické stoly) ---

    RestaurantTableResponse addTable(UUID restaurantId, RestaurantTableRequest request, UUID ownerId);

    List<RestaurantTableResponse> getTablesByRestaurant(UUID restaurantId);

    RestaurantTableResponse updateTable(UUID tableId, RestaurantTableRequest request, UUID ownerId);

    void deleteTable(UUID tableId, UUID ownerId);

    // --- Správa sezení (Table Groups) ---

    /**
     * Vytvoří nové sezení pro jeden nebo více stolů.
     * Ověřuje, zda jsou stoly volné.
     */
    UUID createTableGroup(UUID restaurantId, List<UUID> tableIds, String label);

    /**
     * Ukončí sezení a uvolní stoly pro další použití.
     */
    void closeTableGroup(UUID groupId);
}