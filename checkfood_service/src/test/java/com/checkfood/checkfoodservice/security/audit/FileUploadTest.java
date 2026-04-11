package com.checkfood.checkfoodservice.security.audit;

import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MvcResult;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;

/**
 * File-upload probes.
 * Restaurant logo / cover / gallery accept multipart. We verify MIME-type
 * whitelisting, oversized rejection, path traversal, SVG/HTML rejection.
 */
class FileUploadTest extends BaseAuthIntegrationTest {

    @Test
    @DisplayName("Non-image MIME type is rejected on logo upload")
    void nonImageRejected() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        UUID restaurantId = UUID.randomUUID();

        MockMultipartFile file = new MockMultipartFile(
                "file", "payload.exe", "application/x-msdownload",
                new byte[]{0x4D, 0x5A, 0x00, 0x00}
        );

        MvcResult result = mockMvc.perform(multipart("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                        .file(file)
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        int status = result.getResponse().getStatus();
        assertThat(status)
                .as("Non-image upload must be rejected with 4xx")
                .isLessThan(500)
                .isGreaterThanOrEqualTo(400);
    }

    @Test
    @DisplayName("SVG (HTML-executable) upload is rejected or sanitized")
    void svgUploadRejected() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        UUID restaurantId = UUID.randomUUID();

        byte[] svgXss = """
                <svg xmlns="http://www.w3.org/2000/svg" onload="alert(1)">
                  <script>alert('xss')</script>
                </svg>
                """.getBytes();

        MockMultipartFile file = new MockMultipartFile(
                "file", "evil.svg", "image/svg+xml", svgXss);

        MvcResult result = mockMvc.perform(multipart("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                        .file(file)
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        int status = result.getResponse().getStatus();
        assertThat(status)
                .as("GAP: SVG must not be accepted as a logo image — executable XML surface")
                .isGreaterThanOrEqualTo(400);
    }

    @Test
    @DisplayName("Path traversal filename is sanitized / does not escape upload dir")
    void pathTraversalFilename() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        UUID restaurantId = UUID.randomUUID();

        MockMultipartFile file = new MockMultipartFile(
                "file", "../../etc/passwd", "image/png",
                new byte[]{(byte) 0x89, 0x50, 0x4E, 0x47});

        MvcResult result = mockMvc.perform(multipart("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                        .file(file)
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        int status = result.getResponse().getStatus();
        assertThat(status).isLessThan(500);
        String body = result.getResponse().getContentAsString();
        assertThat(body).doesNotContain("../");
    }

    @Test
    @DisplayName("HTML file disguised as image is rejected")
    void htmlDisguisedAsImageRejected() throws Exception {
        String token = getAccessToken(TEST_EMAIL, TEST_PASSWORD, "dev-1");
        UUID restaurantId = UUID.randomUUID();

        byte[] html = "<html><body><script>alert(1)</script></body></html>".getBytes();

        MockMultipartFile file = new MockMultipartFile(
                "file", "image.png", "text/html", html);

        MvcResult result = mockMvc.perform(multipart("/api/v1/owner/restaurants/" + restaurantId + "/logo")
                        .file(file)
                        .header("Authorization", "Bearer " + token))
                .andReturn();

        assertThat(result.getResponse().getStatus()).isGreaterThanOrEqualTo(400);
    }
}
