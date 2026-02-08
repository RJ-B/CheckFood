package com.checkfood.checkfoodservice.application.entity.menu;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Kategorie v rámci menu (např. Předkrmy, Hlavní chody).
 */
@Entity
@Table(
        name = "menu_category",
        indexes = {
                @Index(name = "idx_menu_category_menu_id", columnList = "menu_id")
        }
)
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class MenuCategory {

    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Menu, ke kterému kategorie patří.
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "menu_id", nullable = false, updatable = false)
    private Menu menu;

    /**
     * Název kategorie.
     */
    @Column(nullable = false, length = 100)
    private String name;

    /**
     * Pořadí zobrazení.
     */
    @Column(nullable = false)
    private int position;

    /**
     * Položky v kategorii.
     */
    @OneToMany(
            mappedBy = "category",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY
    )
    @Builder.Default
    private List<MenuItem> items = new ArrayList<>();
}
