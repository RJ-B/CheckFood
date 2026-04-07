package com.checkfood.checkfoodservice.module.reservation.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.UUID;

/**
 * Request DTO pro vytvoření nové opakované rezervace zákazníkem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateRecurringReservationRequest {

    @NotNull
    private UUID restaurantId;

    @NotNull
    private UUID tableId;

    @NotNull
    private DayOfWeek dayOfWeek;

    @NotNull
    private LocalTime startTime;

    @Min(1)
    @Builder.Default
    private int partySize = 2;
}
