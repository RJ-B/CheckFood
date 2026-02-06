package com.checkfood.checkfoodservice.application.dto.request.restaurant;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

/**
 * DTO pro aktualizaci stolu restaurace.
 *
 * Používá se výhradně v rámci
 * aktualizace restaurace.
 *
 * Neexistuje samostatný endpoint
 * pro úpravu stolu.
 */
public record RestaurantTableUpdateRequestDto(

        UUID id,

        @NotBlank
        String label,

        @Min(1)
        int capacity,

        @NotNull
        Boolean active

) {
}
