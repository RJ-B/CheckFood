package com.checkfood.checkfoodservice.module.restaurant.menu;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuCategoryRequest;
import com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuItemRequest;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.exception.MenuException;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.service.OwnerMenuServiceImpl;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for OwnerMenuServiceImpl — no Spring context.
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class OwnerMenuServiceTest {

    @Mock MenuCategoryRepository categoryRepository;
    @Mock MenuItemRepository itemRepository;
    @Mock RestaurantEmployeeRepository employeeRepository;
    @Mock UserService userService;

    @InjectMocks OwnerMenuServiceImpl ownerMenuService;

    private static final String EMAIL = "owner@test.com";
    private final UUID restaurantId = UUID.randomUUID();
    private UserEntity user;
    private Restaurant restaurant;
    private RestaurantEmployee membership;

    @BeforeEach
    void setUp() {
        user = mock(UserEntity.class);
        when(user.getId()).thenReturn(42L);

        restaurant = mock(Restaurant.class);
        when(restaurant.getId()).thenReturn(restaurantId);

        membership = mock(RestaurantEmployee.class);
        when(membership.getRestaurant()).thenReturn(restaurant);

        when(userService.findByEmail(EMAIL)).thenReturn(user);
        when(employeeRepository.findFirstByUserIdAndRole(42L, RestaurantEmployeeRole.OWNER))
                .thenReturn(Optional.of(membership));
    }

    // ── createCategory ────────────────────────────────────────────────────────

    @Test
    @DisplayName("createCategory - saves and returns response with name")
    void createCategory_savesAndReturns() {
        var request = new MenuCategoryRequest("Polévky", 1);
        var saved = MenuCategory.builder().id(UUID.randomUUID()).restaurantId(restaurantId)
                .name("Polévky").sortOrder(1).active(true).build();
        when(categoryRepository.save(any())).thenReturn(saved);

        var result = ownerMenuService.createCategory(EMAIL, request);

        assertThat(result.getName()).isEqualTo("Polévky");
        assertThat(result.getId()).isEqualTo(saved.getId());
        verify(categoryRepository).save(any());
    }

    @Test
    @DisplayName("createCategory - no restaurant assigned throws RestaurantException")
    void createCategory_noRestaurant_throws() {
        when(employeeRepository.findFirstByUserIdAndRole(42L, RestaurantEmployeeRole.OWNER))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> ownerMenuService.createCategory(EMAIL, new MenuCategoryRequest("X", 0)))
                .isInstanceOf(RestaurantException.class);
    }

    // ── updateCategory ────────────────────────────────────────────────────────

    @Test
    @DisplayName("updateCategory - updates name and sortOrder, returns updated category")
    void updateCategory_updatesFields() {
        UUID catId = UUID.randomUUID();
        var existing = MenuCategory.builder().id(catId).restaurantId(restaurantId).name("Old").sortOrder(0).active(true).build();
        var updated = MenuCategory.builder().id(catId).restaurantId(restaurantId).name("New").sortOrder(5).active(true).build();

        when(categoryRepository.findById(catId)).thenReturn(Optional.of(existing));
        when(categoryRepository.save(any())).thenReturn(updated);
        when(itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(catId)).thenReturn(List.of());

        var result = ownerMenuService.updateCategory(EMAIL, catId, new MenuCategoryRequest("New", 5));

        assertThat(result.getName()).isEqualTo("New");
    }

    @Test
    @DisplayName("updateCategory - category not found throws MenuException 404")
    void updateCategory_notFound_throws() {
        UUID catId = UUID.randomUUID();
        when(categoryRepository.findById(catId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> ownerMenuService.updateCategory(EMAIL, catId, new MenuCategoryRequest("X", 0)))
                .isInstanceOf(MenuException.class);
    }

    @Test
    @DisplayName("updateCategory - category belongs to another restaurant throws RestaurantException")
    void updateCategory_wrongRestaurant_throws() {
        UUID catId = UUID.randomUUID();
        var existing = MenuCategory.builder().id(catId).restaurantId(UUID.randomUUID())  // different restaurant
                .name("X").sortOrder(0).active(true).build();
        when(categoryRepository.findById(catId)).thenReturn(Optional.of(existing));

        assertThatThrownBy(() -> ownerMenuService.updateCategory(EMAIL, catId, new MenuCategoryRequest("X", 0)))
                .isInstanceOf(RestaurantException.class);
    }

    // ── deleteCategory ────────────────────────────────────────────────────────

    @Test
    @DisplayName("deleteCategory - delegates to repository delete")
    void deleteCategory_callsDelete() {
        UUID catId = UUID.randomUUID();
        var cat = MenuCategory.builder().id(catId).restaurantId(restaurantId).name("C").sortOrder(0).active(true).build();
        when(categoryRepository.findById(catId)).thenReturn(Optional.of(cat));

        ownerMenuService.deleteCategory(EMAIL, catId);

        verify(categoryRepository).delete(cat);
    }

    @Test
    @DisplayName("deleteCategory - not found throws MenuException")
    void deleteCategory_notFound_throws() {
        UUID catId = UUID.randomUUID();
        when(categoryRepository.findById(catId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> ownerMenuService.deleteCategory(EMAIL, catId))
                .isInstanceOf(MenuException.class);
    }

    // ── createItem ────────────────────────────────────────────────────────────

    @Test
    @DisplayName("createItem - saves item with all fields")
    void createItem_savesItem() {
        UUID catId = UUID.randomUUID();
        var cat = MenuCategory.builder().id(catId).restaurantId(restaurantId).name("C").sortOrder(0).active(true).build();
        var req = MenuItemRequest.builder().name("Svickova").priceMinor(29900).currency("CZK")
                .available(true).sortOrder(0).build();
        var saved = MenuItem.builder().id(UUID.randomUUID()).categoryId(catId).restaurantId(restaurantId)
                .name("Svickova").priceMinor(29900).currency("CZK").available(true).sortOrder(0).build();

        when(categoryRepository.findById(catId)).thenReturn(Optional.of(cat));
        when(itemRepository.save(any())).thenReturn(saved);

        var result = ownerMenuService.createItem(EMAIL, catId, req);

        assertThat(result.getName()).isEqualTo("Svickova");
        assertThat(result.getPriceMinor()).isEqualTo(29900);
        verify(itemRepository).save(any());
    }

    @Test
    @DisplayName("createItem - category not found throws MenuException")
    void createItem_categoryNotFound_throws() {
        UUID catId = UUID.randomUUID();
        when(categoryRepository.findById(catId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> ownerMenuService.createItem(EMAIL, catId,
                MenuItemRequest.builder().name("X").priceMinor(100).currency("CZK").available(true).build()))
                .isInstanceOf(MenuException.class);
    }

    @Test
    @DisplayName("createItem - category belongs to another restaurant throws RestaurantException")
    void createItem_wrongRestaurant_throws() {
        UUID catId = UUID.randomUUID();
        var cat = MenuCategory.builder().id(catId).restaurantId(UUID.randomUUID()).name("X").sortOrder(0).active(true).build();
        when(categoryRepository.findById(catId)).thenReturn(Optional.of(cat));

        assertThatThrownBy(() -> ownerMenuService.createItem(EMAIL, catId,
                MenuItemRequest.builder().name("X").priceMinor(100).currency("CZK").available(true).build()))
                .isInstanceOf(RestaurantException.class);
    }

    // ── updateItem ────────────────────────────────────────────────────────────

    @Test
    @DisplayName("updateItem - updates all mutable fields")
    void updateItem_updatesFields() {
        UUID itemId = UUID.randomUUID();
        var existing = MenuItem.builder().id(itemId).categoryId(UUID.randomUUID()).restaurantId(restaurantId)
                .name("Old").priceMinor(100).currency("CZK").available(true).sortOrder(0).build();
        var req = MenuItemRequest.builder().name("New").priceMinor(500).currency("EUR")
                .available(false).sortOrder(2).build();
        when(itemRepository.findById(itemId)).thenReturn(Optional.of(existing));
        when(itemRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        var result = ownerMenuService.updateItem(EMAIL, itemId, req);

        assertThat(result.getName()).isEqualTo("New");
        assertThat(result.getPriceMinor()).isEqualTo(500);
        assertThat(result.isAvailable()).isFalse();
    }

    @Test
    @DisplayName("updateItem - not found throws MenuException")
    void updateItem_notFound_throws() {
        UUID itemId = UUID.randomUUID();
        when(itemRepository.findById(itemId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> ownerMenuService.updateItem(EMAIL, itemId,
                MenuItemRequest.builder().name("X").priceMinor(0).currency("CZK").available(true).build()))
                .isInstanceOf(MenuException.class);
    }

    @Test
    @DisplayName("updateItem - item belongs to another restaurant throws RestaurantException")
    void updateItem_wrongRestaurant_throws() {
        UUID itemId = UUID.randomUUID();
        var item = MenuItem.builder().id(itemId).categoryId(UUID.randomUUID()).restaurantId(UUID.randomUUID())
                .name("X").priceMinor(100).currency("CZK").available(true).sortOrder(0).build();
        when(itemRepository.findById(itemId)).thenReturn(Optional.of(item));

        assertThatThrownBy(() -> ownerMenuService.updateItem(EMAIL, itemId,
                MenuItemRequest.builder().name("X").priceMinor(0).currency("CZK").available(true).build()))
                .isInstanceOf(RestaurantException.class);
    }

    // ── deleteItem ────────────────────────────────────────────────────────────

    @Test
    @DisplayName("deleteItem - calls repository delete")
    void deleteItem_callsDelete() {
        UUID itemId = UUID.randomUUID();
        var item = MenuItem.builder().id(itemId).categoryId(UUID.randomUUID()).restaurantId(restaurantId)
                .name("X").priceMinor(100).currency("CZK").available(true).sortOrder(0).build();
        when(itemRepository.findById(itemId)).thenReturn(Optional.of(item));

        ownerMenuService.deleteItem(EMAIL, itemId);

        verify(itemRepository).delete(item);
    }

    @Test
    @DisplayName("deleteItem - not found throws MenuException")
    void deleteItem_notFound_throws() {
        UUID itemId = UUID.randomUUID();
        when(itemRepository.findById(itemId)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> ownerMenuService.deleteItem(EMAIL, itemId))
                .isInstanceOf(MenuException.class);
    }
}
