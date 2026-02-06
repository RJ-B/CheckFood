package com.checkfood.checkfoodservice.application.entity.menu;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Agregátový kořen reprezentující menu restaurace.
 *
 * Menu je samostatná doména navázaná na restauraci pouze
 * přes její identifikátor. Obsahuje kategorie a položky menu.
 */
@Entity
@Table(
        name = "menu",
        indexes = {
                @Index(name = "idx_menu_restaurant_id", columnList = "restaurant_id"),
                @Index(name = "idx_menu_active", columnList = "active")
        }
)
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class Menu {

    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Identifikátor restaurace, ke které menu patří.
     * Nejedná se o JPA vazbu – zachováváme hranice agregátů.
     */
    @Column(name = "restaurant_id", nullable = false, updatable = false)
    private UUID restaurantId;

    /**
     * Název menu (např. "Denní menu", "Stálé menu").
     */
    @Column(nullable = false, length = 100)
    private String name;

    /**
     * Indikuje, zda je menu aktivní.
     */
    @Column(nullable = false)
    private boolean active;

    /**
     * Kategorie menu.
     *
     * LAZY – načítají se pouze při detailu menu.
     */
    @OneToMany(
            mappedBy = "menu",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY
    )
    @Builder.Default
    private List<MenuCategory> categories = new ArrayList<>();

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
}
