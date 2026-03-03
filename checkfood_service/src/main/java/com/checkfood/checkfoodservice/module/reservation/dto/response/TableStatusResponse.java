package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TableStatusResponse {
    private LocalDate date;
    private List<TableStatus> tables;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TableStatus {
        private UUID tableId;
        private String status; // FREE, RESERVED, OCCUPIED
    }
}
