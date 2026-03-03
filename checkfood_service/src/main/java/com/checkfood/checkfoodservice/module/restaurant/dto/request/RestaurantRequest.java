package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.AddressDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.common.OpeningHoursDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.*;

import java.util.List;
import java.util.Set;

/**
 * Požadavek na vytvoření nebo aktualizaci restaurace.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantRequest {

    @NotBlank(message = "Název restaurace je povinný")
    @Size(max = 150)
    private String name;

    @Size(max = 1000)
    private String description;

    @NotNull(message = "Typ kuchyně musí být vybrán")
    private CuisineType cuisineType;

    private String logoUrl;
    private String coverImageUrl;
    private String panoramaUrl;

    @NotNull(message = "Adresa je povinná")
    @Valid
    private AddressDto address;

    @Valid
    private List<OpeningHoursDto> openingHours;

    private Set<String> tags;
}