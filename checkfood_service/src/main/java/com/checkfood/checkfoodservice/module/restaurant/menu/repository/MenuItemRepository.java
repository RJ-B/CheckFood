package com.checkfood.checkfoodservice.module.restaurant.menu.repository;

import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * JPA repozitář pro entitu {@link MenuItem} poskytující dotazy pro načítání dostupných položek
 * kategorie a hromadné načítání položek podle ID (pro validaci objednávek).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface MenuItemRepository extends JpaRepository<MenuItem, UUID> {

    List<MenuItem> findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(UUID categoryId);

    List<MenuItem> findAllByIdIn(List<UUID> ids);
}
