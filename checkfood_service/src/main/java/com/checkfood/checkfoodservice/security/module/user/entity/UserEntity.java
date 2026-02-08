package com.checkfood.checkfoodservice.security.module.user.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Centrální doménová entita reprezentující uživatelský subjekt.
 * Implementace UserDetails zajišťuje kompatibilitu s bezpečnostním kontextem Spring Security.
 */
@Entity
@Table(
        name = "users",
        indexes = {
                @Index(name = "idx_user_email", columnList = "email", unique = true)
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserEntity implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 254)
    private String email;

    @Column(length = 50)
    private String firstName;

    @Column(length = 50)
    private String lastName;

    /**
     * Hashované heslo (BCrypt).
     */
    @Column(nullable = false, length = 255)
    private String password;

    /**
     * Stav aktivace účtu. Řídí přístup k systému před dokončením verifikace identity.
     */
    @Builder.Default
    @Column(nullable = false)
    private boolean enabled = false;

    /**
     * Auditní záznam o vytvoření identity.
     */
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    /**
     * Auditní záznam o poslední modifikaci stavu entity.
     */
    private LocalDateTime updatedAt;

    /**
     * RBAC (Role-Based Access Control) vazba.
     * Používá se Lazy loading pro eliminaci zbytečné zátěže persistence contextu.
     */
    @Builder.Default
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_roles",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id")
    )
    private Set<RoleEntity> roles = new HashSet<>();

    /**
     * Kolekce registrovaných klientských zařízení a jejich session kontextů.
     */
    @Builder.Default
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<DeviceEntity> devices = new HashSet<>();

    // --- Persistence Lifecycle Callbacks ---

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = this.createdAt;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // --- Synchronization Helpers ---

    /**
     * Zajišťuje konzistenci obousměrné vazby mezi uživatelem a zařízením.
     */
    public void addDevice(DeviceEntity device) {
        devices.add(device);
        device.setUser(this);
    }

    /**
     * Terminace vazby na zařízení při odstranění session.
     */
    public void removeDevice(DeviceEntity device) {
        devices.remove(device);
        device.setUser(null);
    }

    // --- UserDetails Implementation ---

    /**
     * Transformuje persistované role na granulární autority Spring Security.
     * Každá role je prefixována standardním identifikátorem "ROLE_".
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getName()))
                .collect(Collectors.toSet());
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }
}