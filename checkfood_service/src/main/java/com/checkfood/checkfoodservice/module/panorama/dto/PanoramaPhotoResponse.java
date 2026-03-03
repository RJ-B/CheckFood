package com.checkfood.checkfoodservice.module.panorama.dto;

import lombok.*;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PanoramaPhotoResponse {
    private UUID id;
    private int angleIndex;
    private double targetAngle;
    private double actualAngle;
    private String photoUrl;
}
