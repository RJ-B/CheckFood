package com.checkfood.checkfoodservice.module.panorama.client;

import java.util.List;
import java.util.UUID;

public interface StitcherClient {
    void requestStitching(UUID sessionId, List<String> photoPaths, String callbackUrl);
}
