package com.checkfood.checkfoodservice.security.module.jwt.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.mapper.AuthMapper;
import com.checkfood.checkfoodservice.security.module.jwt.entity.RefreshTokenEntity;
import com.checkfood.checkfoodservice.security.module.jwt.exception.JwtException;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.module.jwt.repository.RefreshTokenRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import com.nimbusds.jose.jwk.source.ImmutableSecret;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Instant;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementace JWT servisu zajišťující generování, validaci, extrakci a rotaci JWT tokenů.
 * Používá Spring Security OAuth2 JWT infrastrukturu s HS256 algoritmem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see JwtService
 * @see JwtProperties
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class JwtServiceImpl implements JwtService {

    private static final String CLAIM_TYPE = "type";
    private static final String CLAIM_DEVICE_IDENTIFIER = "deviceIdentifier";
    private static final String TYPE_ACCESS = "ACCESS";
    private static final String TYPE_REFRESH = "REFRESH";

    /**
     * Audience claim value. Every token we mint must declare this aud and
     * every token we accept must contain it — this closes the classic
     * "token-scope confusion" attack where an attacker tries to reuse a
     * token issued for another service under a shared HMAC secret.
     */
    private static final String TOKEN_AUDIENCE = "checkfood-api";

    private final JwtProperties jwtProperties;
    private final JwtLogger jwtLogger;
    private final UserService userService;
    private final AuthMapper authMapper;
    private final RefreshTokenRepository refreshTokenRepository;

    private JwtEncoder jwtEncoder;
    private JwtDecoder jwtDecoder;

    /**
     * Inicializuje JwtEncoder a JwtDecoder po sestavení beanu z konfiguračních properties.
     */
    @PostConstruct
    private void init() {
        byte[] keyBytes = jwtProperties.getSecret().getBytes(StandardCharsets.UTF_8);
        var secretKey = new SecretKeySpec(keyBytes, "HmacSHA256");

        this.jwtEncoder = new NimbusJwtEncoder(new ImmutableSecret<>(secretKey));

        // Decoder with default validators (timestamp + issuer) PLUS a
        // strict audience check. Any token missing or carrying a wrong
        // `aud` claim is rejected, so a token forged by another service
        // that happens to share the same HMAC key cannot be replayed here.
        NimbusJwtDecoder decoder = NimbusJwtDecoder.withSecretKey(secretKey).build();
        org.springframework.security.oauth2.core.OAuth2TokenValidator<org.springframework.security.oauth2.jwt.Jwt> defaultValidator =
                org.springframework.security.oauth2.jwt.JwtValidators.createDefaultWithIssuer(jwtProperties.getIssuer());
        org.springframework.security.oauth2.core.OAuth2TokenValidator<org.springframework.security.oauth2.jwt.Jwt> audienceValidator =
                new org.springframework.security.oauth2.core.OAuth2TokenValidator<>() {
                    @Override
                    public org.springframework.security.oauth2.core.OAuth2TokenValidatorResult validate(
                            org.springframework.security.oauth2.jwt.Jwt jwt) {
                        var audiences = jwt.getAudience();
                        if (audiences != null && audiences.contains(TOKEN_AUDIENCE)) {
                            return org.springframework.security.oauth2.core.OAuth2TokenValidatorResult.success();
                        }
                        var err = new org.springframework.security.oauth2.core.OAuth2Error(
                                "invalid_token",
                                "Missing or wrong aud claim (expected " + TOKEN_AUDIENCE + ")",
                                null);
                        return org.springframework.security.oauth2.core.OAuth2TokenValidatorResult.failure(err);
                    }
                };
        decoder.setJwtValidator(new org.springframework.security.oauth2.core.DelegatingOAuth2TokenValidator<>(
                defaultValidator, audienceValidator));
        this.jwtDecoder = decoder;
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
                .audience(java.util.List.of(TOKEN_AUDIENCE))
                .id(UUID.randomUUID().toString())
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

        // jti = unique per-token identifier. Without this claim, two refresh
        // tokens minted in the same second for the same user+device would
        // produce byte-identical JWT payloads and therefore the same SHA-256
        // hash → unique-index violation in refresh_tokens when a legitimate
        // rotation races the JWT generation.
        var claimsBuilder = JwtClaimsSet.builder()
                .issuer(jwtProperties.getIssuer())
                .audience(java.util.List.of(TOKEN_AUDIENCE))
                .id(UUID.randomUUID().toString())
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
    @Transactional
    public AuthResponse refreshTokens(String refreshToken) {
        Jwt jwt;
        try {
            jwt = jwtDecoder.decode(refreshToken);
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            throw JwtException.invalidToken(e.getMessage());
        }

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

        // ----------------------------------------------------------------
        // Rotation + reuse detection (OAuth BCP, RFC 9700 §2.2.2).
        // ----------------------------------------------------------------
        Instant now = Instant.now();
        String presentedHash = sha256Hex(refreshToken);

        RefreshTokenEntity stored = refreshTokenRepository
                .findByTokenHash(presentedHash)
                .orElseThrow(() -> {
                    // Token not in DB at all — either forged or from a
                    // pre-rotation era (never minted via issueFirstRefreshToken).
                    log.warn("[JWT] Refresh attempted with unknown token hash for {}", email);
                    return JwtException.invalidToken("Unknown refresh token");
                });

        if (stored.getRevokedAt() != null) {
            throw JwtException.invalidToken("Refresh token revoked");
        }
        if (stored.getExpiresAt().isBefore(now)) {
            throw JwtException.invalidToken("Refresh token expired");
        }
        if (stored.getUsedAt() != null) {
            // REUSE DETECTED. Kill the entire family so both the attacker
            // and the legitimate user lose their sessions simultaneously —
            // legitimate user will be prompted to log in again, which is
            // the expected OWASP-compliant fallback.
            int killed = refreshTokenRepository.revokeFamily(
                    stored.getFamilyId(),
                    "REUSE_DETECTED",
                    now
            );
            log.warn("[JWT] Refresh-token REUSE detected for user {}, family {} — {} rows revoked",
                    email, stored.getFamilyId(), killed);
            throw JwtException.invalidToken("Refresh token reuse detected");
        }

        // Normal rotation: mark this token consumed, issue a new pair,
        // persist the new refresh token row linked to the same family.
        stored.setUsedAt(now);
        refreshTokenRepository.save(stored);

        String newAccessToken = generateAccessToken(user, deviceIdentifier);
        String newRefreshToken = generateRefreshToken(user, deviceIdentifier);
        persistRotatedRefreshToken(
                user,
                deviceIdentifier,
                newRefreshToken,
                stored.getFamilyId(),
                stored.getTokenHash(),
                now
        );

        jwtLogger.logTokenRefresh(email);

        return authMapper.toAuthResponse(
                user,
                newAccessToken,
                newRefreshToken,
                jwtProperties.getAccessTokenExpirationSeconds()
        );
    }

    @Override
    @Transactional
    public String issueFirstRefreshToken(UserEntity user, String deviceIdentifier) {
        String rawToken = generateRefreshToken(user, deviceIdentifier);
        UUID familyId = UUID.randomUUID();
        persistRotatedRefreshToken(
                user,
                deviceIdentifier,
                rawToken,
                familyId,
                null, // first of the family — no parent
                Instant.now()
        );
        return rawToken;
    }

    @Override
    @Transactional
    public int revokeRefreshTokensForDevice(Long userId, String deviceIdentifier, String reason) {
        if (deviceIdentifier == null) return 0;
        return refreshTokenRepository.revokeByUserAndDevice(
                userId,
                deviceIdentifier,
                reason == null ? "LOGOUT" : reason,
                Instant.now()
        );
    }

    /**
     * Persist one row in the rotation table for a freshly-minted refresh
     * token. Shared by both {@code issueFirstRefreshToken} (first of its
     * family, parent = null) and the normal rotation path inside
     * {@code refreshTokens} (same family as presented token, parent =
     * presented hash).
     */
    private void persistRotatedRefreshToken(
            UserEntity user,
            String deviceIdentifier,
            String rawToken,
            UUID familyId,
            String parentHash,
            Instant now
    ) {
        long ttlSeconds = jwtProperties.getRefreshTokenExpirationSeconds();
        RefreshTokenEntity entity = RefreshTokenEntity.builder()
                .user(user)
                .deviceIdentifier(deviceIdentifier)
                .tokenHash(sha256Hex(rawToken))
                .familyId(familyId)
                .parentHash(parentHash)
                .issuedAt(now)
                .expiresAt(now.plusSeconds(ttlSeconds))
                .build();
        refreshTokenRepository.save(entity);
    }

    private static String sha256Hex(String value) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(bytes.length * 2);
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            // SHA-256 is a mandatory JRE algorithm, so this cannot happen
            // — fall back to a no-hash marker for robustness.
            throw new IllegalStateException("SHA-256 not available", e);
        }
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

    @Override
    public boolean isRefreshToken(String token) {
        try {
            var jwt = jwtDecoder.decode(token);
            return isRefreshTokenInternal(jwt);
        } catch (Exception e) {
            return false;
        }
    }

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