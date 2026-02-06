package com.checkfood.checkfoodservice.security.auth.controller;

import com.checkfood.checkfoodservice.security.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.verify;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class AuthRegisterIntegrationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("✅ Registrace + Verifikace: Kompletní průchod (Happy Path)")
    void shouldRegisterAndVerifyUserSuccessfully() throws Exception {
        // 1. ARRANGE - Data pro registraci
        String newEmail = "waiting@checkfood.cz";
        RegisterRequest registerRequest = RegisterRequest.builder()
                .email(newEmail)
                .password("SuperPass123!")
                .confirmPassword("SuperPass123!")
                .firstName("Čekající")
                .lastName("Uživatel")
                .deviceIdentifier(UUID.randomUUID().toString())
                .deviceName("Android")
                .deviceType("ANDROID")
                .build();

        // 2. ACT - Volání registrace
        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(registerRequest)))
                .andDo(print())
                // Očekáváme 202 Accepted (ne 200 OK, nevrací tokeny)
                .andExpect(status().isAccepted());

        // 3. ASSERT - Kontrola stavu v databázi
        // Uživatel musí existovat, ale být neaktivní
        UserEntity user = userRepository.findByEmail(newEmail).orElseThrow();
        assertFalse(user.isEnabled(), "Uživatel by měl být po registraci neaktivní!");

        // Musí existovat verifikační token
        VerificationTokenEntity tokenEntity = verificationTokenRepository.findByToken(
                verificationTokenRepository.findAll().stream()
                        .filter(t -> t.getUser().getEmail().equals(newEmail))
                        .findFirst().orElseThrow().getToken()
        ).orElseThrow();

        // Ověříme, že se "odeslal" email (že se zavolala mockovaná služba)
        verify(emailService).sendVerificationEmail(anyString(), anyString());

        // 4. ACT - Verifikace účtu (kliknutí na link v emailu)
        mockMvc.perform(get("/api/auth/verify")
                        .param("token", tokenEntity.getToken()))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(org.hamcrest.Matchers.containsString("úspěšně aktivován")));

        // 5. ASSERT - Uživatel je nyní aktivní
        entityManager.clear(); // Refresh cache, abychom načetli aktuální stav z DB
        UserEntity activeUser = userRepository.findByEmail(newEmail).orElseThrow();
        assertTrue(activeUser.isEnabled(), "Uživatel by měl být po verifikaci aktivní!");

        // Token by měl být smazán
        assertTrue(verificationTokenRepository.findByToken(tokenEntity.getToken()).isEmpty());
    }

    @Test
    @DisplayName("⛔ Login před verifikací: Musí selhat s chybou účtu")
    void shouldDenyLogin_WhenAccountIsNotVerified() throws Exception {
        // 1. Vytvoříme ručně neaktivního uživatele
        UserEntity inactiveUser = UserEntity.builder()
                .email("inactive@checkfood.cz")
                .password(passwordEncoder.encode("Pass123!"))
                .firstName("Lazy")
                .lastName("Boy")
                .enabled(false) // <--- NEAKTIVNÍ
                .build();
        userRepository.save(inactiveUser);

        // 2. Zkusíme se přihlásit
        LoginRequest loginRequest = LoginRequest.builder()
                .email("inactive@checkfood.cz")
                .password("Pass123!")
                .deviceIdentifier(UUID.randomUUID().toString())
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(loginRequest)))
                .andDo(print())
                // Očekáváme 403 Forbidden nebo 401 Unauthorized se specifickou hláškou
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.code").value("AUTH_ACCOUNT_NOT_VERIFIED"));
    }

    @Test
    @DisplayName("❌ Verifikace: Neplatný token")
    void shouldFailVerification_WhenTokenIsInvalid() throws Exception {
        mockMvc.perform(get("/api/auth/verify")
                        .param("token", "invalid-token-123"))
                .andDo(print())
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("AUTH_TOKEN_INVALID"));
    }
}