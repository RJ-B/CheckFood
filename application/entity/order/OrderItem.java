package com.checkfood.checkfoodservice.application.entity.order;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * Doménová entita reprezentující položku objednávky.
 *
 * OrderItem je součástí agregátu Order a představuje
 * snapshot položky menu v čase vytvoření objednávky.
 *
 * Nejedná se o referenci na MenuItem – data jsou
 * uložena denormalizovaně, aby byla objednávka
 * historicky neměnná.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "order_item",
        indexes = {
                @Index(name = "idx_order_item_order_id", columnList = "order_id")
        }
)
public class OrderItem {

    /**
     * Primární identifikátor položky objednávky.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Objednávka, ke které položka patří.
     *
     * Tato vazba je interní součástí agregátu Order.
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "order_id", nullable = false, updatable = false)
    private Order order;

    /**
     * Identifikátor položky menu (pouze pro dohledání / audit).
     *
     * Slouží výhradně jako referenční informace,
     * nikoliv pro načítání aktuálních dat menu.
     */
    @Column(name = "menu_item_id")
    private UUID menuItemId;

    /**
     * Název položky v čase objednání.
     */
    @Column(nullable = false, length = 200)
    private String name;

    /**
     * Cena jedné položky v čase objednání.
     *
     * Uložena v nejmenší měnové jednotce
     * (např. haléře).
     */
    @Column(nullable = false)
    private long unitPrice;

    /**
     * Počet kusů položky.
     */
    @Column(nullable = false)
    private int quantity;

    /**
     * Celková cena této položky (unitPrice * quantity).
     *
     * Denormalizováno kvůli výkonu a jednoduchému čtení.
     */
    @Column(nullable = false)
    private long totalPrice;

    /* =========================================================
       POZNÁMKY K NÁVRHU
       ---------------------------------------------------------
       - name a price jsou snapshoty
       - změna menu nemá vliv na existující objednávky
       - menuItemId je volitelné (pro audit / statistiky)
       ========================================================= */
}
