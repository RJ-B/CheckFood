package com.checkfood.checkfoodservice.security.module.mfa;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.mfa.entity.MfaBackupCodeEntity;
import com.checkfood.checkfoodservice.security.module.mfa.entity.MfaSecretEntity;
import com.checkfood.checkfoodservice.security.module.mfa.repository.MfaBackupCodeRepository;
import com.checkfood.checkfoodservice.security.module.mfa.repository.MfaSecretRepository;
import com.checkfood.checkfoodservice.security.module.mfa.util.TotpGenerator;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@DisplayName("MfaController integration tests")
class MfaIntegrationTest extends BaseAuthIntegrationTest {

    @Autowired
    private MfaSecretRepository mfaSecretRepository;

    @Autowired
    private MfaBackupCodeRepository mfaBackupCodeRepository;

    @Autowired
    private TotpGenerator totpGenerator;

    @BeforeEach
    void cleanMfa() {
        mfaBackupCodeRepository.deleteAll();
        mfaSecretRepository.deleteAll();
    }

    // =========================================================================
    // POST /api/mfa/setup/start
    // =========================================================================

    // GAP: Base32SecretGenerator.encodeBase32() strips '+', '/', '=' from Base64 output then
    //      calls .substring(0, 32) — but the stripped string may be shorter than 32 chars,
    //      causing StringIndexOutOfBoundsException → HTTP 500.
    //      Fix: use a proper Base32 library (e.g. Apache Commons Codec) or loop/pad until
    //      the output is at least 32 chars before taking the substring.
    @Test
    @DisplayName("POST /setup/start — authenticated → 200 with qrPayload and secret")
    void should_returnSetupStart_when_authenticated() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.qrPayload").isNotEmpty())
                .andExpect(jsonPath("$.secret").isNotEmpty());
    }

    @Test
    @DisplayName("POST /setup/start — anonymous → 401")
    void should_return401_when_setupStart_anonymous() throws Exception {
        mockMvc.perform(post("/api/mfa/setup/start"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /setup/start — second call when secret already exists → 4xx (conflict)")
    void should_return4xx_when_setupStart_alreadyExists() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /setup/start — secret entity persisted with enabled=false")
    void should_persistSecret_with_enabledFalse() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        MfaSecretEntity secret = mfaSecretRepository.findByUserId(user.getId()).orElseThrow();
        assertThat(secret.isEnabled()).isFalse();
        assertThat(secret.getSecret()).isNotBlank();
    }

    // =========================================================================
    // POST /api/mfa/setup/verify
    // =========================================================================

    @Test
    @DisplayName("POST /setup/verify — valid TOTP code → 200 and MFA enabled")
    void should_enableMfa_when_validTotpCode() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        MfaSecretEntity secretEntity = mfaSecretRepository.findByUserId(user.getId()).orElseThrow();
        String validCode = totpGenerator.generate(secretEntity.getSecret());

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"" + validCode + "\"}"))
                .andExpect(status().isOk());

        MfaSecretEntity updated = mfaSecretRepository.findByUserId(user.getId()).orElseThrow();
        assertThat(updated.isEnabled()).isTrue();
        assertThat(updated.getEnabledAt()).isNotNull();
    }

    @Test
    @DisplayName("POST /setup/verify — invalid code → 4xx")
    void should_return4xx_when_setupVerify_invalidCode() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"000000\"}"))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /setup/verify — blank code → 400")
    void should_return400_when_setupVerify_blankCode() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"\"}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /setup/verify — missing code field → 400")
    void should_return400_when_setupVerify_missingCode() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /setup/verify — generates 8 backup codes after successful setup")
    void should_generate8BackupCodes_after_setupVerify() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        String validCode = totpGenerator.generate(
                mfaSecretRepository.findByUserId(user.getId()).orElseThrow().getSecret());

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"" + validCode + "\"}"))
                .andExpect(status().isOk());

        List<MfaBackupCodeEntity> codes = mfaBackupCodeRepository.findByUserIdAndUsedFalse(user.getId());
        assertThat(codes).hasSize(8);
        assertThat(codes).allMatch(c -> !c.isUsed());
    }

    @Test
    @DisplayName("POST /setup/verify — verify when setup not started → 4xx")
    void should_return4xx_when_setupVerify_noSetupStarted() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"123456\"}"))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /setup/verify — anonymous → 401")
    void should_return401_when_setupVerify_anonymous() throws Exception {
        mockMvc.perform(post("/api/mfa/setup/verify")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"123456\"}"))
                .andExpect(status().isUnauthorized());
    }

    // =========================================================================
    // POST /api/mfa/challenge/verify
    // =========================================================================

    @Test
    @DisplayName("POST /challenge/verify — valid TOTP after MFA enabled → success response")
    void should_returnSuccess_when_challengeWithValidTotp() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        String validCode = totpGenerator.generate(
                mfaSecretRepository.findByUserId(user.getId()).orElseThrow().getSecret());

        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"" + validCode + "\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    @DisplayName("POST /challenge/verify — invalid code → 4xx")
    void should_return4xx_when_challengeWithInvalidCode() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"000000\"}"))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /challenge/verify — backup code single-use: second use returns 4xx")
    void should_rejectBackupCode_when_usedTwice() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        // Inject a known backup code hash
        String rawCode = "TESTCODE12";
        MfaBackupCodeEntity backupCode = new MfaBackupCodeEntity();
        backupCode.setUser(user);
        backupCode.setCodeHash(passwordEncoder.encode(rawCode));
        backupCode.setUsed(false);
        mfaBackupCodeRepository.save(backupCode);

        // First use — must succeed
        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"" + rawCode + "\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        // Second use of same code — must fail
        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"" + rawCode + "\"}"))
                .andExpect(status().is4xxClientError());

        // Verify DB flag
        MfaBackupCodeEntity used = mfaBackupCodeRepository.findById(backupCode.getId()).orElseThrow();
        assertThat(used.isUsed()).isTrue();
    }

    @Test
    @DisplayName("POST /challenge/verify — MFA not enabled → 4xx")
    void should_return4xx_when_challengeVerify_mfaNotEnabled() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"123456\"}"))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /challenge/verify — blank code → 400")
    void should_return400_when_challengeVerify_blankCode() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"\"}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /challenge/verify — anonymous → 401")
    void should_return401_when_challengeVerify_anonymous() throws Exception {
        mockMvc.perform(post("/api/mfa/challenge/verify")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"123456\"}"))
                .andExpect(status().isUnauthorized());
    }

    // =========================================================================
    // POST /api/mfa/disable
    // =========================================================================

    @Test
    @DisplayName("POST /disable — valid password when MFA enabled → 200 and secret removed")
    void should_disableMfa_when_correctPassword() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        assertThat(mfaSecretRepository.findByUserId(user.getId())).isPresent();

        mockMvc.perform(post("/api/mfa/disable")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"password\":\"" + TEST_PASSWORD + "\"}"))
                .andExpect(status().isOk());

        assertThat(mfaSecretRepository.findByUserId(user.getId())).isEmpty();
        assertThat(mfaBackupCodeRepository.findByUserIdAndUsedFalse(user.getId())).isEmpty();
    }

    @Test
    @DisplayName("POST /disable — wrong password → 4xx")
    void should_return4xx_when_disable_wrongPassword() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        mockMvc.perform(post("/api/mfa/disable")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"password\":\"WrongPassword!\"}"))
                .andExpect(status().is4xxClientError());
    }

    @Test
    @DisplayName("POST /disable — blank password → 400")
    void should_return400_when_disable_blankPassword() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(post("/api/mfa/disable")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"password\":\"\"}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /disable — anonymous → 401")
    void should_return401_when_disable_anonymous() throws Exception {
        mockMvc.perform(post("/api/mfa/disable")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"password\":\"" + TEST_PASSWORD + "\"}"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /disable — idempotent: second disable call does not throw 500")
    void should_not500_when_disableMfa_twice() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        mockMvc.perform(post("/api/mfa/disable")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"password\":\"" + TEST_PASSWORD + "\"}"))
                .andExpect(status().isOk());

        // Second call — MFA already gone, still should not 500
        mockMvc.perform(post("/api/mfa/disable")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"password\":\"" + TEST_PASSWORD + "\"}"))
                .andExpect(status().is4xxClientError());
    }

    // =========================================================================
    // GET /api/mfa/status
    // =========================================================================

    @Test
    @DisplayName("GET /status — returns false when MFA not set up")
    void should_returnFalse_when_mfaNotEnabled() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/mfa/status")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.enabled").value(false));
    }

    @Test
    @DisplayName("GET /status — returns true after MFA fully enabled")
    void should_returnTrue_when_mfaEnabled() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        enableMfaForUser(token);

        mockMvc.perform(get("/api/mfa/status")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.enabled").value(true));
    }

    @Test
    @DisplayName("GET /status — anonymous → 401")
    void should_return401_when_status_anonymous() throws Exception {
        mockMvc.perform(get("/api/mfa/status"))
                .andExpect(status().isUnauthorized());
    }

    // =========================================================================
    // Private helpers
    // =========================================================================

    private void enableMfaForUser(String token) throws Exception {
        mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isOk());

        UserEntity user = userRepository.findByEmail(TEST_EMAIL).orElseThrow();
        String code = totpGenerator.generate(
                mfaSecretRepository.findByUserId(user.getId()).orElseThrow().getSecret());

        mockMvc.perform(post("/api/mfa/setup/verify")
                        .header("Authorization", "Bearer " + token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"code\":\"" + code + "\"}"))
                .andExpect(status().isOk());
    }
}
