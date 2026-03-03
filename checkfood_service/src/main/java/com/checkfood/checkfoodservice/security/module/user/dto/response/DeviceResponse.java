package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DeviceResponse {

    private Long id;

    private String deviceName;

    private String deviceType;

    private String deviceIdentifier;

    private LocalDateTime lastLogin;

    private boolean currentDevice;
}