package com.checkfood.checkfoodservice.module.reservation.dto.request;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;

/**
 * Request DTO pro potvrzení opakované rezervace personálem.
 * Obsahuje datum, do kterého budou generovány jednotlivé instance rezervace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ConfirmRecurringReservationRequest {

    @NotNull
    @FutureOrPresent
    private LocalDate repeatUntil;
}
