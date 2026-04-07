package com.checkfood.checkfoodservice.module.order.dto.response;

import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import com.checkfood.checkfoodservice.module.order.entity.PaymentStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Plný response DTO objednávky obsahující všechny položky, stav a informace o platbě.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderResponse {

    private UUID id;
    private UUID restaurantId;
    private UUID tableId;
    private String restaurantName;
    private String tableLabel;
    private OrderStatus status;
    private int totalPriceMinor;
    private String currency;
    private String note;
    private LocalDateTime createdAt;
    private List<OrderItemResponse> items;

    private PaymentStatus paymentStatus;
    private String paymentTransactionId;
    private String paymentRedirectUrl;
}
