package com.checkfood.checkfoodservice.module.order.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

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
