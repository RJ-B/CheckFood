package com.checkfood.checkfoodservice.security.module.auth.email;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String senderEmail;

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

            String link = backendUrl + "/api/auth/verify?token=" + token;
            String htmlMsg = EmailTemplates.createVerificationEmail(link);

            helper.setText(htmlMsg, true);
            helper.setTo(to);
            helper.setSubject("CheckFood - Potvrzení registrace");
            helper.setFrom(senderEmail);

            mailSender.send(mimeMessage);

        } catch (MessagingException e) {
            // Metoda běží asynchronně (@Async) — throw by byl ztracen v async kontextu.
            log.error("[Email] Chyba při odesílání verifikačního emailu na {}: {}", to, e.getMessage(), e);
        }
    }

    /**
     * Asynchronně odešle HTML email s odkazem pro obnovu hesla.
     *
     * Konstruuje reset URL s backend endpointem a token parametrem.
     * Používá EmailTemplates pro consistent branding a HTML formatting.
     *
     * @param to email adresa příjemce
     * @param token reset token pro URL construction
     * @throws AuthException při SMTP delivery failures
     */
    @Async
    @Override
    public void sendPasswordResetEmail(String to, String token) {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

            String link = backendUrl + "/api/auth/reset-password?token=" + token;
            String htmlMsg = EmailTemplates.createPasswordResetEmail(link);

            helper.setText(htmlMsg, true);
            helper.setTo(to);
            helper.setSubject("CheckFood - Obnova hesla");
            helper.setFrom(senderEmail);

            mailSender.send(mimeMessage);

        } catch (MessagingException e) {
            // Metoda běží asynchronně (@Async) — throw by byl ztracen v async kontextu.
            log.error("[Email] Chyba při odesílání emailu pro obnovu hesla na {}: {}", to, e.getMessage(), e);
        }
    }
}