package com.checkfood.checkfoodservice.module.restaurant.repository.table;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.TableGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Repozitář pro správu logických skupin stolů (sezení).
 */
@Repository
public interface TableGroupRepository extends JpaRepository<TableGroup, UUID> {

    /**
     * Vyhledá všechna aktuálně probíhající sezení v restauraci.
     */
    List<TableGroup> findAllByRestaurantIdAndActiveTrue(UUID restaurantId);

    /**
     * Vyhledá historii sezení v restauraci.
     */
    List<TableGroup> findAllByRestaurantIdAndActiveFalseOrderByClosedAtDesc(UUID restaurantId);

    /**
     * Smaže všechna sezení dané restaurace.
     *
     * @param restaurantId UUID restaurace
     */
    void deleteAllByRestaurantId(UUID restaurantId);
}