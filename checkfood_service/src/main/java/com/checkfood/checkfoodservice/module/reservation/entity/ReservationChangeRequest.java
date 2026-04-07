package com.checkfood.checkfoodservice.module.reservation.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

/**
 * JPA entita reprezentující návrh změny existující rezervace iniciovaný personálem restaurace.
 * Zákazník může návrh přijmout nebo odmítnout; přijetí aktualizuje původní rezervaci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
    name = "reservation_change_request",
    indexes = {
        @Index(name = "idx_change_request_reservation", columnList = "reservation_id"),
        @Index(name = "idx_change_request_status", columnList = "status")
    }
)
public class ReservationChangeRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "reservation_id", nullable = false)
    private UUID reservationId;

    @Column(name = "requested_by_user_id", nullable = false)
    private Long requestedByUserId;

    @Column(name = "proposed_start_time")
    private LocalTime proposedStartTime;

    @Column(name = "proposed_table_id")
    private UUID proposedTableId;

    @Column(name = "original_start_time", nullable = false)
    private LocalTime originalStartTime;

    @Column(name = "original_table_id", nullable = false)
    private UUID originalTableId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    @Builder.Default
    private ChangeRequestStatus status = ChangeRequestStatus.PENDING;

    @Builder.Default
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "resolved_at")
    private LocalDateTime resolvedAt;
}
