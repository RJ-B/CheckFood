package com.checkfood.checkfoodservice.module.restaurant.media;

import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.module.restaurant.menu.BaseMenuIntegrationTest;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for MenuItemMediaController.
 * StorageService is mocked — no real GCS calls.
 */
@Transactional
class MenuItemMediaControllerIntegrationTest extends BaseMenuIntegrationTest {

    private static final String UPLOAD_URL = "/api/v1/owner/restaurants/%s/menu-items/%s/image";

    @MockitoBean(name = "publicLocalStorage")
    StorageService storageService;

    private MenuCategory category;
    private MenuItem item;

    @BeforeEach
    void setUpItem() {
        // storageService qualifier is @PublicStorage — both beans are mocked by type;
        // the controller uses @PublicStorage-qualified bean but MockitoBean replaces by type.
        when(storageService.store(anyString(), anyString(), any(byte[].class), anyString()))
                .thenReturn("restaurants/test-restaurant/menu-items/test-item/image.jpg");
        when(storageService.getDownloadUrl(anyString()))
                .thenReturn("https://cdn.example.com/image.jpg");

        category = saveCategory("TestCat", 0);
        item = saveItem(category.getId(), "Burger", 14900, true);
    }

    // ── happy path: upload ────────────────────────────────────────────────────

    @Test
    @DisplayName("POST image - owner uploads JPEG, gets 200 with url")
    void uploadImage_jpeg_returns200() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file", "burger.jpg", "image/jpeg", "fake-jpeg-bytes".getBytes());

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.url").value("https://cdn.example.com/image.jpg"));

        // verify URL is persisted on the MenuItem
        MenuItem updated = itemRepository.findById(item.getId()).orElseThrow();
        assertThat(updated.getImageUrl()).isEqualTo("https://cdn.example.com/image.jpg");
    }

    @Test
    @DisplayName("POST image - PNG is also accepted")
    void uploadImage_png_accepted() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file", "img.png", "image/png", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST image - WebP is accepted")
    void uploadImage_webp_accepted() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file", "img.webp", "image/webp", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());
    }

    // ── mime validation ───────────────────────────────────────────────────────

    @Test
    @DisplayName("POST image - GIF is rejected with 415")
    void uploadImage_gif_415() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file", "anim.gif", "image/gif", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isUnsupportedMediaType());
    }

    @Test
    @DisplayName("POST image - PDF is rejected with 415")
    void uploadImage_pdf_415() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file", "doc.pdf", "application/pdf", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isUnsupportedMediaType());
    }

    @Test
    @DisplayName("POST image - null content type is rejected with 415")
    void uploadImage_noContentType_415() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file", "img", null, new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isUnsupportedMediaType());
    }

    // ── size limit ────────────────────────────────────────────────────────────

    @Test
    @DisplayName("POST image - file exactly 5 MB is accepted")
    void uploadImage_exactly5MB_accepted() throws Exception {
        byte[] data = new byte[5 * 1024 * 1024]; // exactly 5 MB
        MockMultipartFile file = new MockMultipartFile("file", "big.jpg", "image/jpeg", data);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST image - file 5 MB + 1 byte is rejected with 413")
    void uploadImage_over5MB_413() throws Exception {
        byte[] data = new byte[5 * 1024 * 1024 + 1];
        MockMultipartFile file = new MockMultipartFile("file", "toobig.jpg", "image/jpeg", data);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isPayloadTooLarge());
    }

    @Test
    @DisplayName("POST image - empty file returns 400")
    void uploadImage_emptyFile_400() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file", "empty.jpg", "image/jpeg", new byte[0]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isBadRequest());
    }

    // ── authorization ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("POST image - anonymous gets 401")
    void uploadImage_anon_401() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file", "img.jpg", "image/jpeg", new byte[100]);
        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId())).file(file))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST image - regular USER role gets 403")
    void uploadImage_userRole_403() throws Exception {
        String userToken = getAccessToken("regularusermedia@checkfood.test", TEST_PASSWORD, "device-media-user");
        MockMultipartFile file = new MockMultipartFile("file", "img.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + userToken))
                .andExpect(status().isForbidden());
    }

    // ── resource not found ────────────────────────────────────────────────────

    @Test
    @DisplayName("POST image - unknown itemId returns 404")
    void uploadImage_unknownItem_404() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file", "img.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, UUID.randomUUID()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST image - item belongs to different restaurant gets 403/404")
    void uploadImage_itemFromOtherRestaurant_error() throws Exception {
        // item is in this restaurant; try with a random restaurantId that doesn't match
        MockMultipartFile file = new MockMultipartFile("file", "img.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(UUID.randomUUID(), item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(result ->
                        assertThat(result.getResponse().getStatus()).isIn(403, 404, 400));
    }

    // ── replace (old URL deleted) ─────────────────────────────────────────────

    @Test
    @DisplayName("POST image - replacing existing image calls storage delete for old URL")
    void uploadImage_replace_deleteOldUrl() throws Exception {
        // first upload sets imageUrl
        item.setImageUrl("https://cdn.example.com/checkfood-uploads/old.jpg");
        itemRepository.saveAndFlush(item);

        // configure mock to return new url
        when(storageService.getDownloadUrl(anyString()))
                .thenReturn("https://cdn.example.com/checkfood-uploads/new.jpg");

        MockMultipartFile file = new MockMultipartFile("file", "new.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());

        verify(storageService).delete(anyString());
    }

    // ── DELETE image ──────────────────────────────────────────────────────────

    @Test
    @DisplayName("DELETE image - removes imageUrl from item and returns 204")
    void deleteImage_happyPath() throws Exception {
        item.setImageUrl("https://cdn.example.com/checkfood-uploads/img.jpg");
        itemRepository.saveAndFlush(item);

        mockMvc.perform(delete(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());

        assertThat(itemRepository.findById(item.getId()).orElseThrow().getImageUrl()).isNull();
    }

    @Test
    @DisplayName("DELETE image - no image present still returns 204 (idempotent)")
    void deleteImage_noImage_idempotent() throws Exception {
        assertThat(item.getImageUrl()).isNull(); // precondition

        mockMvc.perform(delete(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("DELETE image - anonymous gets 401")
    void deleteImage_anon_401() throws Exception {
        mockMvc.perform(delete(UPLOAD_URL.formatted(restaurantId, item.getId())))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("DELETE image - unknown itemId returns 404")
    void deleteImage_unknownItem_404() throws Exception {
        mockMvc.perform(delete(UPLOAD_URL.formatted(restaurantId, UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    // GAP: StorageService is called with @PublicStorage qualifier — MockitoBean replaces
    // all StorageService beans of same type, so the qualified injection may not be satisfied
    // if the production code uses constructor injection with @PublicStorage qualifier.
    // If this test fails with NoSuchBeanDefinitionException, the context wiring needs adjustment.
    @Test
    @DisplayName("POST image - storage.store is called with correct directory prefix")
    void uploadImage_storageCalledWithCorrectDirectory() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file", "img.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(UPLOAD_URL.formatted(restaurantId, item.getId()))
                        .file(file)
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());

        verify(storageService).store(
                eq("restaurants/" + restaurantId + "/menu-items/" + item.getId()),
                anyString(), any(byte[].class), eq("image/jpeg"));
    }
}
