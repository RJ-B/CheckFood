package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantPhotoRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for RestaurantMediaController — logo, cover, gallery upload/delete.
 * StorageService is mocked to avoid GCS calls.
 */
@Transactional
class RestaurantMediaControllerIntegrationTest extends BaseAuthIntegrationTest {

    private static final String OWNER_EMAIL = "media-owner@checkfood.test";
    private static final String USER_EMAIL  = "media-user@checkfood.test";

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private RestaurantEmployeeRepository employeeRepository;

    @Autowired
    private RestaurantPhotoRepository photoRepository;

    /**
     * Mock the StorageService so no real GCS calls happen.
     * The @PublicStorage qualifier means we need to match the bean name.
     */
    @MockitoBean(name = "publicStorageService")
    private StorageService storageService;

    @BeforeEach
    void ensureRolesAndMocks() {
        ensureRole("OWNER");
        ensureRole("MANAGER");
        // Default storage mock behaviour
        when(storageService.store(anyString(), anyString(), any(byte[].class), anyString()))
                .thenReturn("restaurants/test-id/logo/file.jpg");
        when(storageService.getDownloadUrl(anyString()))
                .thenReturn("https://storage.test/file.jpg");
    }

    // =========================================================================
    // POST /api/v1/owner/restaurants/{id}/logo
    // =========================================================================

    @Nested
    @DisplayName("POST logo upload")
    class UploadLogo {

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401_when_anonymous() throws Exception {
            MockMultipartFile file = validJpeg("logo.jpg");

            mockMvc.perform(multipart("/api/v1/owner/restaurants/" + UUID.randomUUID() + "/logo")
                            .file(file))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 when USER role (no OWNER or MANAGER)")
        void should_return403_when_regularUser() throws Exception {
            String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-logo");

            MockMultipartFile file = validJpeg("logo.jpg");
            mockMvc.perform(multipart("/api/v1/owner/restaurants/" + UUID.randomUUID() + "/logo")
                            .file(file)
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isForbidden());
        }

        @Test
        @DisplayName("400 when file is empty")
        void should_return400_when_fileIsEmpty() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Logo Empty Test");
            var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            UUID restaurantId = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                    .orElseThrow().getRestaurant().getId();

            MockMultipartFile emptyFile = new MockMultipartFile("file", "logo.jpg",
                    MediaType.IMAGE_JPEG_VALUE, new byte[0]);

            mockMvc.perform(multipart("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                            .file(emptyFile)
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("415 when file content type is not image/jpeg, image/png, or image/webp")
        void should_return415_when_unsupportedMimeType() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Logo MIME Test");
            var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            UUID restaurantId = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                    .orElseThrow().getRestaurant().getId();

            MockMultipartFile gifFile = new MockMultipartFile("file", "logo.gif",
                    "image/gif", "GIF89a".getBytes());

            mockMvc.perform(multipart("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                            .file(gifFile)
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isUnsupportedMediaType());
        }
    }

    // =========================================================================
    // GET /api/v1/restaurants/{id}/gallery (public)
    // =========================================================================

    @Test
    @DisplayName("GET gallery — anonymous user can view gallery")
    void should_return200_when_galleryRequestedAnonymously() throws Exception {
        Restaurant r = restaurantRepository.save(aRestaurant("Gallery Restaurant"));

        mockMvc.perform(get("/api/v1/restaurants/" + r.getId() + "/gallery"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray());
    }

    // =========================================================================
    // DELETE /api/v1/owner/restaurants/{id}/gallery/{photoId}
    // =========================================================================

    @Nested
    @DisplayName("DELETE gallery photo")
    class DeleteGalleryPhoto {

        @Test
        @DisplayName("404 when photo does not exist")
        void should_return404_when_photoNotFound() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Gallery Delete Test");
            var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            UUID restaurantId = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                    .orElseThrow().getRestaurant().getId();

            mockMvc.perform(delete("/api/v1/owner/restaurants/" + restaurantId + "/gallery/" + UUID.randomUUID())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("403 when photo belongs to a different restaurant")
        void should_return403_when_photoFromOtherRestaurant() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Wrong Photo Test");
            Restaurant otherRestaurant = restaurantRepository.save(aRestaurant("Other Restaurant"));
            var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            UUID restaurantId = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                    .orElseThrow().getRestaurant().getId();

            // Save a photo belonging to the OTHER restaurant
            var photo = com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantPhoto.builder()
                    .restaurantId(otherRestaurant.getId())
                    .photoUrl("https://example.com/photo.jpg")
                    .objectPath("restaurants/" + otherRestaurant.getId() + "/gallery/photo.jpg")
                    .sortOrder(0)
                    .build();
            var savedPhoto = photoRepository.save(photo);

            // Try to delete it from OWNER's restaurant context
            mockMvc.perform(delete("/api/v1/owner/restaurants/" + restaurantId + "/gallery/" + savedPhoto.getId())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // DELETE /api/v1/owner/restaurants/{id}/logo
    // =========================================================================

    @Test
    @DisplayName("DELETE logo — 204 when logo exists and user is authorized")
    void should_return204_when_deletingLogo() throws Exception {
        String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Delete Logo Test");
        var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
        UUID restaurantId = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                .orElseThrow().getRestaurant().getId();

        // Set a logo URL directly
        var restaurant = restaurantRepository.findById(restaurantId).orElseThrow();
        restaurant.setLogoUrl("https://storage.test/logo.jpg");
        restaurantRepository.save(restaurant);

        mockMvc.perform(delete("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isNoContent());

        assertThat(restaurantRepository.findById(restaurantId).get().getLogoUrl()).isNull();
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private MockMultipartFile validJpeg(String filename) {
        byte[] jpegContent = new byte[]{(byte) 0xFF, (byte) 0xD8, (byte) 0xFF, (byte) 0xE0, 0x00, 0x10};
        return new MockMultipartFile("file", filename, MediaType.IMAGE_JPEG_VALUE, jpegContent);
    }

    private Restaurant aRestaurant(String name) {
        return Restaurant.builder()
                .name(name)
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Street")
                        .city("Praha")
                        .build())
                .build();
    }

    private String buildOwnerWithRestaurant(String email, String restaurantName) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName("OWNER").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        Restaurant restaurant = restaurantRepository.save(Restaurant.builder()
                .name(restaurantName)
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Testovací")
                        .streetNumber("1")
                        .city("Praha")
                        .build())
                .build());

        RestaurantEmployee ownership = RestaurantEmployee.builder()
                .user(user)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EmployeePermission.defaultsForRole(RestaurantEmployeeRole.OWNER))
                .build();
        employeeRepository.save(ownership);

        MvcResult result = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(email)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier("device-media-" + email.hashCode())
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();
        return objectMapper.readTree(result.getResponse().getContentAsString()).get("accessToken").asText();
    }

    private void ensureRole(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            RoleEntity r = new RoleEntity();
            r.setName(roleName);
            return roleRepository.save(r);
        });
    }
}
