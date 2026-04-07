package com.checkfood.checkfoodservice.module.reservation.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

/**
 * JPA entita reprezentující jednu konkrétní rezervaci stolu v restauraci.
 * Rezervace může být samostatná nebo navázána na opakovanou rezervaci přes {@code recurringReservationId}.
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
        name = "reservation",
        indexes = {
                @Index(name = "idx_reservation_table_date", columnList = "table_id, reservation_date"),
                @Index(name = "idx_reservation_user", columnList = "user_id"),
                @Index(name = "idx_reservation_restaurant", columnList = "restaurant_id"),
                @Index(name = "idx_reservation_recurring", columnList = "recurring_reservation_id")
        }
)
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(name = "table_id", nullable = false)
    private UUID tableId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "reservation_date", nullable = false)
    private LocalDate date;

    @Column(name = "start_time", nullable = false)
    private LocalTime startTime;

    @Column(name = "end_time", nullable = true)
    private LocalTime endTime;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 30)
    @Builder.Default
    private ReservationStatus status = ReservationStatus.PENDING_CONFIRMATION;

    @Column(name = "party_size", nullable = false)
    @Builder.Default
    private int partySize = 2;

    @Column(name = "recurring_reservation_id")
    private UUID recurringReservationId;

    @Builder.Default
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}
