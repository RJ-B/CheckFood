package com.checkfood.checkfoodservice.module.reservation.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;
import java.time.LocalTime;

/**
 * Request DTO pro prodloužení délky aktivní rezervace personálem restaurace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExtendReservationRequest {
    @NotNull
    private LocalTime endTime;
}
