package com.checkfood.checkfoodservice.module.panorama.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Odpověď obsahující detail panoramatické session včetně stavu zpracování a URL výsledku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
