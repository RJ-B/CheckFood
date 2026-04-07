package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Response DTO se stavem obsazenosti všech stolů restaurace pro daný den.
 * Stav každého stolu je jeden z hodnot: {@code FREE}, {@code RESERVED}, {@code OCCUPIED}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TableStatusResponse {
    private LocalDate date;
    private List<TableStatus> tables;

    /**
     * Stav obsazenosti jednoho stolu.
     */
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TableStatus {
        private UUID tableId;
        private String status;
    }
}
