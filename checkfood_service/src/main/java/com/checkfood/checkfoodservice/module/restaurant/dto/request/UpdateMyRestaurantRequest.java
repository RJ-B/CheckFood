package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.AddressDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.common.OpeningHoursDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.common.SpecialDayDto;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.*;

import java.util.List;

/**
 * Požadavek na aktualizaci základních informací o restauraci, otevírací doby a výjimečných dní.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateMyRestaurantRequest {

    @NotBlank(message = "Název restaurace je povinný")
    @Size(max = 150)
    private String name;

    @Size(max = 1000)
    private String description;

    @Valid
    private AddressDto address;

    @Size(max = 20)
    private String phone;

    @Email(message = "Neplatný formát emailu")
    private String email;

    @Valid
    private List<OpeningHoursDto> openingHours;

    @Min(value = 15, message = "Minimální délka rezervace je 15 minut")
    @Max(value = 480, message = "Maximální délka rezervace je 8 hodin")
    private Integer defaultReservationDurationMinutes;

    @Valid
    private List<SpecialDayDto> specialDays;
}
