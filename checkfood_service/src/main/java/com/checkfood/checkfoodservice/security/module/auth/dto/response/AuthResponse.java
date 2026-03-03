package com.checkfood.checkfoodservice.security.module.auth.dto.response;

import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import lombok.*;

/**
 * Response DTO pro úspěšnou autentizaci obsahující JWT tokens a user profile.
 *
 * Kompletní authentication response kombinující session tokens s user
 * information pro client-side state initialization po successful login.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserResponse
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuthResponse {

    /**
     * JWT access token pro API authorization.
     * Short-lived token používaný v Authorization header jako "Bearer {token}".
     */
    private String accessToken;

    /**
     * Refresh token pro access token renewal.
     * Long-lived token pro seamless session extension bez re-authentication.
     */
    private String refreshToken;

    /**
     * Token type identifier pro Authorization header formatting.
     */
    @Builder.Default
    private String tokenType = "Bearer";

    /**
     * Access token expiration time v sekundách pro client-side refresh logic.
     */
    private Long expiresIn;

    /**
     * Complete user profile information pro client state initialization.
     */
    private UserResponse user;
}