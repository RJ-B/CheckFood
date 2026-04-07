package com.checkfood.checkfoodservice.module.order.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * JPA entita položky objednávky uchovávající snímek dat menu položky v době objednání a stav platby.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "order_item", indexes = {
        @Index(name = "idx_order_item_order", columnList = "order_id"),
        @Index(name = "idx_order_item_menu_item", columnList = "menu_item_id"),
        @Index(name = "idx_order_item_payment_tx", columnList = "payment_transaction_id")
})
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    @Column(name = "menu_item_id", nullable = false)
    private UUID menuItemId;

    @Column(name = "item_name", nullable = false, length = 150)
    private String itemName;

    @Column(name = "unit_price_minor", nullable = false)
    private int unitPriceMinor;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column(name = "ordered_by_user_id")
    private Long orderedByUserId;

    @Column(name = "paid_by_user_id")
    private Long paidByUserId;

    @Enumerated(EnumType.STRING)
    @Column(name = "item_payment_status", length = 20)
    @Builder.Default
    private ItemPaymentStatus itemPaymentStatus = ItemPaymentStatus.UNPAID;

    @Column(name = "payment_transaction_id", length = 100)
    private String paymentTransactionId;
}
