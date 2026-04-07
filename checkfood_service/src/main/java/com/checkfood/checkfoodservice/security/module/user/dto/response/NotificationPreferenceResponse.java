package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

/**
 * DTO pro vrácení aktuálního stavu preference push notifikací zařízení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationPreferenceResponse {

    private boolean notificationsEnabled;
    private boolean hasFcmToken;
}
