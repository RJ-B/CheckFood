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
 * Implementace OAuth flow.
 *
 * Změny pro JDK 21:
 * - Odstraněny try-catch bloky pro logování chyb.
 * - Výjimky se propagují (nebo balí do OAuthException) a řeší je Handler.
 * - Logování pouze happy path (pokus, verifikace OK, login OK).
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
        // 1. Logování pokusu (Info)
        oauthLogger.logAuthenticationAttempt(request.getProvider());

        // 2. Verifikace u providera
        OAuthUserInfo userInfo;
        try {
            var client = oauthClientFactory.getClient(request.getProvider());
            userInfo = client.verifyAndGetUserInfo(request.getIdToken());
        } catch (IllegalArgumentException e) {
            // Factory nenašla klienta -> Nepodporovaný provider (Handler zaloguje)
            throw OAuthException.providerNotSupported(request.getProvider().toString());
        } catch (Exception e) {
            // Chyba knihovny nebo neplatný token (Handler zaloguje i s cause)
            throw OAuthException.invalidToken(e.getMessage());
        }

        // Logování úspěšné verifikace
        oauthLogger.logProviderVerificationSuccess(request.getProvider(), userInfo.getProviderUserId());

        // Kontrola dat
        if (userInfo.getEmail() == null || userInfo.getEmail().isBlank()) {
            throw OAuthException.userDataMissing(request.getProvider().toString());
        }

        // Doplnění jména
        if (isNameMissing(userInfo)) {
            userInfo = enrichUserInfoWithRequestData(userInfo, request);
        }

        // 3. Získání/Vytvoření uživatele
        var user = oauthUserService.getOrCreateUser(userInfo);

        // 4. Registrace zařízení
        // Zde nespouštíme chybu, pokud selže statistika zařízení (silent fail),
        // ale ani nelogujeme chybu (clean logs).
        String finalDeviceIdentifier = request.getDeviceIdentifier();
        try {
            var device = registerOrUpdateDevice(user, request);
            if (device != null) {
                finalDeviceIdentifier = device.getDeviceIdentifier();
            }
        } catch (Exception ignored) {
            // Ignorujeme chybu zařízení, nechceme blokovat login
        }

        // 5. Generování tokenů
        try {
            String accessToken = jwtService.generateAccessToken(user, finalDeviceIdentifier);
            String refreshToken = jwtService.generateRefreshToken(user, finalDeviceIdentifier);

            oauthLogger.logSuccessfulOAuthLogin(user.getEmail(), request.getProvider());

            return oauthMapper.toResponse(accessToken, refreshToken, accessTokenExpiration, user);
        } catch (Exception e) {
            throw OAuthException.internalError("Chyba při generování tokenů.", e);
        }
    }

    private DeviceEntity registerOrUpdateDevice(UserEntity user, OAuthLoginRequest dto) {
        if (dto.getDeviceIdentifier() == null) return null;

        var device = deviceService.findByIdentifier(dto.getDeviceIdentifier())
                .orElseGet(() -> {
                    var newDevice = new DeviceEntity();
                    newDevice.setDeviceIdentifier(dto.getDeviceIdentifier());
                    return newDevice;
                });

        device.setUser(user);
        device.setDeviceName(dto.getDeviceName() != null ? dto.getDeviceName() : "Neznámé OAuth zařízení");
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

    private boolean isNameMissing(OAuthUserInfo userInfo) {
        return userInfo.getFirstName() == null || userInfo.getFirstName().isBlank();
    }

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