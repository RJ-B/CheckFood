package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;
import java.time.LocalDateTime;

/**
 * Detailní profil uživatele pro zobrazení v sekci nastavení.
 * Odpovídá UserProfileResponseModel ve Flutteru.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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
    private String profileImageUrl;
    private String phone;
    private Boolean isActive;
    private LocalDateTime lastLogin;
    private LocalDateTime createdAt;
    private String role;
    private String authProvider;
    private String addressStreet;
    private String addressCity;
    private String addressPostalCode;
    private String addressCountry;
}