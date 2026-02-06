package com.checkfood.checkfoodservice.security.user.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

/**
 * Entita reprezentující uživatelskou roli (např. ADMIN, USER).
 * Role definují základní rozsah oprávnění v systému.
 */
@Entity
@Table(
        name = "roles",
        indexes = {
                @Index(name = "idx_role_name", columnList = "name", unique = true)
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoleEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Unikátní název role (např. "USER", "ADMIN").
     */
    @Column(nullable = false, unique = true, length = 50)
    private String name;

    /**
     * Volitelný popis role pro administrátorské účely.
     */
    @Column(length = 255)
    private String description;

    /**
     * Obousměrná vazba na uživatele.
     * MappedBy určuje, že vlastníkem vztahu (JoinTable) je UserEntity.
     */
    @Builder.Default
    @ManyToMany(mappedBy = "roles")
    private Set<UserEntity> users = new HashSet<>();

    /**
     * Relace na jemnější oprávnění (Permissions).
     * Eager fetch je u rolí v pořádku, protože jich bývá malý počet.
     */
    @Builder.Default
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "role_permissions",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "permission_id")
    )
    private Set<PermissionEntity> permissions = new HashSet<>();

    /**
     * Pohodlný konstruktor pro rychlé vytváření rolí.
     */
    public RoleEntity(String name) {
        this.name = name;
    }
}