package com.checkfood.checkfoodservice.security.module.auth.dto.response;

import lombok.*;

/**
 * Response DTO pro token refresh operations obsahující pouze token metadata.
 *
 * Lightweight response používaná pro refresh endpoint kde user information
 * není potřeba - client již má user state z původního login response.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TokenResponse {

    /**
     * Nový JWT access token s extended expiration.
     */
    private String accessToken;

    /**
     * Nový refresh token při token rotation strategy.
     * Starý refresh token je invalidován po successful refresh operation.
     */
    private String refreshToken;

    /**
     * Token type pro consistent Authorization header formatting.
     */
    @Builder.Default
    private String tokenType = "Bearer";

    /**
     * Nový access token expiration time v sekundách.
     */
    private Long expiresIn;
}