package com.checkfood.checkfoodservice.security.module.auth.controller;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.repository.PasswordResetTokenRepository;
import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Web-layer slice test for {@link AuthController}.
 *
 * <p>Uses {@code @WebMvcTest} so we only boot the web MVC stack — no DB,
 * no full application context. Runs in ~2 seconds vs. ~30 seconds for
 * a full {@code BaseAuthIntegrationTest} subclass, which makes it the
 * right place for "does validation reject this payload" checks that
 * don't need real persistence.
 *
 * <p>Spring Security filters are disabled via {@code addFilters = false}
 * because the controller mounts under {@code /api/auth/**} which the
 * production config already permits anonymously, and we do not want
 * the whole SecurityConfig graph (JwtService, UserDetailsService, key
 * loaders, OAuth replay guard, …) to autowire into a slice test.
 *
 * <p>Rate-limit annotations are no-ops here because the aspect lives
 * outside the {@code @WebMvcTest} bean scope — that is intentional, the
 * rate-limit layer has its own integration tests.
 */
@WebMvcTest(controllers = AuthController.class)
@AutoConfigureMockMvc(addFilters = false)
class AuthControllerWebMvcTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    @MockitoBean private AuthService authService;
    @MockitoBean private PasswordResetTokenRepository passwordResetTokenRepository;

    private RegisterRequest validRegister;
    private LoginRequest validLogin;

    @BeforeEach
    void setUp() {
        validRegister = new RegisterRequest();
        validRegister.setFirstName("Ada");
        validRegister.setLastName("Tester");
        validRegister.setEmail("ada@checkfood.test");
        validRegister.setPassword("SafePass1234!");

        validLogin = LoginRequest.builder()
                .email("ada@checkfood.test")
                .password("SafePass1234!")
                .deviceIdentifier("dev-ada-1")
                .deviceName("Pixel 8")
                .deviceType("ANDROID")
                .build();
    }

    @Test
    @DisplayName("POST /api/auth/register returns 202 and calls service")
    void registerHappyPath() throws Exception {
        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(validRegister)))
                .andExpect(status().isAccepted());

        verify(authService).register(any(RegisterRequest.class));
    }

    @Test
    @DisplayName("POST /api/auth/register rejects malformed email at the validation layer")
    void registerRejectsMalformedEmail() throws Exception {
        validRegister.setEmail("not-an-email");

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(validRegister)))
                .andExpect(status().isBadRequest());

        // The service MUST NOT be called when validation fails, otherwise
        // we'd be enumerating accounts / running password hashing on junk.
        verify(authService, never()).register(any());
    }

    @Test
    @DisplayName("POST /api/auth/register rejects short password")
    void registerRejectsShortPassword() throws Exception {
        validRegister.setPassword("short");

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(validRegister)))
                .andExpect(status().isBadRequest());

        verify(authService, never()).register(any());
    }

    @Test
    @DisplayName("POST /api/auth/login returns 200 with access token")
    void loginHappyPath() throws Exception {
        AuthResponse response = AuthResponse.builder()
                .accessToken("fake-access-token")
                .refreshToken("fake-refresh-token")
                .user(UserResponse.builder()
                        .id(1L)
                        .email("ada@checkfood.test")
                        .firstName("Ada")
                        .lastName("Tester")
                        .build())
                .build();
        given(authService.login(any(LoginRequest.class))).willReturn(response);

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(validLogin)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.accessToken").value("fake-access-token"))
                .andExpect(jsonPath("$.refreshToken").value("fake-refresh-token"))
                .andExpect(jsonPath("$.user.email").value("ada@checkfood.test"));
    }

    @Test
    @DisplayName("POST /api/auth/login requires deviceIdentifier — missing one → 400")
    void loginRejectsMissingDeviceIdentifier() throws Exception {
        validLogin.setDeviceIdentifier(null);

        mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(validLogin)))
                .andExpect(status().isBadRequest());

        verify(authService, never()).login(any());
    }
}
