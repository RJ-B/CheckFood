package com.checkfood.checkfoodservice.module.order.dining.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * JPA entita skupinového sezení u stolu s unikátním pozvákovým kódem umožňujícím ostatním se připojit.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Entity
@Table(name = "dining_session", indexes = {
        @Index(name = "idx_dining_session_invite_code", columnList = "invite_code"),
        @Index(name = "idx_dining_session_status", columnList = "status"),
        @Index(name = "idx_dining_session_reservation", columnList = "reservation_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiningSession {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(name = "table_id", nullable = false)
    private UUID tableId;

    @Column(name = "reservation_id")
    private UUID reservationId;

    @Column(name = "invite_code", nullable = false, unique = true, length = 8)
    private String inviteCode;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    @Builder.Default
    private DiningSessionStatus status = DiningSessionStatus.ACTIVE;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "created_by_user_id", nullable = false)
    private Long createdByUserId;

    /**
     * Nastaví čas vytvoření při první perzistenci entity, pokud nebyl explicitně zadán.
     */
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}
