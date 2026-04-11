package com.checkfood.checkfoodservice.module.panorama;

import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSession;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSessionStatus;
import com.checkfood.checkfoodservice.module.restaurant.menu.BaseMenuIntegrationTest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for PanoramaController — full Spring context, H2, mocked StorageService.
 */
@Transactional
class PanoramaControllerIntegrationTest extends BaseMenuIntegrationTest {

    private static final String SESSIONS = "/api/v1/owner/restaurant/me/panorama/sessions";
    private static final String SESSION = "/api/v1/owner/restaurant/me/panorama/sessions/%s";
    private static final String PHOTOS = "/api/v1/owner/restaurant/me/panorama/sessions/%s/photos";
    private static final String FINALIZE = "/api/v1/owner/restaurant/me/panorama/sessions/%s/finalize";
    private static final String ACTIVATE = "/api/v1/owner/restaurant/me/panorama/sessions/%s/activate";

    @MockitoBean(name = "publicLocalStorage")
    StorageService storageService;

    @BeforeEach
    void setUpStorage() {
        when(storageService.store(anyString(), anyString(), any(byte[].class), anyString()))
                .thenReturn("restaurants/test/panorama/session/photo.jpg");
        when(storageService.getDownloadUrl(anyString()))
                .thenReturn("https://cdn.example.com/panorama/photo.jpg");
    }

    // ── authorization matrix ──────────────────────────────────────────────────

