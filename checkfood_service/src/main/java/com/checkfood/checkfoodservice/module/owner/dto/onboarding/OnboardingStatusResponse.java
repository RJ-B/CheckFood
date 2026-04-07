package com.checkfood.checkfoodservice.module.owner.dto.onboarding;

import lombok.*;

/**
 * Odpověď obsahující stav onboardingu restaurace — přehled splnění jednotlivých kroků.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
