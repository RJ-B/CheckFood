package com.checkfood.checkfoodservice.module.reservation.dto.response;

import com.checkfood.checkfoodservice.module.reservation.entity.ChangeRequestStatus;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

/**
 * Response DTO s detaily návrhu změny rezervace čekajícího na rozhodnutí zákazníka.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PendingChangeResponse {
    private UUID id;
    private UUID reservationId;
    private String restaurantName;
    private LocalTime proposedStartTime;
    private UUID proposedTableId;
    private String proposedTableLabel;
    private LocalTime originalStartTime;
    private UUID originalTableId;
    private String originalTableLabel;
    private LocalDate reservationDate;
    private ChangeRequestStatus status;
    private LocalDateTime createdAt;
}
