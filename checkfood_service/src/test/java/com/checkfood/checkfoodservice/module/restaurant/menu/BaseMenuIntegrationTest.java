package com.checkfood.checkfoodservice.module.restaurant.menu;

import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaPhotoRepository;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaSessionRepository;
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
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import java.util.EnumSet;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Shared setup for all menu / panorama / media integration tests.
 * Creates a verified OWNER user + restaurant + employee record in H2.
 */
public abstract class BaseMenuIntegrationTest extends BaseAuthIntegrationTest {

    protected static final String OWNER_EMAIL = "menuowner@checkfood.test";
    protected static final String OTHER_EMAIL = "other@checkfood.test";
    protected static final String USER_EMAIL  = "regularuser@checkfood.test";

    @Autowired protected RestaurantRepository restaurantRepository;
    @Autowired protected RestaurantEmployeeRepository employeeRepository;
    @Autowired protected MenuCategoryRepository categoryRepository;
    @Autowired protected MenuItemRepository itemRepository;
    @Autowired protected PanoramaSessionRepository panoramaSessionRepository;
    @Autowired protected PanoramaPhotoRepository panoramaPhotoRepository;

    protected UUID restaurantId;
    protected String ownerToken;

    @BeforeEach
    void setUpMenuBase() throws Exception {
        // clean in dependency order
        panoramaPhotoRepository.deleteAll();
        panoramaSessionRepository.deleteAll();
        itemRepository.deleteAll();
        categoryRepository.deleteAll();
        employeeRepository.deleteAll();
        restaurantRepository.deleteAll();

        ensureRoleExists("OWNER");
        ensureRoleExists("MANAGER");

        ownerToken = createOwnerWithRestaurant(OWNER_EMAIL, "device-owner-1");
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    protected String createOwnerWithRestaurant(String email, String deviceId) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, "Menu", "Owner");

        var user = userRepository.findByEmail(email).orElseThrow();
        var ownerRole = roleRepository.findByName("OWNER").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(ownerRole);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        // Login first to obtain a JWT.
        String token = loginAndGetToken(email, deviceId);

        // The restaurant ownerId field stores a UUID that identifies the owner.
        // We use a random UUID here since the PanoramaController / MenuController resolve
        // the owner through RestaurantEmployee → user relationship, not via restaurant.ownerId directly.
        Restaurant restaurant = Restaurant.builder()
                .ownerId(UUID.randomUUID())
                .name("Test Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Testovaci")
                        .streetNumber("1")
                        .city("Praha")
                        .postalCode("11000")
                        .country("CZ")
                        .build())
                .build();
        Restaurant saved = restaurantRepository.saveAndFlush(restaurant);
        restaurantId = saved.getId();

        RestaurantEmployee emp = RestaurantEmployee.builder()
                .user(user)
                .restaurant(saved)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EnumSet.allOf(EmployeePermission.class))
                .build();
        employeeRepository.saveAndFlush(emp);

        return token;
    }


    protected String loginAndGetToken(String email, String deviceId) throws Exception {
        MvcResult result = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(email)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(deviceId)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();
        JsonNode body = parseResponseBody(result);
        return body.get("accessToken").asText();
    }

    protected MenuCategory saveCategory(String name, int sortOrder) {
        return categoryRepository.saveAndFlush(MenuCategory.builder()
                .restaurantId(restaurantId)
                .name(name)
                .sortOrder(sortOrder)
                .active(true)
                .build());
    }

    protected MenuItem saveItem(UUID categoryId, String name, int priceMinor, boolean available) {
        return itemRepository.saveAndFlush(MenuItem.builder()
                .restaurantId(restaurantId)
                .categoryId(categoryId)
                .name(name)
                .priceMinor(priceMinor)
                .currency("CZK")
                .available(available)
                .sortOrder(0)
                .build());
    }

    protected void ensureRoleExists(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            RoleEntity role = new RoleEntity();
            role.setName(roleName);
            return roleRepository.save(role);
        });
    }
}
