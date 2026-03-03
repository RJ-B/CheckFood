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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

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

    @Override
    public PanoramaSessionResponse createSession(String userEmail) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = PanoramaSession.builder()
                .restaurantId(restaurantId)
                .build();
        var saved = sessionRepository.save(session);
        return toResponse(saved);
    }

    @Override
    public PanoramaPhotoResponse uploadPhoto(String userEmail, UUID sessionId, int angleIndex, double actualAngle, MultipartFile file) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));

        if (session.getStatus() != PanoramaSessionStatus.UPLOADING) {
            throw PanoramaException.invalidState("Session není ve stavu UPLOADING.");
        }

        double[] targetAngles = {0, 45, 90, 135, 180, 225, 270, 315};
        double targetAngle = (angleIndex >= 0 && angleIndex < targetAngles.length)
                ? targetAngles[angleIndex] : 0;

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
                    .photoUrl(savedPhoto.getPhotoUrl())
                    .build();
        } catch (IOException e) {
            throw PanoramaException.systemError("Chyba při ukládání fotografie: " + e.getMessage());
        }
    }

    @Override
    public PanoramaSessionResponse finalizeSession(String userEmail, UUID sessionId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));

        if (session.getStatus() != PanoramaSessionStatus.UPLOADING) {
            throw PanoramaException.invalidState("Session není ve stavu UPLOADING.");
        }

        int photoCount = photoRepository.countBySessionId(sessionId);
        if (photoCount < 8) {
            throw PanoramaException.invalidState("Session vyžaduje 8 fotografií, nahráno: " + photoCount);
        }

        // Mock stitcher: pick first photo as result
        var photos = photoRepository.findAllBySessionIdOrderByAngleIndexAsc(sessionId);
        String resultUrl = photos.isEmpty() ? null : photos.get(0).getPhotoUrl();

        session.setStatus(PanoramaSessionStatus.COMPLETED);
        session.setResultUrl(resultUrl);
        session.setCompletedAt(LocalDateTime.now());
        var saved = sessionRepository.save(session);

        return toResponse(saved);
    }

    @Override
    @Transactional(readOnly = true)
    public PanoramaSessionResponse getSessionStatus(String userEmail, UUID sessionId) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        var session = sessionRepository.findByIdAndRestaurantId(sessionId, restaurantId)
                .orElseThrow(() -> PanoramaException.sessionNotFound(sessionId));
        return toResponse(session);
    }

    @Override
    @Transactional(readOnly = true)
    public List<PanoramaSessionResponse> listSessions(String userEmail) {
        UUID restaurantId = findOwnerRestaurantId(userEmail);
        return sessionRepository.findAllByRestaurantIdOrderByCreatedAtDesc(restaurantId)
                .stream().map(this::toResponse).toList();
    }

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

    // --- Private Helpers ---

    private UUID findOwnerRestaurantId(String userEmail) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
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
                .build();
    }
}
