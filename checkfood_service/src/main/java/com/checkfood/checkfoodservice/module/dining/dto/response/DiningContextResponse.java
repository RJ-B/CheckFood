package com.checkfood.checkfoodservice.module.dining.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiningContextResponse {

    private UUID restaurantId;
    private UUID tableId;
    private UUID reservationId;
    private UUID sessionId;
    private String contextType;
    private String restaurantName;
    private String tableLabel;
    private LocalDateTime validFrom;
    private LocalDateTime validTo;
}
