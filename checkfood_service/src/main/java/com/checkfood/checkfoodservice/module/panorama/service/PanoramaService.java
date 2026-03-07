package com.checkfood.checkfoodservice.module.panorama.service;

import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaPhotoResponse;
import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaSessionResponse;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

public interface PanoramaService {
    PanoramaSessionResponse createSession(String userEmail);
    PanoramaPhotoResponse uploadPhoto(String userEmail, UUID sessionId, int angleIndex, double actualAngle, Double actualPitch, MultipartFile file);
    PanoramaSessionResponse finalizeSession(String userEmail, UUID sessionId);
    PanoramaSessionResponse getSessionStatus(String userEmail, UUID sessionId);
    List<PanoramaSessionResponse> listSessions(String userEmail);
    void setActivePanorama(String userEmail, UUID sessionId);
    void handleStitchingCallback(com.checkfood.checkfoodservice.module.panorama.client.StitchCallbackRequest request);
}
