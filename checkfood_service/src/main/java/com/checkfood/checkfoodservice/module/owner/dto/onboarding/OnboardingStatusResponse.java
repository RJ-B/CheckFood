package com.checkfood.checkfoodservice.module.owner.dto.onboarding;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OnboardingStatusResponse {
    private boolean onboardingCompleted;
    private boolean hasInfo;
    private boolean hasHours;
    private boolean hasTables;
    private boolean hasMenu;
    private boolean hasPanorama;
}
