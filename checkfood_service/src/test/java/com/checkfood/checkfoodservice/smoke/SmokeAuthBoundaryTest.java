package com.checkfood.checkfoodservice.smoke;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

/**
 * Smoke test: the auth boundary is enforced.
 *
 * Excluded from the default `./mvnw test` run via Surefire excludedGroups=smoke.
 * Run manually against staging with:
 *   ./mvnw test -Dgroups=smoke -Dspring.profiles.active=staging
 */
@Tag("smoke")
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
@ActiveProfiles("test")
class SmokeAuthBoundaryTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void protectedEndpointRequiresToken() throws Exception {
        MvcResult res = mockMvc.perform(get("/api/v1/restaurants/me")).andReturn();
        assertThat(res.getResponse().getStatus()).isIn(401, 403);
    }

    @Test
    void userMeRequiresToken() throws Exception {
        MvcResult res = mockMvc.perform(get("/api/user/me")).andReturn();
        assertThat(res.getResponse().getStatus()).isIn(401, 403);
    }
}
