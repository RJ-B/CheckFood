package com.checkfood.checkfoodservice.application.entity.menu;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

/**
 * Položka menu.
 */
@Entity
@Table(
        name = "menu_item",
        indexes = {
                @Index(name = "idx_menu_item_category_id", columnList = "category_id"),
                @Index(name = "idx_menu_item_active", columnList = "active")
        }
)
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class MenuItem {

    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Kategorie, do které položka patří.
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id", nullable = false, updatable = false)
    private MenuCategory category;

    /**
     * Název položky.
     */
    @Column(nullable = false, length = 150)
    private String name;

    /**
     * Popis položky.
     */
    @Column(length = 500)
    private String description;

    /**
     * Cena položky.
     */
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    /**
     * Dostupnost položky.
     */
    @Column(nullable = false)
    private boolean active;
}
