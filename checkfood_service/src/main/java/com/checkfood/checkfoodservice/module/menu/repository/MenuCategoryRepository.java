package com.checkfood.checkfoodservice.module.menu.repository;

import com.checkfood.checkfoodservice.module.menu.entity.MenuCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * JPA repozitář pro entitu {@link MenuCategory} poskytující dotazy pro načítání aktivních kategorií
 * menu seřazených dle pořadí a existenci kategorií pro danou restauraci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface MenuCategoryRepository extends JpaRepository<MenuCategory, UUID> {

    List<MenuCategory> findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(UUID restaurantId);

    boolean existsByRestaurantId(UUID restaurantId);
}
