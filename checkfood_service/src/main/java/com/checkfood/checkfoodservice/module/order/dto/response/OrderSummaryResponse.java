package com.checkfood.checkfoodservice.module.order.dto.response;

import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
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
public class OrderSummaryResponse {

    private UUID id;
    private OrderStatus status;
    private int totalPriceMinor;
    private String currency;
    private int itemCount;
    private LocalDateTime createdAt;
}
