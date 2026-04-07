package com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.AddressDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * Požadavek na aktualizaci základních informací o restauraci v průběhu onboardingu majitele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OnboardingInfoRequest {
    @NotBlank(message = "Název restaurace je povinný")
    @Size(max = 150)
    private String name;

    @Size(max = 1000)
    private String description;

    @Size(max = 20)
    private String phone;

    @Email
    @Size(max = 254)
    private String email;

    @Valid
    private AddressDto address;

    private CuisineType cuisineType;
}
