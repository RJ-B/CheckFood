package com.checkfood.checkfoodservice.security.module.jwt.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
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
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.stereotype.Service;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Implementace JWT servisu využívající Spring Security OAuth2 (Nimbus).
 * Zajišťuje bezpečné generování a validaci Access a Refresh tokenů s podporou HS256 algoritmu.
 * Implementuje rotaci tokenů pro zvýšení bezpečnosti.
 *
 * @see JwtService
 * @see JwtProperties
 * @see JwtEncoder
 * @see JwtDecoder
 */
@Service
@RequiredArgsConstructor
public class JwtServiceImpl implements JwtService {

    private static final String CLAIM_TYPE = "type";
    private static final String TYPE_ACCESS = "ACCESS";
    private static final String TYPE_REFRESH = "REFRESH";

    private final JwtProperties jwtProperties;
    private final JwtLogger jwtLogger;
    private final UserService userService;
    private final AuthMapper authMapper;
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;

    private JwtEncoder jwtEncoder;
    private JwtDecoder jwtDecoder;

    /**
     * Inicializuje JWT encoder a decoder po vytvoření beany.
     * Vytvoří symetrický secret key z konfigurace a nastaví HS256 algoritmus.
     */
    @PostConstruct
    private void init() {
        byte[] keyBytes = jwtProperties.getSecret().getBytes(StandardCharsets.UTF_8);
        SecretKeySpec secretKey = new SecretKeySpec(keyBytes, "HmacSHA256");

        this.jwtEncoder = new NimbusJwtEncoder(new ImmutableSecret<>(secretKey));
        this.jwtDecoder = NimbusJwtDecoder.withSecretKey(secretKey).build();
    }

    /**
     * Vygeneruje nový access token pro uživatele.
     * Token obsahuje email, role a typ tokenu s krátkou dobou platnosti.
     *
     * @param user uživatel, pro kterého se generuje token
     * @return zakódovaný JWT access token
     * @throws JwtException při chybě generování tokenu
     */
    @Override
    public String generateAccessToken(UserEntity user) {
        try {
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

            String token = encode(claims);
            jwtLogger.logTokenGenerated(user.getEmail(), "access");
            return token;
        } catch (Exception e) {
            jwtLogger.logAuthenticationError("Chyba při generování access tokenu: " + e.getMessage());
            throw JwtException.generationError(e.getMessage());
        }
    }

    /**
     * Vygeneruje nový refresh token pro uživatele.
     * Token obsahuje pouze email a typ tokenu s dlouhou dobou platnosti.
     *
     * @param user uživatel, pro kterého se generuje token
     * @return zakódovaný JWT refresh token
     * @throws JwtException při chybě generování tokenu
     */
    @Override
    public String generateRefreshToken(UserEntity user) {
        try {
            Instant now = Instant.now();
            long expiry = jwtProperties.getRefreshTokenExpirationSeconds();

            JwtClaimsSet claims = JwtClaimsSet.builder()
                    .issuer(jwtProperties.getIssuer())
                    .issuedAt(now)
                    .expiresAt(now.plusSeconds(expiry))
                    .subject(user.getEmail())
                    .claim(CLAIM_TYPE, TYPE_REFRESH)
                    .build();

            String token = encode(claims);
            jwtLogger.logTokenGenerated(user.getEmail(), "refresh");
            return token;
        } catch (Exception e) {
            jwtLogger.logAuthenticationError("Chyba při generování refresh tokenu: " + e.getMessage());
            throw JwtException.generationError(e.getMessage());
        }
    }

    /**
     * Extrahuje email (subject) z JWT tokenu.
     *
     * @param token JWT token
     * @return email uživatele nebo null při chybě
     */
    @Override
    public String extractEmail(String token) {
        try {
            Jwt jwt = jwtDecoder.decode(token);
            return jwt.getSubject();
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            jwtLogger.logAuthenticationError("Nepodařilo se extrahovat email z tokenu: " + e.getMessage());
            return null;
        }
    }

    /**
     * Validuje JWT token bez kontextu uživatele.
     * Kontroluje pouze základní platnost tokenu (podpis, expirace).
     *
     * @param token JWT token k validaci
     * @return true pokud je token technicky platný, jinak false
     */
    @Override
    public boolean validateToken(String token) {
        try {
            jwtDecoder.decode(token);
            return true;
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            jwtLogger.logInvalidToken("", e.getMessage());
            return false;
        }
    }

