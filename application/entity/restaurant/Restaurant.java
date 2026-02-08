package com.checkfood.checkfoodservice.application.entity.restaurant;

import com.checkfood.checkfoodservice.application.entity.common.Address;
import com.checkfood.checkfoodservice.application.entity.restaurant.table.RestaurantTable;
import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Doménová entita reprezentující restauraci.
 *
 * Restaurant je agregátový kořen zodpovědný za:
 * - základní identitu restaurace
 * - životní cyklus restaurace (aktivní / neaktivní)
 * - správu stolů (RestaurantTable)
 *
 * Další domény (menu, rezervace, hodnocení, otevírací doba)
 * jsou modelovány jako samostatné agregáty a na restauraci
 * se vážou nepřímo přes její identifikátor.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "restaurant",
        indexes = {
                @Index(name = "idx_restaurant_status", columnList = "status"),
                @Index(name = "idx_restaurant_active", columnList = "active")
        }
)
public class Restaurant {

    /**
     * Primární identifikátor restaurace.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Veřejný název restaurace.
     */
    @Column(nullable = false, length = 150)
    private String name;

    /**
     * Interní popis / prezentace restaurace.
     */
    @Column(length = 500)
    private String description;

    /**
     * Stav restaurace z pohledu systému.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private RestaurantStatus status;

    /**
     * Rychlý flag pro filtrování aktivních restaurací.
     */
    @Column(nullable = false)
    private boolean active;

    /**
     * Adresa restaurace.
     *
     * Address je Value Object vložený přímo
     * do tabulky restaurant (bez JOIN).
     */
    @Embedded
    private Address address;

    /**
     * Seznam stolů patřících k restauraci.
     *
     * Stoly jsou samostatný agregát a
     * nejsou mapovány přes JPA vztah.
     */
    @Transient
    @Builder.Default
    private List<RestaurantTable> tables = new ArrayList<>();


    /**
     * Auditní informace.
     */
    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(nullable = false)
    private OffsetDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = OffsetDateTime.now();
    }

    /* =========================================================
       ROZŠIŘITELNOST DOMÉNY
       ---------------------------------------------------------
       - otevírací doba
       - hodnocení / rating
       - externí integrace (Google Places sync)
       ========================================================= */
}
