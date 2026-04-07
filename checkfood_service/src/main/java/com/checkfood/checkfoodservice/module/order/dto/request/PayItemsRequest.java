package com.checkfood.checkfoodservice.module.order.dto.request;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

/**
 * Request DTO pro zahájení platby konkrétních položek objednávky v rámci sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayItemsRequest {

    @NotEmpty(message = "Seznam položek nesmí být prázdný.")
    private List<UUID> itemIds;
}
