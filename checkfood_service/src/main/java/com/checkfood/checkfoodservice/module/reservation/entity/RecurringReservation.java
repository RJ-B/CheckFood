package com.checkfood.checkfoodservice.module.reservation.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.UUID;

/**
 * JPA entita reprezentující opakovanou rezervaci stolu v daný den v týdnu.
 * Po potvrzení personálem se automaticky generují jednotlivé instance {@link Reservation}
 * až do data {@code repeatUntil}.
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
        name = "recurring_reservation",
        indexes = {
                @Index(name = "idx_recurring_user", columnList = "user_id"),
                @Index(name = "idx_recurring_restaurant", columnList = "restaurant_id")
        }
)
public class RecurringReservation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(name = "table_id", nullable = false)
    private UUID tableId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Enumerated(EnumType.STRING)
    @Column(name = "day_of_week", nullable = false, length = 15)
    private DayOfWeek dayOfWeek;

    @Column(name = "start_time", nullable = false)
    private LocalTime startTime;

    @Column(name = "party_size", nullable = false)
    @Builder.Default
    private int partySize = 2;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 30)
    @Builder.Default
    private RecurringReservationStatus status = RecurringReservationStatus.PENDING_CONFIRMATION;

    @Column(name = "repeat_until")
    private LocalDate repeatUntil;

    @Builder.Default
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}
