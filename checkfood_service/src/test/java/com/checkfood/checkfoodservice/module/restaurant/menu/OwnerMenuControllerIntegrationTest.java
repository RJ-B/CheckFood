package com.checkfood.checkfoodservice.module.restaurant.menu;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;

import java.util.EnumSet;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for OwnerMenuController — CRUD on categories and items.
 */
@Transactional
class OwnerMenuControllerIntegrationTest extends BaseMenuIntegrationTest {

    private static final String CATEGORIES = "/api/v1/owner/restaurant/me/menu/categories";
    private static final String ITEMS_IN_CAT = "/api/v1/owner/restaurant/me/menu/categories/%s/items";
    private static final String ITEM_URL = "/api/v1/owner/restaurant/me/menu/items/%s";
    private static final String CAT_URL = "/api/v1/owner/restaurant/me/menu/categories/%s";
    private static final String GET_MENU = "/api/v1/owner/restaurant/me/menu";

    // ── authorization matrix ──────────────────────────────────────────────────

    @Test
    @DisplayName("GET owner menu - anonymous gets 401")
    void getOwnerMenu_anon_401() throws Exception {
        mockMvc.perform(get(GET_MENU)).andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET owner menu - USER role gets 403")
    void getOwnerMenu_userRole_403() throws Exception {
        String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-1");
        mockMvc.perform(get(GET_MENU).header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("POST category - anonymous gets 401")
    void createCategory_anon_401() throws Exception {
        mockMvc.perform(post(CATEGORIES)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Cat","sortOrder":0}
                                """))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST category - USER role gets 403")
    void createCategory_userRole_403() throws Exception {
        String token = getAccessToken("regularuser2@checkfood.test", TEST_PASSWORD, "device-user-2");
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Cat","sortOrder":0}
                                """))
                .andExpect(status().isForbidden());
    }

    // ── GET owner menu ────────────────────────────────────────────────────────

    @Test
    @DisplayName("GET owner menu - returns categories for the owner's restaurant")
    void getOwnerMenu_happyPath() throws Exception {
        MenuCategory cat = saveCategory("Předkrmy", 0);
        saveItem(cat.getId(), "Bruschetta", 18900, true);

        mockMvc.perform(get(GET_MENU).header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("Předkrmy"))
                .andExpect(jsonPath("$[0].items[0].name").value("Bruschetta"));
    }

    // ── POST category ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("POST category - happy path returns 200 with id and name")
    void createCategory_happyPath() throws Exception {
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Polévky","sortOrder":1}
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").isNotEmpty())
                .andExpect(jsonPath("$.name").value("Polévky"))
                .andExpect(jsonPath("$.items").isArray());
    }

    @Test
    @DisplayName("POST category - blank name returns 400")
    void createCategory_blankName_400() throws Exception {
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"","sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST category - null name returns 400")
    void createCategory_nullName_400() throws Exception {
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST category - name exactly 100 chars is accepted")
    void createCategory_nameMaxLength_accepted() throws Exception {
        String name = "A".repeat(100);
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                new com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuCategoryRequest(name, 0))))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value(name));
    }

    @Test
    @DisplayName("POST category - name 101 chars returns 400")
    void createCategory_nameTooLong_400() throws Exception {
        String name = "A".repeat(101);
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                new com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuCategoryRequest(name, 0))))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST category - persisted in DB after creation")
    void createCategory_persistedInDb() throws Exception {
        mockMvc.perform(post(CATEGORIES)
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Dezerty","sortOrder":0}
                                """))
                .andExpect(status().isOk());

        assertThat(categoryRepository.findAllByRestaurantId(restaurantId))
                .anyMatch(c -> "Dezerty".equals(c.getName()));
    }

    // ── PUT category ──────────────────────────────────────────────────────────

    @Test
    @DisplayName("PUT category - happy path updates name and sortOrder")
    void updateCategory_happyPath() throws Exception {
        MenuCategory cat = saveCategory("Old", 0);

        mockMvc.perform(put(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"New","sortOrder":5}
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("New"));

        assertThat(categoryRepository.findById(cat.getId()).orElseThrow().getName()).isEqualTo("New");
        assertThat(categoryRepository.findById(cat.getId()).orElseThrow().getSortOrder()).isEqualTo(5);
    }

    @Test
    @DisplayName("PUT category - unknown id returns 404")
    void updateCategory_unknownId_404() throws Exception {
        mockMvc.perform(put(CAT_URL.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"X","sortOrder":0}
                                """))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("PUT category - blank name returns 400")
    void updateCategory_blankName_400() throws Exception {
        MenuCategory cat = saveCategory("Valid", 0);
        mockMvc.perform(put(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"","sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PUT category - wrong owner gets 403 / 404")
    void updateCategory_wrongOwner() throws Exception {
        MenuCategory cat = saveCategory("X", 0);
        String otherToken = createOwnerWithAnotherRestaurant();

        // other owner cannot update this restaurant's category
        mockMvc.perform(put(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + otherToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Hacked","sortOrder":0}
                                """))
                .andExpect(result ->
                        assertThat(result.getResponse().getStatus()).isIn(403, 404, 400));
    }

    // ── DELETE category ───────────────────────────────────────────────────────

    @Test
    @DisplayName("DELETE category - returns 204 and removes from DB")
    void deleteCategory_happyPath() throws Exception {
        MenuCategory cat = saveCategory("ToDelete", 0);

        mockMvc.perform(delete(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());

        assertThat(categoryRepository.findById(cat.getId())).isEmpty();
    }

    @Test
    @DisplayName("DELETE category - unknown id returns 404")
    void deleteCategory_unknownId_404() throws Exception {
        mockMvc.perform(delete(CAT_URL.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("DELETE category - idempotency: second delete returns 404")
    void deleteCategory_idempotency() throws Exception {
        MenuCategory cat = saveCategory("DoubleDelete", 0);

        mockMvc.perform(delete(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());

        mockMvc.perform(delete(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    // GAP: deleting a category should cascade-delete its items
    @Test
    @DisplayName("DELETE category - items in category are also removed (cascade)")
    void deleteCategory_cascadesItems() throws Exception {
        MenuCategory cat = saveCategory("WithItems", 0);
        MenuItem item = saveItem(cat.getId(), "ItemInCat", 5000, true);

        mockMvc.perform(delete(CAT_URL.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());

        assertThat(itemRepository.findById(item.getId())).isEmpty();
    }

    // ── POST item ─────────────────────────────────────────────────────────────

    @Test
    @DisplayName("POST item - happy path returns 200 with item data")
    void createItem_happyPath() throws Exception {
        MenuCategory cat = saveCategory("Hlavní jídla", 0);

        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "name":"Svíčková",
                                  "description":"Hovězí svíčková na smetaně",
                                  "priceMinor":29900,
                                  "currency":"CZK",
                                  "available":true,
                                  "sortOrder":0
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").isNotEmpty())
                .andExpect(jsonPath("$.name").value("Svíčková"))
                .andExpect(jsonPath("$.priceMinor").value(29900))
                .andExpect(jsonPath("$.currency").value("CZK"))
                .andExpect(jsonPath("$.available").value(true));
    }

    @Test
    @DisplayName("POST item - blank name returns 400")
    void createItem_blankName_400() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"","priceMinor":100,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST item - null name returns 400")
    void createItem_nullName_400() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"priceMinor":100,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST item - negative price returns 400")
    void createItem_negativePrice_400() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Item","priceMinor":-1,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST item - zero price is valid (free item)")
    void createItem_zeroPrice_accepted() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Free","priceMinor":0,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.priceMinor").value(0));
    }

    @Test
    @DisplayName("POST item - name exactly 150 chars is accepted")
    void createItem_nameMaxLength_accepted() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        String name = "B".repeat(150);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuItemRequest.builder()
                                        .name(name).priceMinor(100).currency("CZK").available(true).sortOrder(0).build())))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST item - name 151 chars returns 400")
    void createItem_nameTooLong_400() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        String name = "B".repeat(151);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuItemRequest.builder()
                                        .name(name).priceMinor(100).currency("CZK").available(true).sortOrder(0).build())))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST item - description 501 chars returns 400")
    void createItem_descriptionTooLong_400() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        String desc = "D".repeat(501);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuItemRequest.builder()
                                        .name("Item").description(desc).priceMinor(100).currency("CZK").available(true).sortOrder(0).build())))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST item - unknown categoryId returns 404")
    void createItem_unknownCategory_404() throws Exception {
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Item","priceMinor":100,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST item - anonymous gets 401")
    void createItem_anon_401() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Item","priceMinor":100,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isUnauthorized());
    }

    // ── PUT item ──────────────────────────────────────────────────────────────

    @Test
    @DisplayName("PUT item - happy path updates all fields")
    void updateItem_happyPath() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        MenuItem item = saveItem(cat.getId(), "Old name", 100, true);

        mockMvc.perform(put(ITEM_URL.formatted(item.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "name":"New name",
                                  "description":"New desc",
                                  "priceMinor":50000,
                                  "currency":"CZK",
                                  "available":false,
                                  "sortOrder":3
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.name").value("New name"))
                .andExpect(jsonPath("$.priceMinor").value(50000))
                .andExpect(jsonPath("$.available").value(false));

        MenuItem updated = itemRepository.findById(item.getId()).orElseThrow();
        assertThat(updated.getName()).isEqualTo("New name");
        assertThat(updated.getPriceMinor()).isEqualTo(50000);
        assertThat(updated.isAvailable()).isFalse();
    }

    @Test
    @DisplayName("PUT item - unknown id returns 404")
    void updateItem_unknownId_404() throws Exception {
        mockMvc.perform(put(ITEM_URL.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"X","priceMinor":0,"currency":"CZK","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("PUT item - toggle available=false hides it from public menu")
    void updateItem_toggleUnavailable_hiddenFromPublicMenu() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        MenuItem item = saveItem(cat.getId(), "Visible", 5000, true);

        // Toggle off
        mockMvc.perform(put(ITEM_URL.formatted(item.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Visible","priceMinor":5000,"currency":"CZK","available":false,"sortOrder":0}
                                """))
                .andExpect(status().isOk());

        // Public endpoint should not return it
        mockMvc.perform(get("/api/v1/restaurants/%s/menu".formatted(restaurantId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(0));
    }

    // ── DELETE item ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("DELETE item - returns 204 and removes from DB")
    void deleteItem_happyPath() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        MenuItem item = saveItem(cat.getId(), "ToDelete", 1000, true);

        mockMvc.perform(delete(ITEM_URL.formatted(item.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());

        assertThat(itemRepository.findById(item.getId())).isEmpty();
    }

    @Test
    @DisplayName("DELETE item - unknown id returns 404")
    void deleteItem_unknownId_404() throws Exception {
        mockMvc.perform(delete(ITEM_URL.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("DELETE item - idempotency: second delete returns 404")
    void deleteItem_idempotency() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        MenuItem item = saveItem(cat.getId(), "DoubleDelete", 1000, true);

        mockMvc.perform(delete(ITEM_URL.formatted(item.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());

        mockMvc.perform(delete(ITEM_URL.formatted(item.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("DELETE item - anonymous gets 401")
    void deleteItem_anon_401() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        MenuItem item = saveItem(cat.getId(), "Item", 1000, true);

        mockMvc.perform(delete(ITEM_URL.formatted(item.getId())))
                .andExpect(status().isUnauthorized());
    }

    // GAP: currency field missing @NotBlank — 4-char currency bypasses @Size(max=3)
    @Test
    @DisplayName("POST item - currency longer than 3 chars should return 400")
    void createItem_currencyTooLong_400() throws Exception {
        MenuCategory cat = saveCategory("Cat", 0);
        mockMvc.perform(post(ITEMS_IN_CAT.formatted(cat.getId()))
                        .header("Authorization", "Bearer " + ownerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {"name":"Item","priceMinor":100,"currency":"EURO","available":true,"sortOrder":0}
                                """))
                .andExpect(status().isBadRequest());
    }

    // ── private helper ────────────────────────────────────────────────────────

    /** Creates a second owner with a separate restaurant, returns the owner's token. */
    private String createOwnerWithAnotherRestaurant() throws Exception {
        String email = "other-owner@checkfood.test";
        createVerifiedUser(email, TEST_PASSWORD, "Other", "Owner");
        var user = userRepository.findByEmail(email).orElseThrow();
        var ownerRole = roleRepository.findByName("OWNER").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(ownerRole);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        Restaurant otherRestaurant = Restaurant.builder()
                .ownerId(UUID.randomUUID())
                .name("Other Restaurant")
                .cuisineType(CuisineType.ITALIAN)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder().street("Other").streetNumber("2").city("Brno")
                        .postalCode("60200").country("CZ").build())
                .build();
        Restaurant savedOther = restaurantRepository.saveAndFlush(otherRestaurant);

        employeeRepository.saveAndFlush(RestaurantEmployee.builder()
                .user(user)
                .restaurant(savedOther)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EnumSet.allOf(EmployeePermission.class))
                .build());

        return loginAndGetToken(email, "device-other-owner");
    }
}
