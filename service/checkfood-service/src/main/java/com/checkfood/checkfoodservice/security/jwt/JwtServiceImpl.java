package com.checkfood.checkfoodservice.security.jwt;

import com.checkfood.checkfoodservice.security.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.nimbusds.jose.jwk.source.ImmutableSecret;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.stereotype.Service;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Implementace JWT servisy využívající Spring Security OAuth2 (Nimbus).
 * Zajišťuje bezpečné generování a validaci Access a Refresh tokenů.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class JwtServiceImpl implements JwtService {

    private static final String CLAIM_TYPE = "type";
    private static final String TYPE_ACCESS = "ACCESS";
    private static final String TYPE_REFRESH = "REFRESH";

    private final JwtProperties jwtProperties;
    private JwtEncoder jwtEncoder;
    private JwtDecoder jwtDecoder;

    @PostConstruct
    private void init() {
        byte[] keyBytes = jwtProperties.getSecret().getBytes(StandardCharsets.UTF_8);
        SecretKeySpec secretKey = new SecretKeySpec(keyBytes, "HmacSHA256");

        this.jwtEncoder = new NimbusJwtEncoder(new ImmutableSecret<>(secretKey));
        this.jwtDecoder = NimbusJwtDecoder.withSecretKey(secretKey).build();
    }

    // =====================================================
    // GENERATION
    // =====================================================

    @Override
    public String generateAccessToken(UserEntity user) {
        Instant now = Instant.now();
        long expiry = jwtProperties.getAccessTokenExpirationSeconds();

        Set<String> roles = user.getRoles().stream()
                .map(RoleEntity::getName)
                .collect(Collectors.toSet());

        JwtClaimsSet claims = JwtClaimsSet.builder()
                .issuer(jwtProperties.getIssuer())
                .issuedAt(now)
                .expiresAt(now.plusSeconds(expiry))
                .subject(user.getEmail())
                .claim("roles", roles)
                .claim(CLAIM_TYPE, TYPE_ACCESS)
                .build();

        return encode(claims);
    }

    @Override
    public String generateRefreshToken(UserEntity user) {
        Instant now = Instant.now();
        long expiry = jwtProperties.getRefreshTokenExpirationSeconds();

        JwtClaimsSet claims = JwtClaimsSet.builder()
                .issuer(jwtProperties.getIssuer())
                .issuedAt(now)
                .expiresAt(now.plusSeconds(expiry))
                .subject(user.getEmail())
                .claim(CLAIM_TYPE, TYPE_REFRESH)
                .build();

        return encode(claims);
    }

    // =====================================================
    // VALIDATION & EXTRACTION
    // =====================================================

    @Override
    public String extractEmail(String token) {
        try {
            Jwt jwt = jwtDecoder.decode(token);
            return jwt.getSubject();
        } catch (JwtException e) {
            log.error("Nepodařilo se extrahovat email z tokenu: {}", e.getMessage());
            return null;
        }
    }

    @Override
    public boolean validateToken(String token) {
        try {
            jwtDecoder.decode(token);
            return true;
        } catch (JwtException e) {
            log.warn("Neplatný JWT token: {}", e.getMessage());
            return false;
        }
    }

    @Override
    public boolean isTokenValid(String token, UserEntity user) {
        try {
            Jwt jwt = jwtDecoder.decode(token);
            String email = jwt.getSubject();

            String type = jwt.getClaim(CLAIM_TYPE);
            boolean isAccessToken = TYPE_ACCESS.equals(type);
            // ------------------------------

            boolean isEmailValid = email.equals(user.getEmail());
            boolean isNotExpired = jwt.getExpiresAt() != null && jwt.getExpiresAt().isAfter(Instant.now());

            return isEmailValid && isNotExpired && isAccessToken;
        } catch (JwtException e) {
            return false;
        }
    }

    @Override
    public Long getAccessTokenExpirationSeconds() {
        return jwtProperties.getAccessTokenExpirationSeconds();
    }

    // =====================================================
    // INTERNAL
    // =====================================================

    private String encode(JwtClaimsSet claims) {
        JwsHeader header = JwsHeader.with(MacAlgorithm.HS256).build();
        JwtEncoderParameters params = JwtEncoderParameters.from(header, claims);
        return jwtEncoder.encode(params).getTokenValue();
    }
}