package com.checkfood.checkfoodservice.security.user.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

/**
 * Entita reprezentující jemná oprávnění v systému (fine-grained permissions).
 * Oprávnění jsou přiřazována rolím, nikoliv přímo uživatelům.
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
     * Unikátní název oprávnění (např. "READ_PRIVILEGE", "ORDER_CANCEL").
     */
    @Column(nullable = false, unique = true, length = 100)
    private String name;

    /**
     * Popis, co konkrétně toto oprávnění uživateli umožňuje.
     */
    @Column(length = 255)
    private String description;

    /**
     * Obousměrná vazba na role.
     * MappedBy určuje, že vlastníkem vztahu je RoleEntity.
     */
    @Builder.Default
    @ManyToMany(mappedBy = "permissions")
    private Set<RoleEntity> roles = new HashSet<>();

    /**
     * Pomocný konstruktor pro snadnou inicializaci základních oprávnění.
     */
    public PermissionEntity(String name) {
        this.name = name;
    }
}