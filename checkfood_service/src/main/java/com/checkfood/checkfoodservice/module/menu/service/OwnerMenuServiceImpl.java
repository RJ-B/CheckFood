package com.checkfood.checkfoodservice.module.menu.service;

import com.checkfood.checkfoodservice.module.menu.dto.request.MenuCategoryRequest;
import com.checkfood.checkfoodservice.module.menu.dto.request.MenuItemRequest;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuItemResponse;
import com.checkfood.checkfoodservice.module.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.menu.exception.MenuException;
import com.checkfood.checkfoodservice.module.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

/**
 * Implementace {@link OwnerMenuService} zajišťující CRUD operace nad kategoriemi a položkami menu
 * s ověřením vlastnictví restaurace před každou modifikací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional
public class OwnerMenuServiceImpl implements OwnerMenuService {

    private final MenuCategoryRepository categoryRepository;
    private final MenuItemRepository itemRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final UserService userService;

    @Override
    @Transactional(readOnly = true)
    public List<MenuCategoryResponse> getOwnerMenu(String userEmail) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var categories = categoryRepository.findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(restaurantId);
        return categories.stream()
                .map(cat -> {
                    var items = itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cat.getId());
                    return MenuCategoryResponse.builder()
                            .id(cat.getId())
                            .name(cat.getName())
                            .items(items.stream().map(this::toItemResponse).toList())
                            .build();
                })
                .toList();
    }

    @Override
    public MenuCategoryResponse createCategory(String userEmail, MenuCategoryRequest request) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var category = MenuCategory.builder()
                .restaurantId(restaurantId)
                .name(request.getName())
                .sortOrder(request.getSortOrder())
                .build();
        var saved = categoryRepository.save(category);
        return MenuCategoryResponse.builder()
                .id(saved.getId())
                .name(saved.getName())
                .items(List.of())
                .build();
    }

    @Override
    public MenuCategoryResponse updateCategory(String userEmail, UUID categoryId, MenuCategoryRequest request) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> MenuException.categoryNotFound(categoryId));
        if (!category.getRestaurantId().equals(restaurantId)) {
            throw RestaurantException.accessDenied();
        }
        category.setName(request.getName());
        category.setSortOrder(request.getSortOrder());
        var saved = categoryRepository.save(category);

        var items = itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(saved.getId());
        return MenuCategoryResponse.builder()
                .id(saved.getId())
                .name(saved.getName())
                .items(items.stream().map(this::toItemResponse).toList())
                .build();
    }

    @Override
    public void deleteCategory(String userEmail, UUID categoryId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> MenuException.categoryNotFound(categoryId));
        if (!category.getRestaurantId().equals(restaurantId)) {
            throw RestaurantException.accessDenied();
        }
        categoryRepository.delete(category);
    }

    @Override
    public MenuItemResponse createItem(String userEmail, UUID categoryId, MenuItemRequest request) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> MenuException.categoryNotFound(categoryId));
        if (!category.getRestaurantId().equals(restaurantId)) {
            throw RestaurantException.accessDenied();
        }

        var item = MenuItem.builder()
                .categoryId(categoryId)
                .restaurantId(restaurantId)
                .name(request.getName())
                .description(request.getDescription())
                .priceMinor(request.getPriceMinor())
                .currency(request.getCurrency())
                .imageUrl(request.getImageUrl())
                .available(request.isAvailable())
                .sortOrder(request.getSortOrder())
                .build();
        var saved = itemRepository.save(item);
        return toItemResponse(saved);
    }

    @Override
    public MenuItemResponse updateItem(String userEmail, UUID itemId, MenuItemRequest request) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var item = itemRepository.findById(itemId)
                .orElseThrow(() -> MenuException.itemNotFound(itemId));
        if (!item.getRestaurantId().equals(restaurantId)) {
            throw RestaurantException.accessDenied();
        }

        item.setName(request.getName());
        item.setDescription(request.getDescription());
        item.setPriceMinor(request.getPriceMinor());
        item.setCurrency(request.getCurrency());
        item.setImageUrl(request.getImageUrl());
        item.setAvailable(request.isAvailable());
        item.setSortOrder(request.getSortOrder());

        var saved = itemRepository.save(item);
        return toItemResponse(saved);
    }

    @Override
    public void deleteItem(String userEmail, UUID itemId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var item = itemRepository.findById(itemId)
                .orElseThrow(() -> MenuException.itemNotFound(itemId));
        if (!item.getRestaurantId().equals(restaurantId)) {
            throw RestaurantException.accessDenied();
        }
        itemRepository.delete(item);
    }

    private UUID findOwnerRestaurantId(String userEmail) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                .orElseThrow(RestaurantException::noRestaurantAssigned);
        return membership.getRestaurant().getId();
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
