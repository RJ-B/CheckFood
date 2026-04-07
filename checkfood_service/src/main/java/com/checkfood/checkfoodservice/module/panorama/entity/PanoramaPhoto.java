package com.checkfood.checkfoodservice.module.panorama.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * JPA entita reprezentující jednu fotografii nahranou v rámci panoramatické session.
 * Uchovává informace o úhlu snímání a URL uložené fotografie.
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
@Table(name = "panorama_photo", indexes = {
        @Index(name = "idx_panorama_photo_session", columnList = "session_id")
})
public class PanoramaPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "session_id", nullable = false)
    private UUID sessionId;

    @Column(name = "angle_index", nullable = false)
    private int angleIndex;

    @Column(name = "target_angle", nullable = false)
    private double targetAngle;

    @Column(name = "actual_angle", nullable = false)
    private double actualAngle;

    @Column(name = "target_pitch")
    private Double targetPitch;

    @Column(name = "actual_pitch")
    private Double actualPitch;

    @Column(name = "photo_url", nullable = false)
    private String photoUrl;

    @Builder.Default
    @Column(name = "uploaded_at", nullable = false)
    private LocalDateTime uploadedAt = LocalDateTime.now();
}
