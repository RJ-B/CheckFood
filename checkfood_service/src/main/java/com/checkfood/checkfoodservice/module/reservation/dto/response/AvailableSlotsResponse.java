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
    /** Interval mezi sloty (minuty) — obvykle shodný s {@code reservationSlotIntervalMinutes} restaurace. */
    private int slotMinutes;
    /** Výchozí délka rezervace (minuty) — pro zpětnou kompatibilitu. */
    private int durationMinutes;
    /** Minimální délka rezervace v minutách (zákazník si může vybrat v rozmezí min–max). */
    private int minDurationMinutes;
    /** Maximální délka rezervace v minutách. */
    private int maxDurationMinutes;
    /** Krok výběru délky rezervace v minutách (zákazník vybírá po tomto intervalu). */
    private int durationStepMinutes;
    private List<LocalTime> availableStartTimes;
}
