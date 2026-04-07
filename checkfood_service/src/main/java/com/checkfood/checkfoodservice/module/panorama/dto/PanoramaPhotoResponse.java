package com.checkfood.checkfoodservice.module.panorama.dto;

import lombok.*;

import java.util.UUID;

/**
 * Odpověď obsahující detail nahrané fotografie panoramatické session včetně úhlů snímání.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PanoramaPhotoResponse {
    private UUID id;
    private int angleIndex;
    private double targetAngle;
    private double actualAngle;
    private Double targetPitch;
    private Double actualPitch;
    private String photoUrl;
}
