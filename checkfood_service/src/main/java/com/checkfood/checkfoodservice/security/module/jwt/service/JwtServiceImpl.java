package com.checkfood.checkfoodservice.security.module.jwt.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.mapper.AuthMapper;
import com.checkfood.checkfoodservice.security.module.jwt.exception.JwtException;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import com.nimbusds.jose.jwk.source.ImmutableSecret;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.stereotype.Service;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.stream.Collectors;

/**
 * Implementace JWT servisu (JDK 21).
 *
 * Oprava:
 * - Implementována chybějící metoda isRefreshToken(String token).
 * - Sjednocená logika pro kontrolu typu tokenu.
 */
@Service
@RequiredArgsConstructor
public class JwtServiceImpl implements JwtService {

    private static final String CLAIM_TYPE = "type";
    private static final String CLAIM_DEVICE_IDENTIFIER = "deviceIdentifier";
    private static final String TYPE_ACCESS = "ACCESS";
    private static final String TYPE_REFRESH = "REFRESH";

    private final JwtProperties jwtProperties;
    private final JwtLogger jwtLogger;
    private final UserService userService;
    private final AuthMapper authMapper;

    private JwtEncoder jwtEncoder;
    private JwtDecoder jwtDecoder;

    @PostConstruct
    private void init() {
        byte[] keyBytes = jwtProperties.getSecret().getBytes(StandardCharsets.UTF_8);
        var secretKey = new SecretKeySpec(keyBytes, "HmacSHA256");

        this.jwtEncoder = new NimbusJwtEncoder(new ImmutableSecret<>(secretKey));
        this.jwtDecoder = NimbusJwtDecoder.withSecretKey(secretKey).build();
    }

    @Override
    public String generateAccessToken(UserEntity user, String deviceIdentifier) {
        Instant now = Instant.now();
        long expiry = jwtProperties.getAccessTokenExpirationSeconds();

        var roles = user.getRoles().stream()
                .map(RoleEntity::getName)
                .collect(Collectors.toSet());

        var claimsBuilder = JwtClaimsSet.builder()
                .issuer(jwtProperties.getIssuer())
                .issuedAt(now)
                .expiresAt(now.plusSeconds(expiry))
                .subject(user.getEmail())
                .claim("roles", roles)
                .claim(CLAIM_TYPE, TYPE_ACCESS);

        if (deviceIdentifier != null) {
            claimsBuilder.claim(CLAIM_DEVICE_IDENTIFIER, deviceIdentifier);
        }

        try {
            String token = encode(claimsBuilder.build());
            jwtLogger.logTokenGenerated(user.getEmail(), "access");
            return token;
        } catch (Exception e) {
            throw JwtException.generationError(e.getMessage(), e);
        }
    }

    @Override
    public String generateRefreshToken(UserEntity user, String deviceIdentifier) {
        Instant now = Instant.now();
        long expiry = jwtProperties.getRefreshTokenExpirationSeconds();

        var claimsBuilder = JwtClaimsSet.builder()
                .issuer(jwtProperties.getIssuer())
                .issuedAt(now)
                .expiresAt(now.plusSeconds(expiry))
                .subject(user.getEmail())
                .claim(CLAIM_TYPE, TYPE_REFRESH);

        if (deviceIdentifier != null) {
            claimsBuilder.claim(CLAIM_DEVICE_IDENTIFIER, deviceIdentifier);
        }

        try {
            String token = encode(claimsBuilder.build());
            jwtLogger.logTokenGenerated(user.getEmail(), "refresh");
            return token;
        } catch (Exception e) {
            throw JwtException.generationError(e.getMessage(), e);
        }
    }

    @Override
    public AuthResponse refreshTokens(String refreshToken) {
        Jwt jwt;
        try {
            jwt = jwtDecoder.decode(refreshToken);
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            throw JwtException.invalidToken(e.getMessage());
        }

        // Kontrola typu tokenu pomocí privátní pomocné metody
        if (!isRefreshTokenInternal(jwt)) {
            throw JwtException.invalidToken("Byl použit Access Token místo Refresh Tokenu");
        }

        String email = jwt.getSubject();
        String deviceIdentifier = jwt.getClaim(CLAIM_DEVICE_IDENTIFIER);

        UserEntity user;
        try {
            user = userService.findByEmail(email);
        } catch (Exception e) {
            throw JwtException.userNotFound(email);
        }

        if (!user.isEnabled()) {
            throw JwtException.accountDisabled();
        }

        String newAccessToken = generateAccessToken(user, deviceIdentifier);
        String newRefreshToken = generateRefreshToken(user, deviceIdentifier);

        jwtLogger.logTokenRefresh(email);

        return authMapper.toAuthResponse(
                user,
                newAccessToken,
                newRefreshToken,
                jwtProperties.getAccessTokenExpirationSeconds()
        );
    }

    @Override
    public String extractEmail(String token) {
        try {
            var jwt = jwtDecoder.decode(token);
            return jwt.getSubject();
        } catch (Exception e) {
            throw JwtException.invalidToken("Nelze extrahovat email: " + e.getMessage());
        }
    }

    @Override
    public String extractDeviceIdentifier(String token) {
        String cleanToken = token.startsWith("Bearer ") ? token.substring(7) : token;
        try {
            var jwt = jwtDecoder.decode(cleanToken);
            return jwt.getClaim(CLAIM_DEVICE_IDENTIFIER);
        } catch (Exception e) {
            throw JwtException.invalidToken("Nelze extrahovat device ID: " + e.getMessage());
        }
    }

    @Override
    public boolean validateToken(String token) {
        try {
            jwtDecoder.decode(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean isTokenValid(String token, UserEntity user) {
        try {
            var jwt = jwtDecoder.decode(token);
            String email = jwt.getSubject();
            String type = jwt.getClaim(CLAIM_TYPE);

            boolean isAccessToken = TYPE_ACCESS.equals(type);
            boolean isEmailValid = email.equals(user.getEmail());
            boolean isNotExpired = jwt.getExpiresAt() != null && jwt.getExpiresAt().isAfter(Instant.now());

            return isEmailValid && isNotExpired && isAccessToken;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public Long getAccessTokenExpirationSeconds() {
        return jwtProperties.getAccessTokenExpirationSeconds();
    }

    // ✅ IMPLEMENTACE CHYBĚJÍCÍ METODY Z INTERFACE
    @Override
    public boolean isRefreshToken(String token) {
        try {
            var jwt = jwtDecoder.decode(token);
            return isRefreshTokenInternal(jwt);
        } catch (Exception e) {
            return false;
        }
    }

    // --- Private Helpers ---

    private boolean isRefreshTokenInternal(Jwt jwt) {
        String type = jwt.getClaim(CLAIM_TYPE);
        return TYPE_REFRESH.equals(type);
    }

    private String encode(JwtClaimsSet claims) {
        var header = JwsHeader.with(MacAlgorithm.HS256).build();
        var params = JwtEncoderParameters.from(header, claims);
        return jwtEncoder.encode(params).getTokenValue();
    }
}