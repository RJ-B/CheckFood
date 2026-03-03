package com.checkfood.checkfoodservice.security.module.auth.email;

import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * SMTP implementace email service pro asynchronní email delivery.
 *
 * Využívá Spring JavaMailSender pro SMTP communication s configurable
 * backend URL pro environment-specific verification links. Všechny operace
 * běží asynchronně pro minimalizaci impact na authentication flow.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see EmailService
 * @see JavaMailSender
 */
@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    /**
     * Spring JavaMailSender pro SMTP communication.
     */
    private final JavaMailSender mailSender;

    /**
     * SMTP sender email address z configuration.
     */
    @Value("${spring.mail.username}")
    private String senderEmail;

    /**
     * Backend URL pro verification link construction.
     * Environment-specific configuration pro development vs production.
     */
    @Value("${app.backend.url:http://localhost:8081}")
    private String backendUrl;

    /**
     * Asynchronně odešle HTML verification email s activation link.
     *
     * Costruuje verification URL s backend endpoint a token parameter.
     * Používá EmailTemplates pro consistent branding a HTML formatting.
     * Exception handling transformuje MessagingException na AuthException.
     *
     * @param to recipient email address
     * @param token verification token pro URL construction
     * @throws AuthException při SMTP delivery failures
     */
    @Async
    @Override
    public void sendVerificationEmail(String to, String token) {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

            // Verification URL construction s backend endpoint
            String link = backendUrl + "/api/auth/verify?token=" + token;
            String htmlMsg = EmailTemplates.createVerificationEmail(link);

            // Email configuration s HTML content type
            helper.setText(htmlMsg, true);
            helper.setTo(to);
            helper.setSubject("CheckFood - Potvrzení registrace");
            helper.setFrom(senderEmail);

            mailSender.send(mimeMessage);

        } catch (MessagingException e) {
            // Transform SMTP exception na AuthException pro consistent error handling
            throw AuthException.internalError("Chyba při odesílání verifikačního emailu: " + e.getMessage());
        }
    }
}