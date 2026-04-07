package com.checkfood.checkfoodservice.module.reservation.dto.response;

import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservationStatus;
import lombok.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

/**
 * Response DTO s detaily opakované rezervace včetně počtu vygenerovaných instancí.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RecurringReservationResponse {
    private UUID id;
    private UUID restaurantId;
    private UUID tableId;
    private String restaurantName;
    private String tableLabel;
    private DayOfWeek dayOfWeek;
    private LocalTime startTime;
    private int partySize;
    private RecurringReservationStatus status;
    private LocalDate repeatUntil;
    private LocalDateTime createdAt;
    private int instanceCount;
}
