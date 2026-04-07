package com.checkfood.checkfoodservice.module.menu.service;

import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuItemResponse;
import com.checkfood.checkfoodservice.module.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

/**
 * Implementace {@link MenuService} načítající veřejné menu restaurace seřazené dle pořadí kategorií
 * a filtrující prázdné kategorie i nedostupné položky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MenuServiceImpl implements MenuService {

    private final MenuCategoryRepository menuCategoryRepository;
    private final MenuItemRepository menuItemRepository;
    private final RestaurantRepository restaurantRepository;

    @Override
    public List<MenuCategoryResponse> getMenu(UUID restaurantId) {
        restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> RestaurantException.notFound(restaurantId));

        List<MenuCategory> categories = menuCategoryRepository
                .findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(restaurantId);

        return categories.stream()
                .map(this::toCategoryResponse)
                .filter(cat -> !cat.getItems().isEmpty())
                .toList();
    }

    private MenuCategoryResponse toCategoryResponse(MenuCategory category) {
        List<MenuItem> items = menuItemRepository
                .findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(category.getId());

        return MenuCategoryResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .items(items.stream().map(this::toItemResponse).toList())
                .build();
    }

    private MenuItemResponse toItemResponse(MenuItem item) {
        return MenuItemResponse.builder()
                .id(item.getId())
                .name(item.getName())
                .description(item.getDescription())
                .priceMinor(item.getPriceMinor())
                .currency(item.getCurrency())
                .imageUrl(item.getImageUrl())
                .available(item.isAvailable())
                .build();
    }
}
