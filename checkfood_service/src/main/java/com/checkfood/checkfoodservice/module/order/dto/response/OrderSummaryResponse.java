package com.checkfood.checkfoodservice.module.order.dto.response;

import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Zkrácený response DTO objednávky pro seznam aktivních objednávek zákazníka.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
