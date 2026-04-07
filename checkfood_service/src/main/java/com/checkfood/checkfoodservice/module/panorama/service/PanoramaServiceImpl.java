package com.checkfood.checkfoodservice.module.panorama.service;

import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaPhotoResponse;
import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaSessionResponse;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaPhoto;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSession;
import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSessionStatus;
import com.checkfood.checkfoodservice.module.panorama.exception.PanoramaException;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaPhotoRepository;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaSessionRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.storage.service.StorageService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Implementace správy panoramatických session — řídí nahrávání fotografií, komunikaci se stitcher službou
 * a aktualizaci stavu session na základě callbacků.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class PanoramaServiceImpl implements PanoramaService {

    private final PanoramaSessionRepository sessionRepository;
    private final PanoramaPhotoRepository photoRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final RestaurantRepository restaurantRepository;
    private final StorageService storageService;
    private final UserService userService;

    /**
     * {@inheritDoc}
     */
    @Override
    public PanoramaSessionResponse createSession(String userEmail) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = PanoramaSession.builder()
                .restaurantId(restaurantId)
                .build();
        var saved = sessionRepository.save(session);
        return toResponse(saved);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public PanoramaPhotoResponse uploadPhoto(String userEmail, UUID sessionId, int angleIndex, double actualAngle, Double actualPitch, MultipartFile file) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));

        if (session.getStatus() != PanoramaSessionStatus.UPLOADING) {
            throw PanoramaException.invalidState("Session není ve stavu UPLOADING.");
        }

        double[] targetYaws = {
                0, 45, 90, 135, 180, 225, 270, 315,       // horizon (0-7)
                0, 60, 120, 180, 240, 300,                 // upper (8-13)
                0, 60, 120, 180, 240, 300                  // lower (14-19)
        };
        double[] targetPitches = {
                0, 0, 0, 0, 0, 0, 0, 0,                   // horizon
                30, 30, 30, 30, 30, 30,                    // upper
                -30, -30, -30, -30, -30, -30               // lower
        };
        double targetAngle = (angleIndex >= 0 && angleIndex < targetYaws.length)
                ? targetYaws[angleIndex] : 0;
        Double targetPitch = (angleIndex >= 0 && angleIndex < targetPitches.length)
                ? targetPitches[angleIndex] : null;

        String directory = "panorama/" + sessionId;
        String extension = ".jpg";
        String originalName = file.getOriginalFilename();
        if (originalName != null && originalName.contains(".")) {
            extension = originalName.substring(originalName.lastIndexOf("."));
        }
        String filename = "angle_" + angleIndex + "_" + UUID.randomUUID() + extension;

        try {
            String path = storageService.store(directory, filename, file.getBytes(), file.getContentType());
            String url = storageService.getPublicUrl(path);

            var photo = PanoramaPhoto.builder()
                    .sessionId(sessionId)
                    .angleIndex(angleIndex)
                    .targetAngle(targetAngle)
                    .actualAngle(actualAngle)
                    .targetPitch(targetPitch)
                    .actualPitch(actualPitch)
                    .photoUrl(url)
                    .build();
            var savedPhoto = photoRepository.save(photo);

            session.setPhotoCount(photoRepository.countBySessionId(sessionId));
            sessionRepository.save(session);

            return PanoramaPhotoResponse.builder()
                    .id(savedPhoto.getId())
                    .angleIndex(savedPhoto.getAngleIndex())
                    .targetAngle(savedPhoto.getTargetAngle())
                    .actualAngle(savedPhoto.getActualAngle())
                    .targetPitch(savedPhoto.getTargetPitch())
                    .actualPitch(savedPhoto.getActualPitch())
                    .photoUrl(savedPhoto.getPhotoUrl())
                    .build();
        } catch (IOException e) {
            throw PanoramaException.systemError("Chyba při ukládání fotografie: " + e.getMessage());
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public PanoramaSessionResponse finalizeSession(String userEmail, UUID sessionId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));

        if (session.getStatus() != PanoramaSessionStatus.UPLOADING) {
            throw PanoramaException.invalidState("Session není ve stavu UPLOADING.");
        }

        int minPhotos = 8;
        int photoCount = photoRepository.countBySessionId(sessionId);
        if (photoCount < minPhotos) {
            throw PanoramaException.invalidState("Session vyžaduje " + minPhotos + " fotografií, nahráno: " + photoCount);
        }

        // Stitcher byl odstraněn — session zůstává v UPLOADING dokud nebude stitching reimplementován
        session.setPhotoCount(photoCount);
        var saved = sessionRepository.save(session);
        log.info("[Panorama] Session finalized with {} photos: session={}", photoCount, sessionId);

        return toResponse(saved);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    @Transactional(readOnly = true)
    public PanoramaSessionResponse getSessionStatus(String userEmail, UUID sessionId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));
        return toResponse(session);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    @Transactional(readOnly = true)
    public List<PanoramaSessionResponse> listSessions(String userEmail) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        return sessionRepository.findAllByRestaurantIdOrderByCreatedAtDesc(restaurantId)
                .stream().map(this::toResponse).toList();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void setActivePanorama(String userEmail, UUID sessionId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));

        if (session.getStatus() != PanoramaSessionStatus.COMPLETED) {
            throw PanoramaException.invalidState("Pouze dokončená session může být aktivována.");
        }

        var restaurant = restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> RestaurantException.notFound(restaurantId));
        restaurant.setPanoramaUrl(session.getResultUrl());
        restaurant.setUpdatedAt(LocalDateTime.now());
        restaurantRepository.save(restaurant);
    }

    private UUID findOwnerRestaurantId(String userEmail) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                .orElseThrow(RestaurantException::noRestaurantAssigned);
        return membership.getRestaurant().getId();
    }

    private PanoramaSessionResponse toResponse(PanoramaSession session) {
        return PanoramaSessionResponse.builder()
                .id(session.getId())
                .status(session.getStatus().name())
                .photoCount(session.getPhotoCount())
                .resultUrl(session.getResultUrl())
                .createdAt(session.getCreatedAt())
                .completedAt(session.getCompletedAt())
                .errorMessage(session.getErrorMessage())
                .build();
    }
}
