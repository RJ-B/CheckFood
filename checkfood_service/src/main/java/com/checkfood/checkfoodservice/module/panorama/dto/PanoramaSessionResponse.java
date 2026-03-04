package com.checkfood.checkfoodservice.module.panorama.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PanoramaSessionResponse {
    private UUID id;
    private String status;
    private int photoCount;
    private String resultUrl;
    private LocalDateTime createdAt;
    private LocalDateTime completedAt;
    private String errorMessage;
}
