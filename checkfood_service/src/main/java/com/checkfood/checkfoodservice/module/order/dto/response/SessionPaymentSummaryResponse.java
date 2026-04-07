package com.checkfood.checkfoodservice.module.order.dto.response;

import com.checkfood.checkfoodservice.module.order.entity.ItemPaymentStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

/**
 * Response DTO se souhrnnou informací o platbách v rámci sezení — celková, zaplacená a zbývající částka
 * spolu s detailem jednotlivých položek.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SessionPaymentSummaryResponse {

    private int totalMinor;
    private int paidMinor;
    private int remainingMinor;
    private List<ItemSummary> items;

    /**
     * Detail jedné položky objednávky v rámci platebního souhrnu sezení.
     */
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ItemSummary {
        private UUID id;
        private String name;
        private int priceMinor;
        private int quantity;
        private String orderedBy;
        private String paidBy;
        private ItemPaymentStatus status;
    }
}
