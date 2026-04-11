package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;
import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.audit.repository.AuditLogRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.TestPropertySource;

import java.util.HashSet;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for AuditController (/api/admin/audit).
 * Note: security.audit.enabled=true overrides the test profile default (false)
 * so audit logging is exercised in these tests.
 */
@TestPropertySource(properties = "security.audit.enabled=true")
@DisplayName("AuditController integration tests")
class AuditIntegrationTest extends BaseAuthIntegrationTest {

    @Autowired
    private AuditLogRepository auditLogRepository;

    @BeforeEach
    void cleanAudit() {
        auditLogRepository.deleteAll();
    }

    // =========================================================================
    // GET /api/admin/audit
    // =========================================================================

    @Test
    @DisplayName("GET /api/admin/audit — anonymous → 401")
    void should_return401_when_getAllAudit_anonymous() throws Exception {
        mockMvc.perform(get("/api/admin/audit"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET /api/admin/audit — USER role → 403")
    void should_return403_when_getAllAudit_withUserRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("GET /api/admin/audit — ADMIN returns paginated list")
    void should_returnPaginatedAuditLogs_when_admin() throws Exception {
        String adminToken = createAdminAndGetToken();
        insertAuditLogs(5, null);

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + adminToken)
                        .param("page", "0")
                        .param("size", "3"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content").isArray())
                .andExpect(jsonPath("$.totalElements").value(5))
                .andExpect(jsonPath("$.size").value(3))
                .andExpect(jsonPath("$.number").value(0));
    }

    @Test
    @DisplayName("GET /api/admin/audit — page 0 with default size returns entries")
    void should_returnPage0_with_defaultSize() throws Exception {
        String adminToken = createAdminAndGetToken();
        insertAuditLogs(10, null);

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content").isArray())
                .andExpect(jsonPath("$.totalElements").value(10));
    }

    @Test
    @DisplayName("GET /api/admin/audit — page beyond last → empty content")
    void should_returnEmptyContent_when_pageBeyondLast() throws Exception {
        String adminToken = createAdminAndGetToken();
        insertAuditLogs(3, null);

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + adminToken)
                        .param("page", "99")
                        .param("size", "50"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content").isArray())
                .andExpect(jsonPath("$.content").isEmpty());
    }

    @Test
    @DisplayName("GET /api/admin/audit — page=0,size=1 returns exactly 1 entry")
    void should_returnOneEntry_when_sizeIsOne() throws Exception {
        String adminToken = createAdminAndGetToken();
        insertAuditLogs(5, null);

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + adminToken)
                        .param("page", "0")
                        .param("size", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content.length()").value(1));
    }

    @Test
    @DisplayName("GET /api/admin/audit — empty DB returns empty page")
    void should_returnEmptyPage_when_noLogs() throws Exception {
        String adminToken = createAdminAndGetToken();

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalElements").value(0))
                .andExpect(jsonPath("$.content").isArray())
                .andExpect(jsonPath("$.content").isEmpty());
    }

    @Test
    @DisplayName("GET /api/admin/audit — response contains expected fields")
    void should_returnExpectedFields_in_auditResponse() throws Exception {
        String adminToken = createAdminAndGetToken();
        Long userId = userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();
        insertAuditLogs(1, userId);

        mockMvc.perform(get("/api/admin/audit")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content[0].id").isNumber())
                .andExpect(jsonPath("$.content[0].action").isNotEmpty())
                .andExpect(jsonPath("$.content[0].status").isNotEmpty())
                .andExpect(jsonPath("$.content[0].createdAt").isNotEmpty());
    }

    // =========================================================================
    // GET /api/admin/audit/user/{userId}
    // =========================================================================

    @Test
    @DisplayName("GET /api/admin/audit/user/{userId} — anonymous → 401")
    void should_return401_when_getAuditByUser_anonymous() throws Exception {
        mockMvc.perform(get("/api/admin/audit/user/1"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET /api/admin/audit/user/{userId} — USER role → 403")
    void should_return403_when_getAuditByUser_withUserRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);

        mockMvc.perform(get("/api/admin/audit/user/1")
                        .header("Authorization", "Bearer " + token))
                .andExpect(status().isForbidden());
    }

    @Test
    @DisplayName("GET /api/admin/audit/user/{userId} — returns only logs for that user")
    void should_returnOnlyUserLogs_when_filterByUserId() throws Exception {
        String adminToken = createAdminAndGetToken();
        Long userId = userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();

        insertAuditLogs(3, userId);
        insertAuditLogs(2, 99999L); // other user

        mockMvc.perform(get("/api/admin/audit/user/" + userId)
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalElements").value(3))
                .andExpect(jsonPath("$.content[0].userId").value(userId));
    }

    @Test
    @DisplayName("GET /api/admin/audit/user/{userId} — non-existent userId returns empty page (not 404)")
    // GAP: no 404 guard for unknown userId — empty page is acceptable but
    //      a dedicated 404 would be more informative
    void should_returnEmptyPage_when_userHasNoLogs() throws Exception {
        String adminToken = createAdminAndGetToken();

        mockMvc.perform(get("/api/admin/audit/user/999999")
                        .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalElements").value(0));
    }

    @Test
    @DisplayName("GET /api/admin/audit/user/{userId} — pagination: page 1 with size 2")
    void should_supportPagination_when_getByUser() throws Exception {
        String adminToken = createAdminAndGetToken();
        Long userId = userRepository.findByEmail(TEST_EMAIL).orElseThrow().getId();
        insertAuditLogs(5, userId);

        mockMvc.perform(get("/api/admin/audit/user/" + userId)
                        .header("Authorization", "Bearer " + adminToken)
                        .param("page", "1")
                        .param("size", "2"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content.length()").value(2))
                .andExpect(jsonPath("$.number").value(1));
    }

    // =========================================================================
    // Audit-on-login: login action produces audit record (when audit enabled)
    // =========================================================================

    // GAP: login endpoint does not publish an audit event even when security.audit.enabled=true.
    //      The audit interceptor/listener is not wired to the authentication success path.
    //      Fix: add an AuditEventPublisher call in AuthServiceImpl.login() on success.
    @Test
    @DisplayName("Audit log created for LOGIN action after successful login")
    void should_auditLoginAction_when_userLogsIn() throws Exception {
        String adminToken = createAdminAndGetToken();
        long before = auditLogRepository.count();

        // Another user login to generate a LOGIN audit
        String otherEmail = "auditsubject@checkfood.test";
        createVerifiedUser(otherEmail, TEST_PASSWORD, "Audit", "Subject");
        loginUser(otherEmail, TEST_PASSWORD, "audit-device-001");

        // At least 1 new audit entry since login
        long after = auditLogRepository.count();
        assertThat(after).isGreaterThan(before);
    }

    // =========================================================================
    // Private helpers
    // =========================================================================

    private String createAdminAndGetToken() throws Exception {
        getAccessToken(TEST_EMAIL, TEST_PASSWORD, TEST_DEVICE_ID);
        promoteToAdmin(TEST_EMAIL);
        return loginAgain(TEST_EMAIL, TEST_PASSWORD);
    }

    private void promoteToAdmin(String email) {
        // Use findWithRolesByEmail to eagerly load roles and avoid LazyInitializationException
        UserEntity user = userRepository.findWithRolesByEmail(email).orElseThrow();
        RoleEntity adminRole = roleRepository.findByName("ADMIN").orElseThrow();
        HashSet<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(adminRole);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);
    }

    private String loginAgain(String email, String password) throws Exception {
        var result = loginUser(email, password, TEST_DEVICE_ID);
        var body = objectMapper.readTree(result.getResponse().getContentAsString());
        return body.get("accessToken").asText();
    }

    private void insertAuditLogs(int count, Long userId) {
        for (int i = 0; i < count; i++) {
            AuditLogEntity log = new AuditLogEntity();
            log.setUserId(userId);
            log.setAction(AuditAction.LOGIN);
            log.setStatus(AuditStatus.SUCCESS);
            log.setIpAddress("127.0.0.1");
            log.setUserAgent("test-agent");
            auditLogRepository.save(log);
        }
    }
}
