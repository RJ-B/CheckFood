package com.checkfood.checkfoodservice.security.auth.controller;

import com.checkfood.checkfoodservice.security.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.auth.repository.VerificationTokenRepository;
import com.checkfood.checkfoodservice.security.user.repository.DeviceRepository;
import com.checkfood.checkfoodservice.security.user.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
// ZDE NASTAVTE REÁLNÉ ÚDAJE PRO TEST (Po testu heslo smažte!)
@TestPropertySource(properties = {
        "spring.mail.host=smtp.gmail.com",
        "spring.mail.port=587",
        "spring.mail.username=rjirak.jr@gmail.com",
        "spring.mail.password=xufk huay wfit yjwv",
        "spring.mail.properties.mail.smtp.auth=true",
        "spring.mail.properties.mail.smtp.starttls.enable=true",
        "spring.mail.properties.mail.smtp.ssl.trust=*"
})
class AuthRealEmailTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DeviceRepository deviceRepository;

    @Autowired
    private VerificationTokenRepository verificationTokenRepository;

    @BeforeEach
    void cleanUp() {
        // Vyčistíme DB před testem, aby nehlásil "Email already exists"
        verificationTokenRepository.deleteAll();
        deviceRepository.deleteAll();
        userRepository.deleteAll();
    }

    @Test
    @DisplayName("📧 LIVE EMAIL TEST: Odeslání skutečného emailu (s čekáním)")
    void shouldSendRealEmail_WhenRegistering() throws Exception {
        // Váš email, kam to má přijít
        String myRealEmail = "rjirak.jr@gmail.com";

        RegisterRequest registerRequest = RegisterRequest.builder()
                .email(myRealEmail)
                .password("SuperStrongPass123!")
                .confirmPassword("SuperStrongPass123!")
                .firstName("Live")
                .lastName("Tester")
                .deviceIdentifier(UUID.randomUUID().toString())
                .deviceName("JUnit Test Device")
                .deviceType("ANDROID")
                .build();

        System.out.println("🚀 Odesílám požadavek na registraci...");

        mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(registerRequest)))
                .andDo(print())
                .andExpect(status().isAccepted()); // Čekáme 202

        System.out.println("✅ Požadavek přijat. Server posílá email na pozadí.");
        System.out.println("⏳ Čekám 10 sekund, aby se stihl navázat spojení s Gmailem...");

        // DŮLEŽITÉ: Udrží test naživu, dokud se email neodešle
        Thread.sleep(10000);

        System.out.println("🏁 Test dokončen. Zkontrolujte schránku: " + myRealEmail);
    }
}