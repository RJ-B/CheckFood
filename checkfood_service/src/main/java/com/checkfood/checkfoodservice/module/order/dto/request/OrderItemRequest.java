package com.checkfood.checkfoodservice.module.order.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Request DTO reprezentující jednu položku v objednávce — menu položku a požadované množství.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemRequest {

    @NotNull(message = "ID položky menu je povinné")
    private UUID menuItemId;

    @Min(value = 1, message = "Množství musí být alespoň 1")
    @Max(value = 99, message = "Množství nesmí překročit 99")
    private int quantity;
}
