package com.checkfood.checkfoodservice.module.owner.dto.onboarding;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.OpeningHoursDto;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;

import java.util.List;

/**
 * Požadavek na nastavení otevírací doby restaurace v průběhu onboardingu majitele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OnboardingHoursRequest {
    @NotEmpty(message = "Otevírací hodiny musí obsahovat alespoň jeden den")
    @Valid
    private List<OpeningHoursDto> openingHours;
}
