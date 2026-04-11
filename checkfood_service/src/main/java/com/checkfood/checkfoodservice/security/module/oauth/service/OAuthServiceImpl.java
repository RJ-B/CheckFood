package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;
import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.logging.OAuthLogger;
import lombok.extern.slf4j.Slf4j;
import com.checkfood.checkfoodservice.security.module.oauth.mapper.OAuthMapper;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthClientFactory;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.DeviceService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

/**
 * Implementace OAuth autentizačního flow zahrnující ověření tokenu, JIT provisioning uživatele,
 * registraci zařízení a vydání JWT tokenů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class OAuthServiceImpl implements OAuthService {

    private final OAuthClientFactory oauthClientFactory;
    private final OAuthUserService oauthUserService;
    private final DeviceService deviceService;
    private final JwtService jwtService;
    private final OAuthMapper oauthMapper;
    private final OAuthLogger oauthLogger;
    private final HttpServletRequest httpServletRequest;
    private final OAuthReplayGuard replayGuard;

    @Value("${security.jwt.access-token-expiration-seconds:3600}")
    private Long accessTokenExpiration;

    @Override
    @Transactional
    public AuthResponse login(OAuthLoginRequest request) {
        oauthLogger.logAuthenticationAttempt(request.getProvider());

        // Replay guard — reject the same ID token being presented twice
        // within its ~1h lifetime. Google/Apple sign the token for single
        // user/audience but don't enforce single-use semantics themselves.
        if (!replayGuard.acceptIfFirstTime(request.getIdToken())) {
            throw OAuthException.invalidToken("ID token replay detected");
        }

        OAuthUserInfo userInfo;
        try {
            var client = oauthClientFactory.getClient(request.getProvider());
            userInfo = client.verifyAndGetUserInfo(request.getIdToken());
        } catch (IllegalArgumentException e) {
            throw OAuthException.providerNotSupported(request.getProvider().toString());
        } catch (Exception e) {
            throw OAuthException.invalidToken(e.getMessage());
        }

        oauthLogger.logProviderVerificationSuccess(request.getProvider(), userInfo.getProviderUserId());

        if (userInfo.getEmail() == null || userInfo.getEmail().isBlank()) {
            throw OAuthException.userDataMissing(request.getProvider().toString());
        }

        if (isNameMissing(userInfo)) {
            userInfo = enrichUserInfoWithRequestData(userInfo, request);
        }

        var user = oauthUserService.getOrCreateUser(userInfo);

        String finalDeviceIdentifier = request.getDeviceIdentifier();
        try {
            var device = registerOrUpdateDevice(user, request);
            if (device != null) {
                finalDeviceIdentifier = device.getDeviceIdentifier();
            }
        } catch (Exception e) {
            log.warn("[OAuth] Chyba při registraci/aktualizaci zařízení pro uživatele {}: {}",
                    user.getEmail(), e.getMessage());
        }

        try {
            String accessToken = jwtService.generateAccessToken(user, finalDeviceIdentifier);
            // Use issueFirstRefreshToken so the row is persisted in the
            // rotation table and future /refresh calls can rotate it.
            String refreshToken = jwtService.issueFirstRefreshToken(user, finalDeviceIdentifier);

            oauthLogger.logSuccessfulOAuthLogin(user.getEmail(), request.getProvider());

            return oauthMapper.toResponse(accessToken, refreshToken, accessTokenExpiration, user);
        } catch (Exception e) {
            throw OAuthException.internalError("Chyba pri generovani tokenu.", e);
        }
    }

    /**
     * Zaregistruje nebo aktualizuje záznam zařízení po úspěšném OAuth přihlášení.
     *
     * @param user přihlášený uživatel
     * @param dto  OAuth požadavek obsahující metadata zařízení
     * @return uložená entita zařízení nebo {@code null} pokud deviceIdentifier není uveden
     */
    private DeviceEntity registerOrUpdateDevice(UserEntity user, OAuthLoginRequest dto) {
        if (dto.getDeviceIdentifier() == null) return null;

        var device = deviceService.findByIdentifier(dto.getDeviceIdentifier())
                .orElseGet(() -> {
                    var newDevice = new DeviceEntity();
                    newDevice.setDeviceIdentifier(dto.getDeviceIdentifier());
                    return newDevice;
                });

        device.setUser(user);
        device.setDeviceName(dto.getDeviceName() != null ? dto.getDeviceName() : "Nezname OAuth zarizeni");
        device.setDeviceType(dto.getDeviceType() != null ? dto.getDeviceType() : "UNKNOWN");
        device.setLastLogin(LocalDateTime.now());

        if (httpServletRequest != null) {
            try {
                device.setLastIpAddress(httpServletRequest.getRemoteAddr());
                device.setUserAgent(httpServletRequest.getHeader("User-Agent"));
            } catch (Exception e) {
                log.warn("[OAuth] Nelze načíst IP/User-Agent pro zařízení: {}", e.getMessage());
            }
        }

        return deviceService.save(device);
    }

    /**
     * Zjistí, zda chybí křestní jméno v datech uživatele z OAuth providera.
     *
     * @param userInfo data uživatele z providera
     * @return {@code true} pokud křestní jméno chybí nebo je prázdné
     */
    private boolean isNameMissing(OAuthUserInfo userInfo) {
        return userInfo.getFirstName() == null || userInfo.getFirstName().isBlank();
    }

    /**
     * Doplní chybějící jméno uživatele z dat přijatých v OAuth požadavku (použitelné pro Apple).
     *
     * @param info    data uživatele z providera
     * @param request původní OAuth požadavek
     * @return obohacená data uživatele
     */
    private OAuthUserInfo enrichUserInfoWithRequestData(OAuthUserInfo info, OAuthLoginRequest request) {
        return OAuthUserInfo.builder()
                .providerUserId(info.getProviderUserId())
                .email(info.getEmail())
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .profileImageUrl(info.getProfileImageUrl())
                .providerType(info.getProviderType())
                .build();
    }
}