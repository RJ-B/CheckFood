package com.checkfood.checkfoodservice.security.auth.email;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value; // Důležitý import
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailService {

    private final JavaMailSender mailSender;

    // Načteme email odesílatele
    @Value("${spring.mail.username}")
    private String senderEmail;

    // Načteme URL backendu (dynamicky z .env.example nebo properties)
    // Pokud není nastaveno, použije se defaultně localhost
    @Value("${app.backend.url:http://localhost:8081}")
    private String backendUrl;

    /**
     * Odešle verifikační email na pozadí (asynchronně).
     */
    @Async
    public void sendVerificationEmail(String to, String token) {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

            // Skládáme dynamický odkaz.
            // backendUrl bude např: "http://31.30.173.143:8081"
            String link = backendUrl + "/api/auth/verify?token=" + token;

            String htmlMsg = String.format("""
                <div style="font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 5px;">
                    <h2 style="color: #4CAF50;">Vítejte v CheckFood!</h2>
                    <p>Dobrý den,</p>
                    <p>děkujeme za registraci. Pro aktivaci vašeho účtu prosím klikněte na tlačítko níže:</p>
                    <a href="%s" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Aktivovat účet</a>
                    <p style="margin-top: 20px; font-size: 12px; color: #888;">Pokud tlačítko nefunguje, zkopírujte tento odkaz do prohlížeče:<br>%s</p>
                    <p style="font-size: 12px; color: #888;">Odkaz je platný 24 hodin.</p>
                </div>
                """, link, link);

            helper.setText(htmlMsg, true); // true = HTML formát
            helper.setTo(to);
            helper.setSubject("CheckFood - Potvrzení registrace");
            helper.setFrom(senderEmail);

            mailSender.send(mimeMessage);
            log.info("✅ Verifikační email úspěšně odeslán na: {}", to);

        } catch (MessagingException e) {
            log.error("❌ Chyba při odesílání emailu na {}: {}", to, e.getMessage());
        }
    }
}