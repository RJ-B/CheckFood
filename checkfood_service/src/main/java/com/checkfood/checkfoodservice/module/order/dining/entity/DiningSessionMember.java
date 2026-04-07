package com.checkfood.checkfoodservice.module.order.dining.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * JPA entita člena skupinového sezení u stolu uchovávající vazbu mezi sezením a uživatelem
 * spolu s časem připojení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Entity
@Table(
        name = "dining_session_member",
        uniqueConstraints = @UniqueConstraint(columnNames = {"session_id", "user_id"}),
        indexes = {
                @Index(name = "idx_dining_session_member_session", columnList = "session_id"),
                @Index(name = "idx_dining_session_member_user", columnList = "user_id")
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiningSessionMember {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "session_id", nullable = false)
    private UUID sessionId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "joined_at", nullable = false)
    private LocalDateTime joinedAt;

    /**
     * Nastaví čas připojení při první perzistenci entity, pokud nebyl explicitně zadán.
     */
    @PrePersist
    protected void onCreate() {
        if (joinedAt == null) {
            joinedAt = LocalDateTime.now();
        }
    }
}
