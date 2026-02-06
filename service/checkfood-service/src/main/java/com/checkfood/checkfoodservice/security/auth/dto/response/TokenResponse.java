package com.checkfood.checkfoodservice.security.auth.dto.response;

import lombok.*;

/**
 * Odlehčená odpověď obsahující výhradně tokeny a informace o jejich platnosti.
 * Používá se pro endpoint /refresh, kde již známe identitu uživatele a šetříme přenesená data.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TokenResponse {

    /**
     * Nově vygenerovaný Access Token pro autorizaci požadavků.
     */
    private String accessToken;

    /**
     * Nový Refresh Token (při použití strategie rotace tokenů).
     */
    private String refreshToken;

    /**
     * Typ tokenu (standardně "Bearer") pro snadné sestavení Authorization hlavičky na klientovi.
     */
    @Builder.Default
    private String tokenType = "Bearer";

    /**
     * Doba platnosti nového Access Tokenu v sekundách.
     */
    private Long expiresIn;
}