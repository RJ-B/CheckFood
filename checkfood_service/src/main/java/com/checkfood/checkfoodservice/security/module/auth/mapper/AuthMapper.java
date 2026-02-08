package com.checkfood.checkfoodservice.security.module.auth.mapper;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Mapper pro transformaci autentizačních entit na DTO objekty.
 * Zajišťuje konzistentní mapování uživatelských dat a tokenů pro API odpovědi.
 *
 * @see AuthResponse
 * @see TokenResponse
 * @see UserResponse
 * @see UserMapper
 */
@Component
@RequiredArgsConstructor
public class AuthMapper {

    private final UserMapper userMapper;

    /**
     * Sestaví kompletní autentizační odpověď obsahující tokeny a informace o uživateli.
     * Používá se po úspěšném přihlášení, kde frontend potřebuje jak tokeny, tak profil uživatele.
     *
     * @param user entita uživatele
     * @param accessToken JWT access token
     * @param refreshToken refresh token pro obnovu relace
     * @param expiresIn doba platnosti access tokenu v sekundách
     * @return kompletní autentizační odpověď
     */
    public AuthResponse toAuthResponse(
            UserEntity user,
            String accessToken,
            String refreshToken,
            Long expiresIn
    ) {
        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .expiresIn(expiresIn)
                .user(toUserResponse(user))
                .build();
    }

    /**
     * Vytvoří odpověď obsahující pouze nové tokeny bez informací o uživateli.
     * Používá se při refresh token flow, kde frontend již má profil uživatele
     * a potřebuje pouze obnovit platnost tokenů.
     *
     * @param accessToken nový JWT access token
     * @param refreshToken nový refresh token
     * @param expiresIn doba platnosti access tokenu v sekundách
     * @return odpověď s tokeny
     */
    public TokenResponse toTokenResponse(
            String accessToken,
            String refreshToken,
            Long expiresIn
    ) {
        return TokenResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .expiresIn(expiresIn)
                .build();
    }

    /**
     * Převede entitu uživatele na bezpečnou DTO projekci.
     * Deleguje mapování na UserMapper pro zajištění konzistence napříč moduly.
     *
     * @param user entita uživatele
     * @return DTO s bezpečnými uživatelskými daty, nebo null pokud je vstup null
     */
    public UserResponse toUserResponse(UserEntity user) {
        if (user == null) {
            return null;
        }
        return userMapper.toAuth(user);
    }
}