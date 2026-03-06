package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationPreferenceResponse {

    private boolean notificationsEnabled;
    private boolean hasFcmToken;
}
