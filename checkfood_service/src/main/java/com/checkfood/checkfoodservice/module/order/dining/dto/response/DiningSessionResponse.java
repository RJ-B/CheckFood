package com.checkfood.checkfoodservice.module.order.dining.dto.response;

import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Response DTO skupinového sezení u stolu zahrnující detail sezení a seznam jeho členů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiningSessionResponse {

    private UUID id;
    private UUID restaurantId;
    private UUID tableId;
    private UUID reservationId;
    private String inviteCode;
    private DiningSessionStatus status;
    private List<DiningSessionMemberResponse> members;
    private LocalDateTime createdAt;
    private Long createdByUserId;
}
