package com.checkfood.checkfoodservice.module.reservation.dto.request;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

/**
 * Request DTO pro vytvoření nové rezervace stolu zákazníkem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateReservationRequest {

    @NotNull(message = "ID restaurace je povinné")
    private UUID restaurantId;

    @NotNull(message = "ID stolu je povinné")
    private UUID tableId;

    @NotNull(message = "Datum je povinné")
    @FutureOrPresent(message = "Datum nesmí být v minulosti")
    private LocalDate date;

    @NotNull(message = "Čas začátku je povinný")
    private LocalTime startTime;

    @Min(value = 1, message = "Počet osob musí být alespoň 1")
    @Builder.Default
    private int partySize = 2;
}
