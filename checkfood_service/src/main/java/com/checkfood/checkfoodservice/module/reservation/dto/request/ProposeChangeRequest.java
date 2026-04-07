package com.checkfood.checkfoodservice.module.reservation.dto.request;

import lombok.*;
import java.time.LocalTime;
import java.util.UUID;

/**
 * Request DTO pro návrh změny rezervace iniciovaný personálem restaurace.
 * Alespoň jedno pole ({@code startTime} nebo {@code tableId}) musí být vyplněno.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProposeChangeRequest {
    private LocalTime startTime;
    private UUID tableId;
}
