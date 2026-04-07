package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.util.List;
import java.util.UUID;

/**
 * Response DTO s daty panoramatické scény restaurace pro rezervační UI.
 * Obsahuje URL panoramatu a seznam stolů s jejich prostorovými souřadnicemi (yaw/pitch).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReservationSceneResponse {
    private UUID restaurantId;
    private String panoramaUrl;
    private List<SceneTable> tables;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SceneTable {
        private UUID tableId;
        private String label;
        private Double yaw;
        private Double pitch;
        private int capacity;
    }
}
