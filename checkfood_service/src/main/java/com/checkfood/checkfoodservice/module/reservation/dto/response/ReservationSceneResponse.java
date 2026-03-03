package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.util.List;
import java.util.UUID;

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
