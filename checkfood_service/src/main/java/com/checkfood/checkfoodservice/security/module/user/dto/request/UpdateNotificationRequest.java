package com.checkfood.checkfoodservice.security.module.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

/**
 * DTO pro aktualizaci preference push notifikací a FCM tokenu pro konkrétní zařízení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateNotificationRequest {

    @NotBlank(message = "Device identifier je povinny.")
    private String deviceIdentifier;

    /**
     * FCM token. Povinny pri zapnuti notifikaci, null pri vypnuti.
     */
    private String fcmToken;

    @NotNull(message = "Preference notifikaci je povinna.")
    private Boolean notificationsEnabled;
}
