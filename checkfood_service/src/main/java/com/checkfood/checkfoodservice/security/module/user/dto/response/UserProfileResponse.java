package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Detailní doménová reprezentace uživatelského profilu.
 * Slouží jako primární model pro klientskou aplikaci po úspěšné autentizaci.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserProfileResponse {

    private Long id;

    private String email;

    private String firstName;

    private String lastName;

    /**
     * Indikátor verifikované a aktivní identity v systému.
     */
    private Boolean isActive;

    /**
     * Časová značka posledního zaznamenaného přístupu do systému.
     */
    private LocalDateTime lastLogin;

    /**
     * Auditní údaj o vzniku uživatelského subjektu.
     */
    private LocalDateTime createdAt;

    /**
     * Kolekce identifikátorů rolí definujících rozsah oprávnění uživatele.
     */
    private List<String> roles;

    /**
     * Přehled terminálů a relací asociovaných s tímto uživatelským účtem.
     */
    private List<DeviceResponse> devices;
}