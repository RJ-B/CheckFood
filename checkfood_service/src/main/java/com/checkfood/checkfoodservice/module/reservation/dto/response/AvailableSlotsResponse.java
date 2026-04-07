package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

/**
 * Response DTO se seznamem dostupných časových slotů pro rezervaci stolu v daný den.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AvailableSlotsResponse {
    private LocalDate date;
    private UUID tableId;
    private int slotMinutes;
    private int durationMinutes;
    private List<LocalTime> availableStartTimes;
}
