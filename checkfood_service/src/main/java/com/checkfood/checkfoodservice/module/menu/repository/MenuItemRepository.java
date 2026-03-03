package com.checkfood.checkfoodservice.module.menu.repository;

import com.checkfood.checkfoodservice.module.menu.entity.MenuItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface MenuItemRepository extends JpaRepository<MenuItem, UUID> {

    List<MenuItem> findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(UUID categoryId);

    List<MenuItem> findAllByIdIn(List<UUID> ids);
}
