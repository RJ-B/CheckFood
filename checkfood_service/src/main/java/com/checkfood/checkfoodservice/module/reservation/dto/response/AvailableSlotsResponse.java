package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AvailableSlotsResponse {
    private LocalDate date;
    private UUID tableId;
    private int slotMinutes;
    private List<LocalTime> availableStartTimes;
}
