package com.checkfood.checkfoodservice.module.order.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Response DTO obsahující detail jedné položky objednávky včetně ceny a množství.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemResponse {

    private UUID id;
    private UUID menuItemId;
    private String itemName;
    private int unitPriceMinor;
    private int quantity;
    private int totalPriceMinor;
}
