package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;
import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.logging.OAuthLogger;
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

    @Value("${security.jwt.access-token-expiration-seconds:3600}")
    private Long accessTokenExpiration;

    @Override
    @Transactional
    public AuthResponse login(OAuthLoginRequest request) {
        oauthLogger.logAuthenticationAttempt(request.getProvider());

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
        } catch (Exception ignored) {
        }

        try {
            String accessToken = jwtService.generateAccessToken(user, finalDeviceIdentifier);
            String refreshToken = jwtService.generateRefreshToken(user, finalDeviceIdentifier);

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
            } catch (Exception ignored) {}
        }

        return deviceService.save(device);
    }

    /**
     * Zjistí, zda chybí křestní jméno v datech uživatele z OAuth poskytovatele.
     *
     * @param userInfo data uživatele z poskytovatele
     * @return {@code true} pokud křestní jméno chybí nebo je prázdné
     */
    private boolean isNameMissing(OAuthUserInfo userInfo) {
        return userInfo.getFirstName() == null || userInfo.getFirstName().isBlank();
    }

    /**
     * Doplní chybějící jméno uživatele z dat přijatých v OAuth požadavku (použitelné pro Apple).
     *
     * @param info    data uživatele z poskytovatele
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