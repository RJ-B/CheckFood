package com.checkfood.checkfoodservice.module.restaurant.menu;

import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.service.MenuServiceImpl;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

/**
 * Unit tests for MenuServiceImpl — no Spring context.
 */
@ExtendWith(MockitoExtension.class)
class MenuServiceTest {

    @Mock MenuCategoryRepository categoryRepository;
    @Mock MenuItemRepository itemRepository;
    @Mock RestaurantRepository restaurantRepository;

    @InjectMocks MenuServiceImpl menuService;

    // ── getMenu happy path ────────────────────────────────────────────────────

    @Test
    @DisplayName("getMenu - returns categories with available items")
    void getMenu_returnsCategoriesWithAvailableItems() {
        UUID rid = UUID.randomUUID();
        UUID cid = UUID.randomUUID();

        var cat = MenuCategory.builder().id(cid).restaurantId(rid).name("Starters").sortOrder(0).active(true).build();
        var item = MenuItem.builder().id(UUID.randomUUID()).categoryId(cid).restaurantId(rid)
                .name("Soup").priceMinor(8900).currency("CZK").available(true).sortOrder(0).build();

        when(restaurantRepository.findById(rid)).thenReturn(Optional.of(mock(
                com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant.class)));
        when(categoryRepository.findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(rid))
                .thenReturn(List.of(cat));
        when(itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid))
                .thenReturn(List.of(item));

        var result = menuService.getMenu(rid);

        assertThat(result).hasSize(1);
        assertThat(result.get(0).getName()).isEqualTo("Starters");
        assertThat(result.get(0).getItems()).hasSize(1);
        assertThat(result.get(0).getItems().get(0).getName()).isEqualTo("Soup");
    }

    @Test
    @DisplayName("getMenu - category with no available items is filtered out")
    void getMenu_emptyCategoryFiltered() {
        UUID rid = UUID.randomUUID();
        UUID cid = UUID.randomUUID();
        var cat = MenuCategory.builder().id(cid).restaurantId(rid).name("Empty").sortOrder(0).active(true).build();

        when(restaurantRepository.findById(rid)).thenReturn(Optional.of(mock(
                com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant.class)));
        when(categoryRepository.findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(rid))
                .thenReturn(List.of(cat));
        when(itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid))
                .thenReturn(List.of());

        var result = menuService.getMenu(rid);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("getMenu - restaurant not found throws exception with 404 status")
    void getMenu_restaurantNotFound_throws() {
        UUID rid = UUID.randomUUID();
        when(restaurantRepository.findById(rid)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> menuService.getMenu(rid))
                .isInstanceOf(RestaurantException.class);
    }

    @Test
    @DisplayName("getMenu - multiple categories, each gets its own item query")
    void getMenu_multipleCategories_eachQueried() {
        UUID rid = UUID.randomUUID();
        UUID cid1 = UUID.randomUUID();
        UUID cid2 = UUID.randomUUID();

        var cat1 = MenuCategory.builder().id(cid1).restaurantId(rid).name("C1").sortOrder(0).active(true).build();
        var cat2 = MenuCategory.builder().id(cid2).restaurantId(rid).name("C2").sortOrder(1).active(true).build();
        var item1 = MenuItem.builder().id(UUID.randomUUID()).categoryId(cid1).restaurantId(rid)
                .name("I1").priceMinor(100).currency("CZK").available(true).sortOrder(0).build();
        var item2 = MenuItem.builder().id(UUID.randomUUID()).categoryId(cid2).restaurantId(rid)
                .name("I2").priceMinor(200).currency("CZK").available(true).sortOrder(0).build();

        when(restaurantRepository.findById(rid)).thenReturn(Optional.of(mock(
                com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant.class)));
        when(categoryRepository.findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(rid))
                .thenReturn(List.of(cat1, cat2));
        when(itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid1)).thenReturn(List.of(item1));
        when(itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid2)).thenReturn(List.of(item2));

        var result = menuService.getMenu(rid);

        assertThat(result).hasSize(2);
        verify(itemRepository, times(1)).findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid1);
        verify(itemRepository, times(1)).findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid2);
    }

    @Test
    @DisplayName("getMenu - all item response fields are populated")
    void getMenu_itemFields_allPopulated() {
        UUID rid = UUID.randomUUID();
        UUID cid = UUID.randomUUID();
        UUID iid = UUID.randomUUID();

        var cat = MenuCategory.builder().id(cid).restaurantId(rid).name("C").sortOrder(0).active(true).build();
        var item = MenuItem.builder().id(iid).categoryId(cid).restaurantId(rid)
                .name("Svickova").description("S omackou").priceMinor(27900).currency("CZK")
                .imageUrl("https://cdn/img.jpg").available(true).sortOrder(0).build();

        when(restaurantRepository.findById(rid)).thenReturn(Optional.of(mock(
                com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant.class)));
        when(categoryRepository.findAllByRestaurantIdAndActiveTrueOrderBySortOrderAsc(rid))
                .thenReturn(List.of(cat));
        when(itemRepository.findAllByCategoryIdAndAvailableTrueOrderBySortOrderAsc(cid))
                .thenReturn(List.of(item));

        var result = menuService.getMenu(rid);

        var resp = result.get(0).getItems().get(0);
        assertThat(resp.getId()).isEqualTo(iid);
        assertThat(resp.getDescription()).isEqualTo("S omackou");
        assertThat(resp.getPriceMinor()).isEqualTo(27900);
        assertThat(resp.getCurrency()).isEqualTo("CZK");
        assertThat(resp.getImageUrl()).isEqualTo("https://cdn/img.jpg");
        assertThat(resp.isAvailable()).isTrue();
    }
}
