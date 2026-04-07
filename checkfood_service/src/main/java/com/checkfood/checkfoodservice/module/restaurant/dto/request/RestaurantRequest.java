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
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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

    @Min(value = 15, message = "Minimální délka rezervace je 15 minut")
    @Max(value = 480, message = "Maximální délka rezervace je 8 hodin")
    private Integer defaultReservationDurationMinutes;

    @Min(value = 0, message = "Minimální předstih nemůže být záporný")
    @Max(value = 1440, message = "Minimální předstih nesmí přesáhnout 24 hodin")
    private Integer minAdvanceMinutes;

    @Min(value = 15, message = "Minimální délka rezervace je 15 minut")
    @Max(value = 480, message = "Maximální délka rezervace je 8 hodin")
    private Integer minReservationDurationMinutes;

    @Min(value = 15, message = "Maximální délka rezervace je alespoň 15 minut")
    @Max(value = 480, message = "Maximální délka rezervace nesmí přesáhnout 8 hodin")
    private Integer maxReservationDurationMinutes;

    @Min(value = 5, message = "Interval slotů je alespoň 5 minut")
    @Max(value = 120, message = "Interval slotů nesmí přesáhnout 120 minut")
    private Integer reservationSlotIntervalMinutes;
}