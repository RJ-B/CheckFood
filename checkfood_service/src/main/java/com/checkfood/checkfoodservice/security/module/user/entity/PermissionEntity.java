package com.checkfood.checkfoodservice.security.module.user.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

/**
 * Entita reprezentující jemná oprávnění v systému (fine-grained permissions).
 * Oprávnění definují konkrétní akce, které může uživatel provádět.
 * Přiřazují se rolím, nikoliv přímo uživatelům, pro snadnější správu.
 *
 * @see RoleEntity
 */
@Entity
@Table(
        name = "permissions",
        indexes = {
                @Index(name = "idx_permission_name", columnList = "name", unique = true)
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PermissionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Unikátní název oprávnění.
     * Příklady: "READ_PRIVILEGE", "ORDER_CANCEL", "USER_DELETE".
     * Konvence: ENTITA_AKCE nebo obecná oprávnění.
     */
    @Column(nullable = false, unique = true, length = 100)
    private String name;

    /**
     * Lidsky čitelný popis oprávnění.
     * Vysvětluje, co konkrétně toto oprávnění uživateli umožňuje.
     */
    @Column(length = 255)
    private String description;

    /**
     * Role, které obsahují toto oprávnění.
     * Obousměrná vazba, vlastníkem vztahu je RoleEntity.
     */
    @Builder.Default
    @ManyToMany(mappedBy = "permissions")
    private Set<RoleEntity> roles = new HashSet<>();

    /**
     * Pomocný konstruktor pro rychlé vytváření oprávnění pouze s názvem.
     * Používá se typicky v migration skriptech nebo seed datech.
     *
     * @param name název oprávnění
     */
    public PermissionEntity(String name) {
        this.name = name;
    }
}