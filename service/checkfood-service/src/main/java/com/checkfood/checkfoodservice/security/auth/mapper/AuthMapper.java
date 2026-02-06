package com.checkfood.checkfoodservice.security.auth.mapper;

import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Profesionální mapper pro autentizační modul.
 * Zajišťuje transformaci entit a bezpečnostních prvků na DTO objekty pro frontend.
 */
@Component
@RequiredArgsConstructor
public class AuthMapper {

    private final UserMapper userMapper;

    /**
     * Sestaví kompletní AuthResponse (JWT + User data).
     * Používá se primárně po úspěšném přihlášení (Login).
     * * Poznámka: Od verze s verifikací e-mailu se již nepoužívá přímo při registraci,
     * protože registrace končí stavem Accepted bez návratu tokenů.
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
     * Vytvoří odpověď obsahující pouze nové tokeny.
     * Používá se při procesu obnovy (Refresh Token), kdy je identita uživatele
     * již na frontendu známa a stačí aktualizovat platnost relace.
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
     * Převede entitu uživatele na bezpečnou projekci UserResponse.
     * Deleguje práci na UserMapper, což zaručuje jednotnost dat napříč moduly.
     */
    public UserResponse toUserResponse(UserEntity user) {
        if (user == null) {
            return null;
        }
        return userMapper.toAuth(user);
    }
}