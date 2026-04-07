package com.checkfood.checkfoodservice.module.order.dining.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO popisující aktivní kontext stravování uživatele — restauraci, stůl, rezervaci a sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