    /**
     * Validuje JWT token vůči konkrétnímu uživateli.
     * Kontroluje email, expiraci a typ tokenu (musí být ACCESS token).
     *
     * @param token JWT token k validaci
     * @param user uživatel, vůči kterému se token validuje
     * @return true pokud je token platný pro daného uživatele, jinak false
     */
    @Override
    public boolean isTokenValid(String token, UserEntity user) {
        try {
            Jwt jwt = jwtDecoder.decode(token);
            String email = jwt.getSubject();

            String type = jwt.getClaim(CLAIM_TYPE);
            boolean isAccessToken = TYPE_ACCESS.equals(type);

            boolean isEmailValid = email.equals(user.getEmail());
            boolean isNotExpired = jwt.getExpiresAt() != null && jwt.getExpiresAt().isAfter(Instant.now());

            boolean isValid = isEmailValid && isNotExpired && isAccessToken;
            jwtLogger.logTokenValidation(user.getEmail(), isValid);

            return isValid;
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            jwtLogger.logTokenValidation(user.getEmail(), false);
            return false;
        }
    }

    /**
     * Vrací nakonfigurovanou dobu platnosti access tokenu v sekundách.
     *
     * @return doba platnosti v sekundách
     */
    @Override
    public Long getAccessTokenExpirationSeconds() {
        return jwtProperties.getAccessTokenExpirationSeconds();
    }

    /**
     * Obnoví access a refresh tokeny pomocí platného refresh tokenu.
     * Implementuje rotaci tokenů - starý refresh token je nahrazen novým.
     * Validuje typ tokenu, expiraci a stav uživatelského účtu.
     * Operace je auditována pro bezpečnostní účely.
     *
     * @param refreshToken platný refresh token
     * @return nová autentizační odpověď s novými tokeny a uživatelskými daty
     * @throws JwtException pokud je refresh token neplatný, expirovaný nebo uživatel není aktivní
     */
    @Override
    public AuthResponse refreshTokens(String refreshToken) {
        Jwt jwt;

        try {
            jwt = jwtDecoder.decode(refreshToken);
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            jwtLogger.logInvalidToken("", "Neplatný refresh token");
            publishAudit(null, AuditStatus.FAILED);
            throw JwtException.invalidToken();
        }

        if (!isRefreshToken(jwt)) {
            jwtLogger.logInvalidToken("", "Token není refresh token");
            publishAudit(null, AuditStatus.FAILED);
            throw JwtException.invalidToken();
        }

        String email = jwt.getSubject();
        UserEntity user = userService.findByEmail(email);

        if (!user.isEnabled()) {
            jwtLogger.logInvalidToken(email, "Uživatel není aktivní");
            publishAudit(user.getId(), AuditStatus.BLOCKED);
            throw JwtException.invalidToken();
        }

        jwtLogger.logTokenRefresh(email);
        publishAudit(user.getId(), AuditStatus.SUCCESS);

        return buildAuthResponse(user);
    }

    /**
     * Ověří, zda je daný JWT token refresh token.
     * Kontroluje type claim v dekódovaném tokenu.
     *
     * @param token JWT token k ověření
     * @return true pokud je to refresh token, jinak false
     */
    @Override
    public boolean isRefreshToken(String token) {
        try {
            Jwt jwt = jwtDecoder.decode(token);
            return isRefreshToken(jwt);
        } catch (org.springframework.security.oauth2.jwt.JwtException e) {
            return false;
        }
    }

    /**
     * Interní metoda pro ověření typu tokenu z dekódovaného JWT.
     *
     * @param jwt dekódovaný JWT token
     * @return true pokud je to refresh token, jinak false
     */
    private boolean isRefreshToken(Jwt jwt) {
        String type = jwt.getClaim(CLAIM_TYPE);
        return TYPE_REFRESH.equals(type);
    }

    /**
     * Sestaví kompletní autentizační odpověď s novými tokeny.
     * Generuje nový pár access a refresh tokenů pro uživatele.
     *
     * @param user uživatel, pro kterého se generují tokeny
     * @return autentizační odpověď s tokeny a uživatelskými daty
     */
    private AuthResponse buildAuthResponse(UserEntity user) {
        String newAccessToken = generateAccessToken(user);
        String newRefreshToken = generateRefreshToken(user);
        Long expiresIn = getAccessTokenExpirationSeconds();

        return authMapper.toAuthResponse(user, newAccessToken, newRefreshToken, expiresIn);
    }

    /**
     * Publikuje auditní událost pro refresh token operaci.
     *
     * @param userId ID uživatele (null pro anonymní pokusy)
     * @param status výsledek operace
     */
    private void publishAudit(Long userId, AuditStatus status) {
        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        userId,
                        AuditAction.REFRESH_TOKEN,
                        status,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }

    /**
     * Interní metoda pro zakódování JWT claims do tokenu.
     * Používá HS256 algoritmus pro podpis.
     *
     * @param claims JWT claims k zakódování
     * @return zakódovaný token jako string
     */
    private String encode(JwtClaimsSet claims) {
        JwsHeader header = JwsHeader.with(MacAlgorithm.HS256).build();
        JwtEncoderParameters params = JwtEncoderParameters.from(header, claims);
        return jwtEncoder.encode(params).getTokenValue();
    }
}