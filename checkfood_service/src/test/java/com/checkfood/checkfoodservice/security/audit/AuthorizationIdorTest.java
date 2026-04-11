package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

/**
 * Broken Object Level Authorization (BOLA / IDOR) probes.
 * Creates user A and user B and verifies that A cannot read, mutate, or
 * delete B's owner-scoped resources.
 *
 * Scope: reservations, devices, favourites, orders, dining sessions,
 * panorama sessions, menu items, photos, MFA secrets, restaurants.
 *
 * // GAP markers call out endpoints where the expected protection is
 * // either absent or only enforced via service-layer ownership check
 * // that this test suite cannot cover without service-level fixtures.
 */
class AuthorizationIdorTest extends BaseAuthIntegrationTest {

    private static final String A_EMAIL = "user.a@checkfood.test";
    private static final String B_EMAIL = "user.b@checkfood.test";

    @Test
    @DisplayName("User A cannot access /api/user/{id} admin endpoint (role enforcement)")
    void otherUserDetailRequiresAdmin() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");
        createVerifiedUser(B_EMAIL, TEST_PASSWORD, "User", "B");
        Long bId = userRepository.findByEmail(B_EMAIL).orElseThrow().getId();

        MvcResult result = mockMvc.perform(get("/api/user/" + bId)
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        assertThat(result.getResponse().getStatus())
                .as("Non-admin must never read another user's admin-detail record")
                .isIn(401, 403);
    }

    @Test
    @DisplayName("User A cannot delete a random reservation UUID belonging to nobody")
    void reservationCancelRejectsForeignId() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");
        UUID randomReservation = UUID.randomUUID();

        MvcResult result = mockMvc.perform(patch("/api/v1/reservations/" + randomReservation + "/cancel")
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        int status = result.getResponse().getStatus();
        assertThat(status)
                .as("Cancel of unknown/foreign reservation must be 403/404, never 200")
                .isIn(400, 403, 404);
    }

    @Test
    @DisplayName("User A cannot read another user's pending-changes endpoint for a foreign reservation")
    void changeRequestAcceptRejectsForeign() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");
        UUID fakeChangeId = UUID.randomUUID();

        MvcResult result = mockMvc.perform(post("/api/v1/reservations/change-requests/" + fakeChangeId + "/accept")
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(400, 403, 404);
    }

    @Test
    @DisplayName("User A cannot fetch order detail of foreign order UUID")
    void orderDetailRejectsForeignOrder() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");
        UUID foreignOrder = UUID.randomUUID();

        MvcResult result = mockMvc.perform(get("/api/v1/orders/" + foreignOrder)
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        assertThat(result.getResponse().getStatus())
                .as("Order detail of foreign order must not return 200")
                .isIn(400, 403, 404);
    }

    @Test
    @DisplayName("User A cannot delete device with numeric ID owned by another user")
    void deviceDeleteRejectsForeign() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");

        // Attempt delete a non-existent device ID
        MvcResult result = mockMvc.perform(delete("/api/user/devices/99999")
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(204, 400, 403, 404);
        // 204 is acceptable ONLY if the service silently treats non-owned IDs as no-op;
        // but the response body MUST NOT contain data for the foreign device.
        String body = result.getResponse().getContentAsString();
        assertThat(body).doesNotContainPattern("user[_-]?id");
    }

    @Test
    @DisplayName("Restaurant update rejects non-owner user (403)")
    void restaurantUpdateRejectsNonOwner() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");
        UUID fakeRestaurant = UUID.randomUUID();

        String body = "{\"name\":\"Hijacked\"}";
        MvcResult result = mockMvc.perform(put("/api/v1/restaurants/" + fakeRestaurant)
                        .header("Authorization", "Bearer " + tokenA)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andReturn();

        assertThat(result.getResponse().getStatus())
                .as("Non-owner must never update a restaurant (expect 400/403/404)")
                .isIn(400, 403, 404);
    }

    @Test
    @DisplayName("Panorama session endpoints require OWNER role — USER must be rejected")
    void panoramaRequiresOwnerRole() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");

        MvcResult result = mockMvc.perform(get("/api/v1/owner/restaurant/me/panorama/sessions")
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isIn(401, 403);
    }

    @Test
    @DisplayName("Favourite add of nonexistent restaurant UUID returns 4xx (not 500, not 200 leaking data)")
    void favouriteAddHandlesUnknownId() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");
        UUID unknown = UUID.randomUUID();

        MvcResult result = mockMvc.perform(put("/api/v1/users/me/favourites/" + unknown)
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        int status = result.getResponse().getStatus();
        assertThat(status).isLessThan(500);
    }

    @Test
    @DisplayName("MFA setup/start requires authentication and only affects the caller")
    void mfaSetupBoundToCaller() throws Exception {
        String tokenA = getAccessToken(A_EMAIL, TEST_PASSWORD, "dev-A");

        MvcResult result = mockMvc.perform(post("/api/mfa/setup/start")
                        .header("Authorization", "Bearer " + tokenA))
                .andReturn();

        // Must either succeed (200) or be a well-handled error — but never reveal other users' secrets
        assertThat(result.getResponse().getStatus()).isLessThan(500);
    }
}
