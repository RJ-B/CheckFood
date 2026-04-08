package com.checkfood.checkfoodservice.security.module.user.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

/**
 * JPA entita reprezentující uživatelskou roli v RBAC systému.
 * Role definují základní rozsah oprávnění a mohou obsahovat sadu jemnějších oprávnění.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserEntity
 * @see PermissionEntity
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
     * Unikátní název role bez prefixu "ROLE_".
     * Příklady: "USER", "ADMIN", "OWNER", "STAFF", "MANAGER".
     * Prefix se přidává automaticky v UserEntity.getAuthorities().
     */
    @Column(nullable = false, unique = true, length = 50)
    private String name;

    /**
     * Volitelný popis role pro administrátorské účely.
     */
    @Column(length = 255)
    private String description;

    /**
     * Uživatelé s touto rolí.
     * Obousměrná vazba, vlastníkem vztahu je UserEntity.
     */
    @Builder.Default
    @ManyToMany(mappedBy = "roles")
    private Set<UserEntity> users = new HashSet<>();

    /**
     * Jemnější oprávnění přiřazená této roli.
     * Eager fetch je vhodný, protože rolí i jejich permissions je obvykle málo.
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
     * Pomocný konstruktor pro rychlé vytváření rolí pouze s názvem.
     *
     * @param name název role
     */
    public RoleEntity(String name) {
        this.name = name;
    }
}