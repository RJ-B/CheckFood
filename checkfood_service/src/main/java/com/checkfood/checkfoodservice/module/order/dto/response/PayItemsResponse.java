package com.checkfood.checkfoodservice.module.order.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Response DTO vrácený po zahájení platby vybraných položek — obsahuje přesměrovací URL a ID transakce.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PayItemsResponse {

    private String redirectUrl;
    private String transactionId;
    private int totalMinor;
}
