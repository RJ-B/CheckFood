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
 * Implementace email servisu pro odesílání emailů prostřednictvím SMTP.
 * Všechny operace probíhají asynchronně pro minimalizaci dopadu na hlavní flow aplikace.
 *
 * @see EmailService
 * @see JavaMailSender
 * @see EmailTemplates
 */
@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String senderEmail;

    /**
     * URL backendu pro sestavení verifikačních odkazů.
     * Defaultně localhost:8081, v produkci se nastaví z konfigurace.
     */
    @Value("${app.backend.url:http://localhost:8081}")
    private String backendUrl;

    /**
     * Asynchronně odešle verifikační email s aktivačním odkazem.
     * Email obsahuje HTML formátovanou zprávu s tlačítkem pro aktivaci účtu.
     * Odkaz je platný 24 hodin.
     *
     * @param to emailová adresa příjemce
     * @param token verifikační token pro sestavení aktivačního odkazu
     * @throws AuthException při chybě odesílání emailu
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
            throw AuthException.internalError("Chyba při odesílání verifikačního emailu: " + e.getMessage());
        }
    }
}