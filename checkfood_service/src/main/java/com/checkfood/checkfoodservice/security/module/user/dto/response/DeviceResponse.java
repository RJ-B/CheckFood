package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;
import java.time.LocalDateTime;

/**
 * DTO reprezentující klientské zařízení pro přehled aktivních relací uživatele.
 * Obsahuje příznak {@code currentDevice} označující zařízení aktuální session.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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

    private boolean active;
}