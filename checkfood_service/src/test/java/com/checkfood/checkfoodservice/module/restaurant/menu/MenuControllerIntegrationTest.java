package com.checkfood.checkfoodservice.module.restaurant.menu;

import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for public GET /api/v1/restaurants/{id}/menu endpoint.
 */
@Transactional
class MenuControllerIntegrationTest extends BaseMenuIntegrationTest {

    private static final String BASE = "/api/v1/restaurants/%s/menu";

    // ── happy path ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("GET menu - anonymous user receives available items only (200)")
    void getMenu_happyPath_returnsAvailableItems() throws Exception {
        MenuCategory cat = saveCategory("Hlavní jídla", 0);
        saveItem(cat.getId(), "Svíčková", 24900, true);
        saveItem(cat.getId(), "Unavailable dish", 15000, false);

        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$[0].name").value("Hlavní jídla"))
                .andExpect(jsonPath("$[0].items").isArray())
                .andExpect(jsonPath("$[0].items.length()").value(1))
                .andExpect(jsonPath("$[0].items[0].name").value("Svíčková"))
                .andExpect(jsonPath("$[0].items[0].available").value(true));
    }

    @Test
    @DisplayName("GET menu - public, no auth token required")
    void getMenu_noAuthToken_returns200() throws Exception {
        saveCategory("Polévky", 0);
        // category has no items → filtered out, but endpoint still returns 200
        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    @Test
    @DisplayName("GET menu - categories with no available items are filtered out")
    void getMenu_emptyCategory_isFiltered() throws Exception {
        MenuCategory cat = saveCategory("Prázdná kategorie", 0);
        // no items — category must NOT appear
        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(0));
    }

    @Test
    @DisplayName("GET menu - categories respect sortOrder asc")
    void getMenu_categoriesInSortOrder() throws Exception {
        MenuCategory cat2 = saveCategory("Dezerty", 2);
        MenuCategory cat1 = saveCategory("Předkrmy", 1);
        saveItem(cat1.getId(), "Bruschetta", 18900, true);
        saveItem(cat2.getId(), "Tiramisu", 12900, true);

        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("Předkrmy"))
                .andExpect(jsonPath("$[1].name").value("Dezerty"));
    }

    @Test
    @DisplayName("GET menu - items respect sortOrder asc within category")
    void getMenu_itemsInSortOrder() throws Exception {
        MenuCategory cat = saveCategory("Nápoje", 0);
        itemRepository.saveAndFlush(menuItemWithSort(cat.getId(), "Voda", 1, 5000, true));
        itemRepository.saveAndFlush(menuItemWithSort(cat.getId(), "Cola", 0, 4900, true));

        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].items[0].name").value("Cola"))
                .andExpect(jsonPath("$[0].items[1].name").value("Voda"));
    }

    @Test
    @DisplayName("GET menu - inactive category is excluded")
    void getMenu_inactiveCategory_excluded() throws Exception {
        MenuCategory inactive = categoryRepository.saveAndFlush(
                MenuCategory.builder()
                        .restaurantId(restaurantId)
                        .name("Neaktivní")
                        .sortOrder(0)
                        .active(false)
                        .build());
        saveItem(inactive.getId(), "Ghost item", 5000, true);

        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(0));
    }

    // ── not found ────────────────────────────────────────────────────────────

    @Test
    @DisplayName("GET menu - unknown restaurantId returns 404")
    void getMenu_unknownRestaurant_returns404() throws Exception {
        mockMvc.perform(get(BASE.formatted(UUID.randomUUID())))
                .andExpect(status().isNotFound());
    }

    // ── persistence round-trip ───────────────────────────────────────────────

    @Test
    @DisplayName("GET menu - item fields are fully serialised")
    void getMenu_itemFields_serialised() throws Exception {
        MenuCategory cat = saveCategory("Polévky", 0);
        itemRepository.saveAndFlush(MenuItem.builder()
                .restaurantId(restaurantId)
                .categoryId(cat.getId())
                .name("Gulášová")
                .description("Hovězí guláš")
                .priceMinor(8900)
                .currency("CZK")
                .imageUrl("https://cdn.example.com/gulas.jpg")
                .available(true)
                .sortOrder(0)
                .build());

        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].items[0].description").value("Hovězí guláš"))
                .andExpect(jsonPath("$[0].items[0].priceMinor").value(8900))
                .andExpect(jsonPath("$[0].items[0].currency").value("CZK"))
                .andExpect(jsonPath("$[0].items[0].imageUrl").value("https://cdn.example.com/gulas.jpg"));
    }

    @Test
    @DisplayName("GET menu - multiple categories, some empty, correct count returned")
    void getMenu_multiCat_emptyFiltered() throws Exception {
        MenuCategory empty = saveCategory("Prázdná", 0);
        MenuCategory full  = saveCategory("Plná", 1);
        saveItem(full.getId(), "Položka", 5000, true);

        mockMvc.perform(get(BASE.formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].name").value("Plná"));
    }

    // ── helper ───────────────────────────────────────────────────────────────

    private com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem menuItemWithSort(
            UUID catId, String name, int sortOrder, int price, boolean available) {
        return com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem.builder()
                .restaurantId(restaurantId)
                .categoryId(catId)
                .name(name)
                .priceMinor(price)
                .currency("CZK")
                .available(available)
                .sortOrder(sortOrder)
                .build();
    }
}