    @Test
    @DisplayName("POST /sessions - anonymous gets 401")
    void createSession_anon_401() throws Exception {
        mockMvc.perform(post(SESSIONS)).andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /sessions - USER role gets 403")
    void createSession_userRole_403() throws Exception {
        String token = getAccessToken("regularuserpan@checkfood.test", TEST_PASSWORD, "device-pan-user");
        mockMvc.perform(post(SESSIONS).header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("GET /sessions - anonymous gets 401")
    void listSessions_anon_401() throws Exception {
        mockMvc.perform(get(SESSIONS)).andExpect(status().isUnauthorized());
    }

    // ── createSession ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("POST /sessions - owner creates session, status is UPLOADING")
    void createSession_happyPath() throws Exception {
        mockMvc.perform(post(SESSIONS).header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").isNotEmpty())
                .andExpect(jsonPath("$.status").value("UPLOADING"))
                .andExpect(jsonPath("$.photoCount").value(0));

        assertThat(panoramaSessionRepository.findAllByRestaurantIdOrderByCreatedAtDesc(restaurantId))
                .hasSize(1)
                .allMatch(s -> s.getStatus() == PanoramaSessionStatus.UPLOADING);
    }

    // ── listSessions ──────────────────────────────────────────────────────────

    @Test
    @DisplayName("GET /sessions - returns empty list when none")
    void listSessions_empty() throws Exception {
        mockMvc.perform(get(SESSIONS).header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$.length()").value(0));
    }

    @Test
    @DisplayName("GET /sessions - returns created sessions")
    void listSessions_returnsSessions() throws Exception {
        // create two sessions
        panoramaSessionRepository.saveAndFlush(PanoramaSession.builder()
                .restaurantId(restaurantId).status(PanoramaSessionStatus.UPLOADING)
                .photoCount(0).createdAt(LocalDateTime.now().minusDays(1)).build());
        panoramaSessionRepository.saveAndFlush(PanoramaSession.builder()
                .restaurantId(restaurantId).status(PanoramaSessionStatus.UPLOADING)
                .photoCount(5).createdAt(LocalDateTime.now()).build());

        mockMvc.perform(get(SESSIONS).header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2));
    }

    // ── getSessionStatus ──────────────────────────────────────────────────────

    @Test
    @DisplayName("GET /sessions/{id} - returns session status")
    void getSessionStatus_happyPath() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.UPLOADING)
                        .photoCount(3)
                        .createdAt(LocalDateTime.now())
                        .build());

        mockMvc.perform(get(SESSION.formatted(session.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(session.getId().toString()))
                .andExpect(jsonPath("$.status").value("UPLOADING"))
                .andExpect(jsonPath("$.photoCount").value(3));
    }

    @Test
    @DisplayName("GET /sessions/{id} - unknown id returns 404")
    void getSessionStatus_unknownId_404() throws Exception {
        mockMvc.perform(get(SESSION.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    // ── uploadPhoto ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("POST /sessions/{id}/photos - uploads photo and updates photo count")
    void uploadPhoto_happyPath() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.UPLOADING)
                        .photoCount(0)
                        .createdAt(LocalDateTime.now())
                        .build());

        MockMultipartFile file = new MockMultipartFile("file", "photo.jpg", "image/jpeg", new byte[1024]);

        mockMvc.perform(multipart(PHOTOS.formatted(session.getId()))
                        .file(file)
                        .param("angleIndex", "0")
                        .param("actualAngle", "2.5")
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").isNotEmpty())
                .andExpect(jsonPath("$.angleIndex").value(0))
                .andExpect(jsonPath("$.photoUrl").value("https://cdn.example.com/panorama/photo.jpg"));
    }

    @Test
    @DisplayName("POST /sessions/{id}/photos - session not in UPLOADING state returns 400")
    void uploadPhoto_sessionNotUploading_400() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.PROCESSING)
                        .photoCount(10)
                        .createdAt(LocalDateTime.now())
                        .build());

        MockMultipartFile file = new MockMultipartFile("file", "photo.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(PHOTOS.formatted(session.getId()))
                        .file(file)
                        .param("angleIndex", "0")
                        .param("actualAngle", "0.0")
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /sessions/{id}/photos - unknown sessionId returns 404")
    void uploadPhoto_unknownSession_404() throws Exception {
        MockMultipartFile file = new MockMultipartFile("file", "photo.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(PHOTOS.formatted(UUID.randomUUID()))
                        .file(file)
                        .param("angleIndex", "0")
                        .param("actualAngle", "0.0")
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST /sessions/{id}/photos - optional actualPitch accepted when provided")
    void uploadPhoto_withActualPitch_accepted() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.UPLOADING)
                        .photoCount(0)
                        .createdAt(LocalDateTime.now())
                        .build());

        MockMultipartFile file = new MockMultipartFile("file", "p.jpg", "image/jpeg", new byte[100]);

        mockMvc.perform(multipart(PHOTOS.formatted(session.getId()))
                        .file(file)
                        .param("angleIndex", "8")
                        .param("actualAngle", "0.0")
                        .param("actualPitch", "28.5")
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.actualPitch").value(28.5));
    }

    // ── finalizeSession ───────────────────────────────────────────────────────

    @Test
    @DisplayName("POST /sessions/{id}/finalize - with >= 8 photos returns 200")
    void finalizeSession_enoughPhotos_200() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.UPLOADING)
                        .photoCount(0)
                        .createdAt(LocalDateTime.now())
                        .build());

        // upload 8 photos
        for (int i = 0; i < 8; i++) {
            MockMultipartFile file = new MockMultipartFile("file", "p" + i + ".jpg", "image/jpeg", new byte[100]);
            mockMvc.perform(multipart(PHOTOS.formatted(session.getId()))
                            .file(file)
                            .param("angleIndex", String.valueOf(i))
                            .param("actualAngle", String.valueOf(i * 45.0))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk());
        }

        mockMvc.perform(post(FINALIZE.formatted(session.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST /sessions/{id}/finalize - fewer than 8 photos returns 400")
    void finalizeSession_tooFewPhotos_400() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.UPLOADING)
                        .photoCount(0)
                        .createdAt(LocalDateTime.now())
                        .build());

        // upload only 3 photos
        for (int i = 0; i < 3; i++) {
            MockMultipartFile file = new MockMultipartFile("file", "p" + i + ".jpg", "image/jpeg", new byte[100]);
            mockMvc.perform(multipart(PHOTOS.formatted(session.getId()))
                            .file(file)
                            .param("angleIndex", String.valueOf(i))
                            .param("actualAngle", String.valueOf(i * 45.0))
                            .header("Authorization", "Bearer " + ownerToken))
                    .andExpect(status().isOk());
        }

        mockMvc.perform(post(FINALIZE.formatted(session.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /sessions/{id}/finalize - unknown session returns 404")
    void finalizeSession_unknownId_404() throws Exception {
        mockMvc.perform(post(FINALIZE.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST /sessions/{id}/finalize - anonymous gets 401")
    void finalizeSession_anon_401() throws Exception {
        mockMvc.perform(post(FINALIZE.formatted(UUID.randomUUID())))
                .andExpect(status().isUnauthorized());
    }

    // ── setActivePanorama ─────────────────────────────────────────────────────

    // GAP: COMPLETED status requires stitcher callback which is removed;
    // activation of a non-COMPLETED session (e.g. UPLOADING) should return 400.
    @Test
    @DisplayName("POST /sessions/{id}/activate - UPLOADING session returns 400")
    void activatePanorama_uploadingSession_400() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.UPLOADING)
                        .photoCount(20)
                        .createdAt(LocalDateTime.now())
                        .build());

        mockMvc.perform(post(ACTIVATE.formatted(session.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /sessions/{id}/activate - unknown session returns 404")
    void activatePanorama_unknownSession_404() throws Exception {
        mockMvc.perform(post(ACTIVATE.formatted(UUID.randomUUID()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST /sessions/{id}/activate - anonymous gets 401")
    void activatePanorama_anon_401() throws Exception {
        mockMvc.perform(post(ACTIVATE.formatted(UUID.randomUUID())))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /sessions/{id}/activate - COMPLETED session activates panorama and sets URL on restaurant")
    void activatePanorama_completedSession_setsUrl() throws Exception {
        PanoramaSession session = panoramaSessionRepository.saveAndFlush(
                PanoramaSession.builder()
                        .restaurantId(restaurantId)
                        .status(PanoramaSessionStatus.COMPLETED)
                        .photoCount(20)
                        .resultUrl("https://cdn.example.com/panorama_result.jpg")
                        .createdAt(LocalDateTime.now())
                        .build());

        mockMvc.perform(post(ACTIVATE.formatted(session.getId()))
                        .header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk());

        assertThat(restaurantRepository.findById(restaurantId).orElseThrow().getPanoramaUrl())
                .isEqualTo("https://cdn.example.com/panorama_result.jpg");
    }

    // GAP: no pagination on GET /sessions — returns everything unbounded
    @Test
    @DisplayName("GET /sessions - pagination not implemented (returns all unbounded)")
    void listSessions_noPagination_returnsAllUnbounded() throws Exception {
        for (int i = 0; i < 25; i++) {
            panoramaSessionRepository.saveAndFlush(PanoramaSession.builder()
                    .restaurantId(restaurantId).status(PanoramaSessionStatus.UPLOADING)
                    .photoCount(0).createdAt(LocalDateTime.now().minusMinutes(i)).build());
        }

        mockMvc.perform(get(SESSIONS).header("Authorization", "Bearer " + ownerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(25));
        // GAP: should support ?page=0&size=20 parameters; currently returns all 25
    }
}
