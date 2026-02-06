package com.checkfood.checkfoodservice.security.auth.controller;

import com.checkfood.checkfoodservice.security.auth.dto.request.RefreshRequest;
import com.checkfood.checkfoodservice.security.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity; // Import nutný
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.time.LocalDateTime;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class AuthTokenIntegrationTest extends BaseAuthIntegrationTest {

    // Definujeme konstantu pro User-Agent, aby byla v DB i Requestu stejná
    private static final String TEST_USER_AGENT = "CheckFood-Test-Agent/1.0";

    @Test
    @DisplayName("⛔ Expirovaný token: Přístup k chráněnému zdroji je zamítnut (401)")
    void shouldReturn401_WhenAccessTokenIsExpired() throws Exception {
        String expiredAccessToken = generateExpiredToken(testUser);

        mockMvc.perform(get("/api/auth/me")
                        .header("Authorization", "Bearer " + expiredAccessToken)
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(print())
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.error").value("Unauthorized"));
    }

    @Test
    @DisplayName("🔄 Refresh Flow: Kompletní simulace obnovy tokenů a přístupu k API")
    void shouldRefreshTokensAndAllowAccess_WhenRefreshTokenIsValid() throws Exception {
        // 1. PŘÍPRAVA (ARRANGE)
        String deviceId = UUID.randomUUID().toString();

        // Uložíme zařízení s explicitním User-Agentem
        DeviceEntity device = DeviceEntity.builder()
                .deviceIdentifier(deviceId)
                .user(testUser)
                .deviceName("Test Device")
                .userAgent(TEST_USER_AGENT) // <--- DŮLEŽITÉ: Musí se shodovat s hlavičkou requestu
                .lastActiveAt(LocalDateTime.now())
                .build();
        deviceRepository.save(device);

        // --- CRITICAL FIX: Zápis do DB a vyčištění cache ---
        entityManager.flush();
        entityManager.clear();
        // --------------------------------------------------

        // Načteme uživatele ZNOVU z databáze.
        // Tím zajistíme, že 'freshUser' je "čistý" objekt, o kterém Hibernate ví, že musí dotáhnout relace.
        UserEntity freshUser = userRepository.findById(testUser.getId()).orElseThrow();

        // 2. Generování Refresh tokenu (použijeme freshUsera)
        String validRefreshToken = jwtService.generateRefreshToken(freshUser);

        RefreshRequest refreshRequest = RefreshRequest.builder()
                .refreshToken(validRefreshToken)
                .deviceIdentifier(deviceId)
                .build();

        // 3. AKCE (ACT) - Volání refresh endpointu
        var result = mockMvc.perform(post("/api/auth/refresh")
                        .header("User-Agent", TEST_USER_AGENT) // <--- DŮLEŽITÉ: Posíláme hlavičku
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(refreshRequest)))
                .andDo(print())
                .andExpect(status().isOk()) // Teď už musí projít (200 OK)
                .andExpect(jsonPath("$.accessToken").isNotEmpty())
                .andReturn();

        // 4. Použití nového tokenu (RETRY)
        String responseJson = result.getResponse().getContentAsString();
        String newAccessToken = objectMapper.readTree(responseJson).get("accessToken").asText();

        mockMvc.perform(get("/api/auth/me")
                        .header("Authorization", "Bearer " + newAccessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(TEST_EMAIL));
    }

    @Test
    @DisplayName("🛡️ Security: Refresh Token nelze použít z jiného zařízení")
    void shouldBlockRefresh_WhenDeviceDoesNotMatch() throws Exception {
        String realDeviceId = UUID.randomUUID().toString();
        DeviceEntity device = DeviceEntity.builder()
                .deviceIdentifier(realDeviceId)
                .user(testUser)
                .userAgent(TEST_USER_AGENT)
                .lastActiveAt(LocalDateTime.now())
                .build();
        deviceRepository.save(device);

        entityManager.flush();
        entityManager.clear();

        UserEntity freshUser = userRepository.findById(testUser.getId()).orElseThrow();
        String validRefreshToken = jwtService.generateRefreshToken(freshUser);

        // Útočník s jiným ID
        RefreshRequest hackersRequest = RefreshRequest.builder()
                .refreshToken(validRefreshToken)
                .deviceIdentifier("HACKER-DEVICE-ID")
                .build();

        mockMvc.perform(post("/api/auth/refresh")
                        .header("User-Agent", TEST_USER_AGENT)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(hackersRequest)))
                .andExpect(status().isUnauthorized());
    }
}