package com.checkfood.checkfoodservice.module.order.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateOrderRequest {

    @NotEmpty(message = "Objednávka musí obsahovat alespoň jednu položku")
    @Valid
    private List<OrderItemRequest> items;

    @Size(max = 500, message = "Poznámka může mít maximálně 500 znaků")
    private String note;
}
