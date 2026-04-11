package com.checkfood.checkfoodservice.module.order.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Request DTO pro vytvoření nové objednávky zákazníkem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateOrderRequest {

    // Max item count prevents payload-amplification DoS (e.g. attacker
    // posting 10k lines to force a huge DB transaction). 100 items is
    // already well above any realistic single-order count.
    @NotEmpty(message = "Objednávka musí obsahovat alespoň jednu položku")
    @Size(max = 100, message = "Objednávka nesmí obsahovat více než 100 položek")
    @Valid
    private List<OrderItemRequest> items;

    @Size(max = 500, message = "Poznámka může mít maximálně 500 znaků")
    private String note;
}
