package com.checkfood.checkfoodservice.module.panorama;

import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaPhotoResponse;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaPhoto;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSession;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSessionStatus;
import com.checkfood.checkfoodservice.module.panorama.exception.PanoramaException;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaPhotoRepository;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaSessionRepository;
import com.checkfood.checkfoodservice.module.panorama.service.PanoramaServiceImpl;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

/**
 * Unit tests for PanoramaServiceImpl — no Spring context.
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class PanoramaServiceTest {

    @Mock PanoramaSessionRepository sessionRepository;
    @Mock PanoramaPhotoRepository photoRepository;
    @Mock RestaurantEmployeeRepository employeeRepository;
    @Mock RestaurantRepository restaurantRepository;
    @Mock StorageService storageService;
    @Mock UserService userService;

    @InjectMocks PanoramaServiceImpl panoramaService;

    private static final String EMAIL = "owner@test.com";
    private final UUID restaurantId = UUID.randomUUID();
    private UserEntity user;
    private Restaurant restaurant;
    private RestaurantEmployee membership;

    @BeforeEach
    void setUp() {
        user = mock(UserEntity.class);
        when(user.getId()).thenReturn(99L);

        restaurant = mock(Restaurant.class);
        when(restaurant.getId()).thenReturn(restaurantId);

        membership = mock(RestaurantEmployee.class);
        when(membership.getRestaurant()).thenReturn(restaurant);

        when(userService.findByEmail(EMAIL)).thenReturn(user);
        when(employeeRepository.findFirstByUserIdAndRole(99L, RestaurantEmployeeRole.OWNER))
                .thenReturn(Optional.of(membership));
    }

    // ── createSession ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("createSession - saves session with UPLOADING status and returns response")
    void createSession_savesUploadingSession() {
        var saved = PanoramaSession.builder()
                .id(UUID.randomUUID())
                .restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING)
                .photoCount(0)
                .createdAt(LocalDateTime.now())
                .build();
        when(sessionRepository.save(any())).thenReturn(saved);

        var result = panoramaService.createSession(EMAIL);

        assertThat(result.getStatus()).isEqualTo("UPLOADING");
        assertThat(result.getPhotoCount()).isZero();
        verify(sessionRepository).save(any());
    }

    @Test
    @DisplayName("createSession - no restaurant assigned throws RestaurantException")
    void createSession_noRestaurant_throws() {
        when(employeeRepository.findFirstByUserIdAndRole(99L, RestaurantEmployeeRole.OWNER))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> panoramaService.createSession(EMAIL))
                .isInstanceOf(RestaurantException.class);
    }

    // ── uploadPhoto ───────────────────────────────────────────────────────────

    @Test
    @DisplayName("uploadPhoto - stores file and saves photo entity")
    void uploadPhoto_savesPhoto() throws Exception {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder()
                .id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(0)
                .createdAt(LocalDateTime.now()).build();

        var savedPhoto = PanoramaPhoto.builder()
                .id(UUID.randomUUID()).sessionId(sessionId)
                .angleIndex(0).targetAngle(0.0).actualAngle(2.0)
                .photoUrl("https://cdn.example.com/photo.jpg").build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));
        when(storageService.store(anyString(), anyString(), any(), anyString()))
                .thenReturn("restaurants/test/panorama/sessions/test/angle_0.jpg");
        when(storageService.getDownloadUrl(anyString()))
                .thenReturn("https://cdn.example.com/photo.jpg");
        when(photoRepository.save(any())).thenReturn(savedPhoto);
        when(photoRepository.countBySessionId(sessionId)).thenReturn(1);
        when(sessionRepository.save(any())).thenReturn(session);

        MultipartFile file = mockFile("photo.jpg");
        var result = panoramaService.uploadPhoto(EMAIL, sessionId, 0, 2.0, null, file);

        assertThat(result.getPhotoUrl()).isEqualTo("https://cdn.example.com/photo.jpg");
        assertThat(result.getAngleIndex()).isZero();
        verify(photoRepository).save(any());
    }

    @Test
    @DisplayName("uploadPhoto - session not in UPLOADING state throws PanoramaException")
    void uploadPhoto_wrongState_throws() throws Exception {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder()
                .id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.PROCESSING).photoCount(5)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        MultipartFile file = mockFile("p.jpg");

        assertThatThrownBy(() -> panoramaService.uploadPhoto(EMAIL, sessionId, 0, 0.0, null, file))
                .isInstanceOf(PanoramaException.class);
    }

    @Test
    @DisplayName("uploadPhoto - session not found throws PanoramaException")
    void uploadPhoto_sessionNotFound_throws() throws Exception {
        UUID sessionId = UUID.randomUUID();
        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.empty());

        MultipartFile file = mockFile("p.jpg");

        assertThatThrownBy(() -> panoramaService.uploadPhoto(EMAIL, sessionId, 0, 0.0, null, file))
                .isInstanceOf(PanoramaException.class);
    }

    @Test
    @DisplayName("uploadPhoto - angleIndex 0 maps to targetAngle 0 (horizon)")
    void uploadPhoto_angleIndex0_targetAngle0() throws Exception {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(0)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));
        when(storageService.store(anyString(), anyString(), any(), anyString())).thenReturn("path");
        when(storageService.getDownloadUrl(anyString())).thenReturn("http://url");
        when(photoRepository.countBySessionId(sessionId)).thenReturn(1);
        when(sessionRepository.save(any())).thenReturn(session);

        var savedPhoto = PanoramaPhoto.builder()
                .id(UUID.randomUUID()).sessionId(sessionId)
                .angleIndex(0).targetAngle(0.0).actualAngle(1.0)
                .photoUrl("http://url").build();
        when(photoRepository.save(any())).thenReturn(savedPhoto);

        MultipartFile file = mockFile("p.jpg");
        var result = panoramaService.uploadPhoto(EMAIL, sessionId, 0, 1.0, null, file);

        assertThat(result.getTargetAngle()).isEqualTo(0.0);
    }

    @Test
    @DisplayName("uploadPhoto - angleIndex 4 maps to targetAngle 180 (horizon back)")
    void uploadPhoto_angleIndex4_targetAngle180() throws Exception {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(0)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));
        when(storageService.store(anyString(), anyString(), any(), anyString())).thenReturn("path");
        when(storageService.getDownloadUrl(anyString())).thenReturn("http://url");
        when(photoRepository.countBySessionId(sessionId)).thenReturn(1);
        when(sessionRepository.save(any())).thenReturn(session);

        var savedPhoto = PanoramaPhoto.builder()
                .id(UUID.randomUUID()).sessionId(sessionId)
                .angleIndex(4).targetAngle(180.0).actualAngle(178.0)
                .photoUrl("http://url").build();
        when(photoRepository.save(any())).thenReturn(savedPhoto);

        MultipartFile file = mockFile("p.jpg");
        var result = panoramaService.uploadPhoto(EMAIL, sessionId, 4, 178.0, null, file);

        assertThat(result.getTargetAngle()).isEqualTo(180.0);
    }

    // ── finalizeSession ───────────────────────────────────────────────────────

    @Test
    @DisplayName("finalizeSession - with 8 photos returns session (no status change without stitcher)")
    void finalizeSession_8Photos_succeeds() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(8)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));
        when(photoRepository.countBySessionId(sessionId)).thenReturn(8);
        when(sessionRepository.save(any())).thenReturn(session);

        var result = panoramaService.finalizeSession(EMAIL, sessionId);

        assertThat(result).isNotNull();
    }

    @Test
    @DisplayName("finalizeSession - with fewer than 8 photos throws PanoramaException")
    void finalizeSession_tooFewPhotos_throws() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(3)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));
        when(photoRepository.countBySessionId(sessionId)).thenReturn(3);

        assertThatThrownBy(() -> panoramaService.finalizeSession(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class)
                .hasMessageContaining("8");
    }

    @Test
    @DisplayName("finalizeSession - session not in UPLOADING state throws PanoramaException")
    void finalizeSession_wrongState_throws() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.COMPLETED).photoCount(20)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        assertThatThrownBy(() -> panoramaService.finalizeSession(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class);
    }

    @Test
    @DisplayName("finalizeSession - session not found throws PanoramaException")
    void finalizeSession_notFound_throws() {
        UUID sessionId = UUID.randomUUID();
        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> panoramaService.finalizeSession(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class);
    }

    // ── getSessionStatus ──────────────────────────────────────────────────────

    @Test
    @DisplayName("getSessionStatus - returns correct session data")
    void getSessionStatus_returnsData() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(5)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        var result = panoramaService.getSessionStatus(EMAIL, sessionId);

        assertThat(result.getId()).isEqualTo(sessionId);
        assertThat(result.getStatus()).isEqualTo("UPLOADING");
        assertThat(result.getPhotoCount()).isEqualTo(5);
    }

    @Test
    @DisplayName("getSessionStatus - session not found throws PanoramaException")
    void getSessionStatus_notFound_throws() {
        UUID sessionId = UUID.randomUUID();
        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> panoramaService.getSessionStatus(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class);
    }

    // ── listSessions ──────────────────────────────────────────────────────────

    @Test
    @DisplayName("listSessions - returns all sessions for restaurant ordered desc")
    void listSessions_returnsAll() {
        var s1 = PanoramaSession.builder().id(UUID.randomUUID()).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.COMPLETED).photoCount(20)
                .createdAt(LocalDateTime.now().minusDays(1)).build();
        var s2 = PanoramaSession.builder().id(UUID.randomUUID()).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(0)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findAllByRestaurantIdOrderByCreatedAtDesc(restaurantId))
                .thenReturn(List.of(s2, s1));

        var result = panoramaService.listSessions(EMAIL);

        assertThat(result).hasSize(2);
        assertThat(result.get(0).getStatus()).isEqualTo("UPLOADING");
    }

    @Test
    @DisplayName("listSessions - empty list when no sessions")
    void listSessions_empty() {
        when(sessionRepository.findAllByRestaurantIdOrderByCreatedAtDesc(restaurantId))
                .thenReturn(List.of());

        var result = panoramaService.listSessions(EMAIL);

        assertThat(result).isEmpty();
    }

    // ── setActivePanorama ─────────────────────────────────────────────────────

    @Test
    @DisplayName("setActivePanorama - COMPLETED session sets panoramaUrl on restaurant")
    void setActivePanorama_completed_setsUrl() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.COMPLETED).photoCount(20)
                .resultUrl("https://cdn.example.com/panorama.jpg")
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        Restaurant realRestaurant = mock(Restaurant.class);
        when(restaurantRepository.findById(restaurantId)).thenReturn(Optional.of(realRestaurant));

        panoramaService.setActivePanorama(EMAIL, sessionId);

        verify(realRestaurant).setPanoramaUrl("https://cdn.example.com/panorama.jpg");
        verify(restaurantRepository).save(realRestaurant);
    }

    @Test
    @DisplayName("setActivePanorama - non-COMPLETED session throws PanoramaException")
    void setActivePanorama_notCompleted_throws() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.UPLOADING).photoCount(5)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        assertThatThrownBy(() -> panoramaService.setActivePanorama(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class)
                .hasMessageContaining("dokončená");
    }

    @Test
    @DisplayName("setActivePanorama - PROCESSING session throws PanoramaException")
    void setActivePanorama_processing_throws() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.PROCESSING).photoCount(20)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        assertThatThrownBy(() -> panoramaService.setActivePanorama(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class);
    }

    @Test
    @DisplayName("setActivePanorama - FAILED session throws PanoramaException")
    void setActivePanorama_failed_throws() {
        UUID sessionId = UUID.randomUUID();
        var session = PanoramaSession.builder().id(sessionId).restaurantId(restaurantId)
                .status(PanoramaSessionStatus.FAILED).photoCount(0)
                .createdAt(LocalDateTime.now()).build();

        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.of(session));

        assertThatThrownBy(() -> panoramaService.setActivePanorama(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class);
    }

    @Test
    @DisplayName("setActivePanorama - session not found throws PanoramaException")
    void setActivePanorama_sessionNotFound_throws() {
        UUID sessionId = UUID.randomUUID();
        when(sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> panoramaService.setActivePanorama(EMAIL, sessionId))
                .isInstanceOf(PanoramaException.class);
    }

    // ── helpers ────────────────────────────────────────────────────────────────

    private MultipartFile mockFile(String filename) throws IOException {
        MultipartFile file = mock(MultipartFile.class);
        when(file.getOriginalFilename()).thenReturn(filename);
        when(file.getContentType()).thenReturn("image/jpeg");
        when(file.getBytes()).thenReturn(new byte[100]);
        return file;
    }
}
