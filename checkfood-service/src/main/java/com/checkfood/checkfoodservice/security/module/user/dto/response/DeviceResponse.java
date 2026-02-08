package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

import java.time.LocalDateTime;

/**
 * DTO pro informace o registrovaném zařízení uživatele.
 * Používá se pro zobrazení aktivních relací v profilu uživatele.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DeviceResponse {

    private Long id;

    /**
     * Čitelný název zařízení (např. "iPhone 15 Pro", "Chrome na Windows").
     */
    private String deviceName;

    /**
     * Typ zařízení (např. "IOS", "ANDROID", "WEB").
     */
    private String deviceType;

    /**
     * Čas poslední aktivity zařízení.
     */
    private LocalDateTime lastLogin;
}