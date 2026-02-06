package com.checkfood.checkfoodservice.application.entity.order;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Doménová entita reprezentující objednávku.
 *
 * Order je samostatný agregátový kořen.
 * Reprezentuje objednávku vytvořenou v konkrétní restauraci
 * a konkrétním kontextu (QR u stolu, obsluha, takeaway).
 *
 * Vazby na ostatní domény (restaurant, table, user,
 * reservation, payment) jsou realizovány nepřímo
 * pomocí identifikátorů (UUID), nikoliv JPA vztahů.
 *
 * Entita neobsahuje žádnou provozní logiku.
 * Stavové přechody a validace jsou řízeny servisní vrstvou.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "orders",
        indexes = {
                @Index(name = "idx_order_restaurant_id", columnList = "restaurant_id"),
                @Index(name = "idx_order_user_id", columnList = "user_id"),
                @Index(name = "idx_order_table_group_id", columnList = "table_group_id"),
                @Index(name = "idx_order_status", columnList = "status"),
                @Index(name = "idx_order_type", columnList = "order_type"),
                @Index(name = "idx_order_created_at", columnList = "created_at")
        }
)
public class Order {

    /**
     * Primární identifikátor objednávky.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Identifikátor restaurace, ve které byla objednávka vytvořena.
     */
    @Column(name = "restaurant_id", nullable = false, updatable = false)
    private UUID restaurantId;

    /**
     * Identifikátor uživatele, který objednávku vytvořil.
     *
     * Může jít o:
     * - zákazníka (QR / takeaway)
     * - obsluhu (objednávka zadaná personálem)
     */
    @Column(name = "user_id", nullable = false, updatable = false)
    private UUID userId;

    /**
     * Logický stůl (skupina stolů), ke kterému je objednávka přiřazena.
     *
     * Vyplněno pouze pro objednávky v restauraci (QR / obsluha).
     * Pro takeaway objednávky je hodnota NULL.
     */
    @Column(name = "table_group_id")
    private UUID tableGroupId;

    /**
     * Volitelná vazba na rezervaci.
     *
     * Vyplněno pouze pokud objednávka vznikla
     * na základě existující rezervace.
     */
    @Column(name = "reservation_id", updatable = false)
    private UUID reservationId;

    /**
     * Typ objednávky – určuje způsob jejího vzniku.
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "order_type", nullable = false, length = 30)
    private OrderType orderType;

    /**
     * Aktuální stav objednávky.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private OrderStatus status;

    /**
     * Položky objednávky.
     *
     * OrderItem je součástí agregátu Order
     * a obsahuje snapshot dat v čase objednání
     * (název, cena, DPH, množství).
     */
    @OneToMany(
            mappedBy = "order",
            fetch = FetchType.LAZY,
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @Builder.Default
    private List<OrderItem> items = new ArrayList<>();

    /**
     * Celková cena objednávky.
     *
     * Uložena denormalizovaně kvůli výkonu,
     * reportům a jednoduchému listování.
     *
     * Hodnota je v nejmenší měnové jednotce
     * (např. haléře).
     */
    @Column(nullable = false)
    private long totalPrice;

    /**
     * Auditní informace.
     */
    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(nullable = false)
    private OffsetDateTime updatedAt;

    /**
     * Inicializace auditních polí při vytvoření.
     */
    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
    }

    /**
     * Aktualizace času poslední změny.
     */
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = OffsetDateTime.now();
    }

    /* =========================================================
       ROZŠÍŘENÍ DOMÉNY (záměrně neimplementováno)
       ---------------------------------------------------------
       - validace stavových přechodů
       - vazba na platbu
       - částečné storno položek
       - audit změn stavu
       ========================================================= */
}
