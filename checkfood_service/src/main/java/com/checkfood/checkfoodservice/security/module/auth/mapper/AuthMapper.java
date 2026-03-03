package com.checkfood.checkfoodservice.security.module.auth.mapper;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * Mapping component pro transformation mezi autentizačními DTO a entities.
 *
 * Zajišťuje data sanitization a secure mapping s eliminací sensitive data
 * (passwords, internal IDs) z outbound responses. Deleguje user-specific
 * mapping na UserMapper pro separation of concerns.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserMapper
 * @see AuthProvider
 */
@Component
@RequiredArgsConstructor
public class AuthMapper {

    /**
     * User mapper pro user-specific DTO transformations.
     */
    private final UserMapper userMapper;

    /**
     * Maps registration request na UserEntity template pro persistence layer.
     *
     * Password není included v mapping - musí být processed separately
     * přes PasswordEncoder v service layer pro security reasons. Entity
     * je created v disabled state requiring email verification.
     *
     * @param request validated registration data
     * @return UserEntity template ready pro service layer processing
     */
    public UserEntity toEntity(RegisterRequest request) {
        if (request == null) {
            return null;
        }

        return UserEntity.builder()
                .email(request.getEmail())
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .authProvider(AuthProvider.LOCAL)
                .providerId(request.getEmail()) // LOCAL provider uses email jako providerId
                .enabled(false) // Requires email verification
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();
    }

    /**
     * Sestaví complete authentication response pro successful login.
     *
     * Combines JWT tokens s user profile data pro client state initialization.
     * Used pro login a OAuth login workflows.
     *
     * @param user authenticated user entity
     * @param accessToken JWT access token
     * @param refreshToken JWT refresh token
     * @param expiresIn token expiration v sekundách
     * @return complete authentication response
     */
    public AuthResponse toAuthResponse(UserEntity user, String accessToken, String refreshToken, Long expiresIn) {
        if (user == null) {
            return null;
        }

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .tokenType("Bearer")
                .expiresIn(expiresIn)
                .user(toUserResponse(user)) // Delegation pro user data mapping
                .build();
    }

    /**
     * Maps token data pro refresh token response.
     *
     * Lightweight response obsahující pouze token metadata bez user data
     * protože client již má user state z original login.
     *
     * @param accessToken new JWT access token
     * @param refreshToken new JWT refresh token
     * @param expiresIn token expiration v sekundách
     * @return token-only response
     */
    public TokenResponse toTokenResponse(String accessToken, String refreshToken, Long expiresIn) {
        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .tokenType("Bearer")
                .expiresIn(expiresIn)
                .build();
    }

    /**
     * Transforms UserEntity na secure UserResponse DTO.
     *
     * Delegates na UserMapper pro consistent user data transformation
     * across application modules. Ensures roles a authorities jsou properly
     * mapped pro authorization purposes.
     *
     * @param user UserEntity s loaded roles
     * @return sanitized user response DTO
     */
    public UserResponse toUserResponse(UserEntity user) {
        if (user == null) {
            return null;
        }
        return userMapper.toAuth(user);
    }
}