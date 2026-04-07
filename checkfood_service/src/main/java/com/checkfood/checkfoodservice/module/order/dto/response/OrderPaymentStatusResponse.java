package com.checkfood.checkfoodservice.module.order.dto.response;

import com.checkfood.checkfoodservice.module.order.entity.PaymentStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Response DTO pro polling stavu platby objednávky frontendem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderPaymentStatusResponse {

    private UUID orderId;
    private PaymentStatus paymentStatus;
    private String paymentTransactionId;
}
