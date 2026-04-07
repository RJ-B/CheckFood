package com.checkfood.checkfoodservice.module.reservation.dto.response;

import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

/**
 * Response DTO s detaily rezervace pro zákazníka.
 * Obsahuje příznaky {@code canEdit} a {@code canCancel} pro řízení UI akcí,
 * a volitelně detail nevyřízeného návrhu změny od personálu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
    private PendingChangeDetail pendingChange;
    private UUID recurringReservationId;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class PendingChangeDetail {
        private UUID changeRequestId;
        private LocalTime proposedStartTime;
        private UUID proposedTableId;
        private String proposedTableLabel;
    }
}
