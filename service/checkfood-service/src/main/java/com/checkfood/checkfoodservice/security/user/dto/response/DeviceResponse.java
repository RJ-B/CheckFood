package com.checkfood.checkfoodservice.security.user.dto.response;

import lombok.Builder;
import java.time.LocalDateTime;

@Builder
public record DeviceResponse(
        Long id,
        String deviceName,
        String deviceType,
        LocalDateTime lastLogin
) {}