package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;

import java.util.List;
import java.util.UUID;

/**
 * Rozhraní pro správu fyzických stolů restaurace a jejich seskupení do sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface TableManagementService {

    /**
     * Přidá nový fyzický stůl do restaurace.
     *
     * @param restaurantId UUID restaurace
     * @param request      request s daty stolu
     * @param ownerId      UUID vlastníka pro ověření přístupu
     * @return response DTO nového stolu
     */
    RestaurantTableResponse addTable(UUID restaurantId, RestaurantTableRequest request, UUID ownerId);

    /**
     * Načte seznam všech stolů restaurace.
     *
     * @param restaurantId UUID restaurace
     * @return seznam response DTO stolů
     */
    List<RestaurantTableResponse> getTablesByRestaurant(UUID restaurantId);

    /**
     * Aktualizuje data fyzického stolu.
     *
     * @param tableId UUID stolu
     * @param request request s novými daty
     * @param ownerId UUID vlastníka pro ověření přístupu
     * @return aktualizované response DTO stolu
     */
    RestaurantTableResponse updateTable(UUID tableId, RestaurantTableRequest request, UUID ownerId);

    /**
     * Deaktivuje fyzický stůl (soft-delete).
     *
     * @param tableId UUID stolu
     * @param ownerId UUID vlastníka pro ověření přístupu
     */
    void deleteTable(UUID tableId, UUID ownerId);

    /**
     * Vytvoří nové sezení pro jeden nebo více stolů.
     * Ověřuje, zda jsou požadované stoly momentálně volné.
     *
     * @param restaurantId UUID restaurace
     * @param tableIds     seznam UUID stolů, které mají být zahrnuty do sezení
     * @param label        volitelný název sezení
     * @return UUID nově vytvořeného sezení
     */
    UUID createTableGroup(UUID restaurantId, List<UUID> tableIds, String label);

    /**
     * Ukončí sezení a uvolní stoly pro další použití.
     */
    void closeTableGroup(UUID groupId);
}