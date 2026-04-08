package com.checkfood.checkfoodservice.security.module.user.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

/**
 * JPA entita reprezentující uživatelskou roli v RBAC systému.
 * Role definují základní rozsah oprávnění uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserEntity
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
     * Pomocný konstruktor pro rychlé vytváření rolí pouze s názvem.
     *
     * @param name název role
     */
    public RoleEntity(String name) {
        this.name = name;
    }
}