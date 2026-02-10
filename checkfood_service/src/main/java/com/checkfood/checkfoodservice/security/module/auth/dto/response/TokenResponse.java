package com.checkfood.checkfoodservice.security.module.auth.dto.response;

import lombok.*;

/**
 * Odpověď obsahující pouze tokeny a metadata o jejich platnosti.
 * Používá se pro refresh endpoint, kde již není potřeba přenášet informace o uživateli.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TokenResponse {

    private String accessToken;

    /**
     * Nový refresh token při použití strategie rotace tokenů.
     * Starý refresh token je po úspěšném obnovení invalidován.
     */
    private String refreshToken;

    @Builder.Default
    private String tokenType = "Bearer";

    private Long expiresIn;
}