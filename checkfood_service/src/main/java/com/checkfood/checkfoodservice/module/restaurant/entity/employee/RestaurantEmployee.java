package com.checkfood.checkfoodservice.module.restaurant.entity.employee;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.EnumSet;
import java.util.Set;
import java.util.UUID;

/**
 * Entita reprezentující pracovní vztah mezi uživatelem a restaurací včetně jeho role a oprávnění.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Entity
@Table(
        name = "restaurant_employee",
        indexes = {
                @Index(name = "idx_re_user_id", columnList = "user_id"),
                @Index(name = "idx_re_restaurant_id", columnList = "restaurant_id")
        },
        uniqueConstraints = {
                @UniqueConstraint(name = "uk_re_user_restaurant", columnNames = {"user_id", "restaurant_id"})
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RestaurantEmployee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "restaurant_id", nullable = false)
    private Restaurant restaurant;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false, length = 20)
    private RestaurantEmployeeRole role;

    @Enumerated(EnumType.STRING)
    @Column(name = "membership_status", nullable = false, length = 20)
    @Builder.Default
    private MembershipStatus membershipStatus = MembershipStatus.ACTIVE;

    @ElementCollection(targetClass = EmployeePermission.class, fetch = FetchType.EAGER)
    @CollectionTable(
        name = "employee_permissions",
        joinColumns = @JoinColumn(name = "employee_id")
    )
    @Enumerated(EnumType.STRING)
    @Column(name = "permission", length = 30)
    @Builder.Default
    private Set<EmployeePermission> permissions = EnumSet.noneOf(EmployeePermission.class);

    @Builder.Default
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @PrePersist
    protected void onCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }

    /**
     * Kontroluje, zda má zaměstnanec dané oprávnění.
     * Vlastník (OWNER) má vždy všechna oprávnění bez výjimky.
     * Pokud je sada oprávnění prázdná, použijí se výchozí oprávnění pro danou roli.
     *
     * @param permission oprávnění, které se má ověřit
     * @return {@code true} pokud zaměstnanec má dané oprávnění
     */
    public boolean hasPermission(EmployeePermission permission) {
        if (this.role == RestaurantEmployeeRole.OWNER) {
            return true;
        }
        Set<EmployeePermission> effective = (permissions == null || permissions.isEmpty())
                ? EmployeePermission.defaultsForRole(this.role)
                : permissions;
        return effective.contains(permission);
    }

    /**
     * Vrací efektivní sadu oprávnění zaměstnance.
     * Pokud jsou oprávnění prázdná, vrátí výchozí oprávnění pro aktuální roli.
     *
     * @return efektivní sada oprávnění
     */
    public Set<EmployeePermission> getEffectivePermissions() {
        if (this.role == RestaurantEmployeeRole.OWNER) {
            return EmployeePermission.defaultsForRole(RestaurantEmployeeRole.OWNER);
        }
        if (permissions == null || permissions.isEmpty()) {
            return EmployeePermission.defaultsForRole(this.role);
        }
        return permissions;
    }
}