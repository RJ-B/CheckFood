package com.checkfood.checkfoodservice.module.restaurant.repository.table;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repozitář pro správu fyzických stolů.
 */
@Repository
public interface RestaurantTableRepository extends JpaRepository<RestaurantTable, UUID> {

    /**
     * Načte všechny stoly konkrétní restaurace.
     */
    List<RestaurantTable> findAllByRestaurantId(UUID restaurantId);

    /**
     * Načte pouze aktivní stoly konkrétní restaurace.
     */
    List<RestaurantTable> findAllByRestaurantIdAndActiveTrue(UUID restaurantId);

    /**
     * Vyhledá stůl podle ID a příslušnosti k restauraci (bezpečnostní kontrola).
     */
    Optional<RestaurantTable> findByIdAndRestaurantId(UUID id, UUID restaurantId);

    /**
     * Smaže všechny stoly dané restaurace.
     *
     * @param restaurantId UUID restaurace
     */
    void deleteAllByRestaurantId(UUID restaurantId);
}