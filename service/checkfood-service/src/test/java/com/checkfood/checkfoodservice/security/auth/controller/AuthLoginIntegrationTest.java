package com.checkfood.checkfoodservice.security.auth.controller;

import com.checkfood.checkfoodservice.security.auth.dto.request.LoginRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class AuthLoginIntegrationTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("✅ Úspěšné přihlášení: Vrátí JWT tokeny a User data")
    void shouldLoginSuccessfully_WhenCredentialsAreCorrect() throws Exception {
        LoginRequest loginRequest = LoginRequest.builder()
                .email(TEST_EMAIL)
                .password(RAW_PASSWORD)
                .deviceIdentifier(UUID.randomUUID().toString())
                .deviceName("Integration Test Device")
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(loginRequest)))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").isNotEmpty())
                .andExpect(jsonPath("$.refreshToken").isNotEmpty())
                .andExpect(jsonPath("$.user.email").value(TEST_EMAIL))
                .andExpect(jsonPath("$.user.firstName").value("Jan"));
    }

    @Test
    @DisplayName("❌ Neúspěšné přihlášení: Špatné heslo")
    void shouldFailLogin_WhenPasswordIsWrong() throws Exception {
        LoginRequest loginRequest = LoginRequest.builder()
                .email(TEST_EMAIL)
                .password("WrongPassword123!")
                .deviceIdentifier(UUID.randomUUID().toString())
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(loginRequest)))
                .andDo(print())
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("❌ Neúspěšné přihlášení: Neexistující email")
    void shouldFailLogin_WhenUserDoesNotExist() throws Exception {
        LoginRequest loginRequest = LoginRequest.builder()
                .email("ghost@checkfood.cz")
                .password("AnyPassword")
                .deviceIdentifier(UUID.randomUUID().toString())
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("❌ Validace vstupu: Prázdný email nebo krátké heslo")
    void shouldReturnBadRequest_WhenInputIsInvalid() throws Exception {
        LoginRequest loginRequest = LoginRequest.builder()
                .email("invalid-email")
                .password("short")
                .deviceIdentifier("")
                .build();

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isBadRequest());
    }
}