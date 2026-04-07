package com.checkfood.checkfoodservice.module.order.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * JPA entita objednávky zákazníka v restauraci, zahrnuje položky, stav objednávky a informace o platbě.
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
@Table(name = "customer_order", indexes = {
        @Index(name = "idx_order_user", columnList = "user_id"),
        @Index(name = "idx_order_restaurant", columnList = "restaurant_id"),
        @Index(name = "idx_order_table", columnList = "table_id"),
        @Index(name = "idx_order_reservation", columnList = "reservation_id"),
        @Index(name = "idx_order_status", columnList = "status"),
        @Index(name = "idx_order_created", columnList = "created_at")
})
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(name = "table_id", nullable = false)
    private UUID tableId;

    @Column(name = "reservation_id")
    private UUID reservationId;

    @Column(name = "session_id")
    private UUID sessionId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    @Builder.Default
    private OrderStatus status = OrderStatus.PENDING;

    @Column(name = "total_price_minor", nullable = false)
    private int totalPriceMinor;

    @Column(name = "currency", nullable = false, length = 3)
    @Builder.Default
    private String currency = "CZK";

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "payment_status", length = 30)
    @Enumerated(EnumType.STRING)
    @Builder.Default
    private PaymentStatus paymentStatus = PaymentStatus.NONE;

    @Column(name = "payment_transaction_id", length = 100)
    private String paymentTransactionId;

    @Column(name = "payment_redirect_url", length = 500)
    private String paymentRedirectUrl;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Builder.Default
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items = new ArrayList<>();

    /**
     * Nastaví čas vytvoření při první perzistenci entity, pokud nebyl explicitně zadán.
     */
    @PrePersist
    protected void onCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }

    /**
     * Přidá položku do objednávky a nastaví zpětnou referenci na tuto objednávku.
     *
     * @param item položka objednávky, která má být přidána
     */
    public void addItem(OrderItem item) {
        items.add(item);
        item.setOrder(this);
    }
}
