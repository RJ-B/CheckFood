package com.checkfood.checkfoodservice.security.module.user.entity;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
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
 * Centrální JPA entita reprezentující uživatelský subjekt implementující {@link UserDetails}.
 * Obsahuje osobní údaje, autentizační metadata, přiřazené role a registrovaná zařízení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see RoleEntity
 * @see DeviceEntity
 */
@Entity
@Table(
        name = "users",
        indexes = {
                @Index(name = "idx_user_email", columnList = "email", unique = true),
                @Index(name = "idx_user_provider_identity", columnList = "auth_provider, provider_id")
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
     * URL adresa profilového obrázku získaná z OAuth providera (např. Google).
     * Slouží jako fallback, pokud uživatel neuploadoval custom avatar.
     */
    @Column(name = "profile_image_url", length = 512)
    private String profileImageUrl;

    /**
     * Object path v privátním GCS bucketu pro custom avatar uploadovaný uživatelem.
     * Při serializaci se z této cesty generuje V4 signed URL s defaultní platností 1h.
     * Pokud je {@code null}, používá se {@link #profileImageUrl} jako fallback.
     */
    @Column(name = "avatar_object_path", length = 512)
    private String avatarObjectPath;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "address_street", length = 255)
    private String addressStreet;

    @Column(name = "address_city", length = 100)
    private String addressCity;

    @Column(name = "address_postal_code", length = 20)
    private String addressPostalCode;

    @Column(name = "address_country", length = 100)
    private String addressCountry;

    @Column(length = 255)
    private String password;

    @Enumerated(EnumType.STRING)
    @Column(name = "auth_provider", nullable = false, length = 20)
    private AuthProvider authProvider;

    @Column(name = "provider_id", nullable = false)
    private String providerId;

    @Builder.Default
    @Column(nullable = false)
    private boolean enabled = false;

    /**
     * Úroveň vlastníka restaurace: TRIAL (zkušební) nebo FULL (plný přístup).
     * Null pro uživatele bez role OWNER.
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "owner_tier", length = 20)
    private OwnerTier ownerTier;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @Builder.Default
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_roles",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id")
    )
    private Set<RoleEntity> roles = new HashSet<>();

    @Builder.Default
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<DeviceEntity> devices = new HashSet<>();

    /**
     * Nastaví časová razítka a výchozí providerId před prvním persistováním entity.
     */
    @PrePersist
    protected void onCreate() {
        LocalDateTime now = LocalDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;

        if (this.authProvider == AuthProvider.LOCAL && this.providerId == null) {
            this.providerId = this.email;
        }
    }

    /**
     * Aktualizuje časové razítko poslední změny entity.
     */
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Přidá zařízení k uživateli a nastaví zpětný odkaz na vlastníka.
     *
     * @param device zařízení k přidání
     */
    public void addDevice(DeviceEntity device) {
        devices.add(device);
        device.setUser(this);
    }

    /**
     * Odebere zařízení od uživatele a vymaže zpětný odkaz na vlastníka.
     *
     * @param device zařízení k odebrání
     */
    public void removeDevice(DeviceEntity device) {
        devices.remove(device);
        device.setUser(null);
    }

    /**
     * Vrátí kolekci Spring Security oprávnění odvozených z rolí uživatele.
     * Každá role je namapována na {@code SimpleGrantedAuthority} s prefixem {@code ROLE_}.
     *
     * @return kolekce grantovaných oprávnění
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getName()))
                .collect(Collectors.toSet());
    }

    /**
     * Vrátí e-mailovou adresu jako unikátní přihlašovací jméno uživatele.
     *
     * @return e-mailová adresa uživatele
     */
    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() { return true; }

    @Override
    public boolean isAccountNonLocked() { return true; }

    @Override
    public boolean isCredentialsNonExpired() { return true; }

    @Override
    public boolean isEnabled() {
        return enabled;
    }
}