package com.checkfood.checkfoodservice.module.panorama.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * JPA entita reprezentující session panoramatického snímkování restaurace.
 * Uchovává stav zpracování, počet nahraných fotografií a URL výsledného panoramatu.
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
@Table(name = "panorama_session", indexes = {
        @Index(name = "idx_panorama_session_restaurant", columnList = "restaurant_id")
})
public class PanoramaSession {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    @Builder.Default
    private PanoramaSessionStatus status = PanoramaSessionStatus.UPLOADING;

    @Column(name = "photo_count", nullable = false)
    @Builder.Default
    private int photoCount = 0;

    @Column(name = "result_url")
    private String resultUrl;

    @Builder.Default
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "completed_at")
    private LocalDateTime completedAt;

    @Column(name = "error_message", length = 500)
    private String errorMessage;
}
