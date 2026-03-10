package com.checkfood.checkfoodservice.module.panorama.client;

import com.checkfood.checkfoodservice.module.panorama.config.PanoramaProperties;
import com.checkfood.checkfoodservice.module.panorama.exception.PanoramaException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
public class StitcherClientImpl implements StitcherClient {

    private final PanoramaProperties properties;
    private final RestTemplate stitcherRestTemplate;

    @Override
    @Async
    public void requestStitching(UUID sessionId, List<String> photoPaths, String callbackUrl) {
        String url = properties.getUrl() + "/stitch";
        log.info("[Stitcher] Requesting stitch: session={}, photos={}", sessionId, photoPaths.size());

        try {
            var body = Map.of(
                    "session_id", sessionId.toString(),
                    "photo_urls", photoPaths,
                    "callback_url", callbackUrl
            );
            stitcherRestTemplate.postForEntity(url, body, Map.class);
            log.info("[Stitcher] Request accepted: session={}", sessionId);
        } catch (Exception e) {
            log.error("[Stitcher] Request failed: session={}, error={}", sessionId, e.getMessage());
            throw PanoramaException.stitcherUnavailable(e.getMessage());
        }
    }
}
