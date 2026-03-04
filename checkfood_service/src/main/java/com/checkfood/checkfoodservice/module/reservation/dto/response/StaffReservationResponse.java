package com.checkfood.checkfoodservice.module.reservation.dto.response;

import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StaffReservationResponse {
    private UUID id;
    private UUID tableId;
    private String tableLabel;
    private Long userId;
    private LocalDate date;
    private LocalTime startTime;
    private LocalTime endTime;
    private int partySize;
    private ReservationStatus status;
    private LocalDateTime createdAt;
    private boolean canConfirm;
    private boolean canReject;
    private boolean canCheckIn;
    private boolean canComplete;
}
