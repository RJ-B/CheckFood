package com.checkfood.checkfoodservice.module.reservation.dto.response;

import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReservationResponse {
    private UUID id;
    private UUID restaurantId;
    private UUID tableId;
    private String restaurantName;
    private String tableLabel;
    private LocalDate date;
    private LocalTime startTime;
    private LocalTime endTime;
    private ReservationStatus status;
    private int partySize;
    private boolean canEdit;
    private boolean canCancel;
}
