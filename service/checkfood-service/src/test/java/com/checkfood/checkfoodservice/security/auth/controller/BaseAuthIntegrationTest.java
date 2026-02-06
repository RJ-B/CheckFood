package com.checkfood.checkfoodservice.security.auth.controller;

import com.checkfood.checkfoodservice.security.auth.email.EmailService;
import com.checkfood.checkfoodservice.security.auth.repository.VerificationTokenRepository; // <-- PŘIDAT
import com.checkfood.checkfoodservice.security.jwt.JwtService;
import com.checkfood.checkfoodservice.security.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.repository.DeviceRepository;
import com.checkfood.checkfoodservice.security.user.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;
import javax.crypto.spec.SecretKeySpec;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Transactional
public abstract class BaseAuthIntegrationTest {

    @Autowired
    protected MockMvc mockMvc;

    @Autowired
    protected UserRepository userRepository;

    @Autowired
    protected DeviceRepository deviceRepository;

    // Nové repository pro kontrolu tokenů
    @Autowired
    protected VerificationTokenRepository verificationTokenRepository;

    @Autowired
    protected JwtService jwtService;

    @Autowired
    protected JwtProperties jwtProperties;

    @Autowired
    protected PasswordEncoder passwordEncoder;

    @Autowired
    protected ObjectMapper objectMapper;

    @PersistenceContext
    protected EntityManager entityManager;

    // --- MOCKOVÁNÍ EMAILU ---
    // Toto zajistí, že se nebude volat skutečný Gmail, ale jen se zaznamená, že metoda byla zavolána.
    @MockBean
    protected EmailService emailService;

    protected UserEntity testUser;
    protected final String RAW_PASSWORD = "StrongPassword123!";
    protected final String TEST_EMAIL = "test@checkfood.cz";

    @BeforeEach
    void setUp() {
        // Vyčistíme vše
        verificationTokenRepository.deleteAll(); // <-- Smazat tokeny
        deviceRepository.deleteAll();
        userRepository.deleteAll();

        testUser = UserEntity.builder()
                .email(TEST_EMAIL)
                .password(passwordEncoder.encode(RAW_PASSWORD))
                .firstName("Jan")
                .lastName("Novák")
                .enabled(true) // Testovací uživatel je defaultně aktivní (pro Login testy)
                .build();

        userRepository.save(testUser);
        entityManager.flush();
    }

    // ... metoda generateExpiredToken zůstává stejná ...
    protected String generateExpiredToken(UserEntity user) {
        // ... (zkopírujte si ze staré verze nebo nechte být) ...
        java.time.Instant past = java.time.Instant.now().minusSeconds(3600);

        org.springframework.security.oauth2.jwt.JwtClaimsSet claims =
                org.springframework.security.oauth2.jwt.JwtClaimsSet.builder()
                        .issuer(jwtProperties.getIssuer())
                        .issuedAt(past.minusSeconds(3600))
                        .expiresAt(past)
                        .subject(user.getEmail())
                        .claim("type", "ACCESS")
                        .build();

        byte[] keyBytes = jwtProperties.getSecret().getBytes(StandardCharsets.UTF_8);
        SecretKeySpec secretKey = new SecretKeySpec(keyBytes, "HmacSHA256");

        var secret = new com.nimbusds.jose.jwk.source.ImmutableSecret<>(secretKey);
        var encoder = new org.springframework.security.oauth2.jwt.NimbusJwtEncoder(secret);
        var header = org.springframework.security.oauth2.jwt.JwsHeader.with(org.springframework.security.oauth2.jose.jws.MacAlgorithm.HS256).build();

        return encoder.encode(org.springframework.security.oauth2.jwt.JwtEncoderParameters.from(header, claims)).getTokenValue();
    }
}