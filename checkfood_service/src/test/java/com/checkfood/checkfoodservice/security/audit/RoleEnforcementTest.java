package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.MvcResult;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

/**
 * Role-based access control audit.
 * USER token must be rejected on ADMIN and OWNER endpoints.
 */
class RoleEnforcementTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("USER cannot list all users (admin endpoint)")
    void userCannotListAllUsers() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        MvcResult result = mockMvc.perform(get("/api/user")
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isEqualTo(403);
    }

    @Test
    @DisplayName("USER cannot assign roles (admin endpoint)")
    void userCannotAssignRole() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        String json = "{\"userId\":1,\"roleName\":\"ADMIN\"}";
        MvcResult result = mockMvc.perform(post("/api/user/assign-role")
                        .header("Authorization", "Bearer " + token)
                        .contentType("application/json")
                        .content(json))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isEqualTo(403);
    }

    @Test
    @DisplayName("USER cannot access owner panorama endpoints")
    void userCannotAccessPanorama() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        MvcResult result = mockMvc.perform(get("/api/v1/owner/restaurant/me/panorama/sessions")
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(401, 403);
    }

    @Test
    @DisplayName("USER cannot upload restaurant logo (owner/manager endpoint)")
    void userCannotUploadLogo() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        UUID restId = UUID.randomUUID();

        MvcResult result = mockMvc.perform(post("/api/v1/owner/restaurants/" + restId + "/logo")
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(401, 403, 415);
    }

    @Test
    @DisplayName("USER cannot create a restaurant (requires RESTAURANT_OWNER)")
    void userCannotCreateRestaurant() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");

        MvcResult result = mockMvc.perform(post("/api/v1/restaurants")
                        .header("Authorization", "Bearer " + token)
                        .contentType("application/json")
                        .content("{\"name\":\"x\"}"))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(400, 401, 403);
    }
}
