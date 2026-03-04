package com.checkfood.checkfoodservice.module.panorama.controller;

import com.checkfood.checkfoodservice.module.panorama.client.StitchCallbackRequest;
import com.checkfood.checkfoodservice.module.panorama.service.PanoramaService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/v1/internal/panorama")
@RequiredArgsConstructor
public class PanoramaCallbackController {

    private final PanoramaService panoramaService;

    @PostMapping("/callback")
    public ResponseEntity<Void> handleStitchingCallback(@RequestBody StitchCallbackRequest request) {
        log.info("[PanoramaCallback] Received: session={}, status={}", request.getSessionId(), request.getStatus());
        panoramaService.handleStitchingCallback(request);
        return ResponseEntity.ok().build();
    }
}
