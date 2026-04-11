package com.checkfood.checkfoodservice.security.module.auth.email;

/**
 * Utility class poskytující HTML email templates pro authentication workflow.
 *
 * Centralizuje email markup pro consistent branding a easy maintenance.
 * Všechny templates jsou responsive a obsahují fallback text links
 * pro accessibility a email client compatibility.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class EmailTemplates {

    /**
     * Vytvoří HTML template pro verification email s branded design.
     *
     * Template obsahuje:
     * - CheckFood branding s green color scheme
     * - Primary action button pro activation
     * - Fallback text link pro email clients bez CSS support
     * - Security notice o 24-hour expiration
     * - Responsive design pro mobile compatibility
     *
     * @param activationLink complete verification URL s token parameter
     * @return formatted HTML string ready pro email sending
     */
    public static String createVerificationEmail(String activationLink) {
        return String.format("""
            <div style="font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 5px;">
                <h2 style="color: #4CAF50;">Vítejte v CheckFood!</h2>
                <p>Dobrý den,</p>
                <p>děkujeme za registraci. Pro aktivaci vašeho účtu prosím klikněte na tlačítko níže:</p>
                <a href="%s" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Aktivovat účet</a>
                <p style="margin-top: 20px; font-size: 12px; color: #888;">Pokud tlačítko nefunguje, zkopírujte tento odkaz do prohlížeče:<br>%s</p>
                <p style="font-size: 12px; color: #888;">Odkaz je platný 24 hodin.</p>
            </div>
            """, activationLink, activationLink);
    }

    /**
     * Vytvoří HTML template pro password reset email s branded design.
     *
     * Template obsahuje:
     * - CheckFood branding s orange color scheme
     * - Primary action button pro reset
     * - Fallback text link pro email clients bez CSS support
     * - Security notice o 1-hour expiration
     * - Upozornění pro případ, že uživatel reset nepožadoval
     *
     * @param resetLink kompletní reset URL s tokenem
     * @return formátovaný HTML string připravený pro odeslání
     */
    public static String createPasswordResetEmail(String resetLink) {
        return String.format("""
            <div style="font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 5px;">
                <h2 style="color: #E85D04;">Obnova hesla</h2>
                <p>Dobrý den,</p>
                <p>obdrželi jsme žádost o obnovu hesla k vašemu účtu v CheckFood. Klikněte na tlačítko níže pro nastavení nového hesla:</p>
                <a href="%s" style="background-color: #E85D04; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Obnovit heslo</a>
                <p style="margin-top: 20px; font-size: 12px; color: #888;">Pokud jste o obnovu hesla nezažádali, tento email můžete ignorovat. Váš účet zůstává v bezpečí.</p>
                <p style="font-size: 12px; color: #888;">Pokud tlačítko nefunguje, zkopírujte tento odkaz do prohlížeče:<br>%s</p>
                <p style="font-size: 12px; color: #888;">Odkaz je platný 1 hodinu.</p>
            </div>
            """, resetLink, resetLink);
    }

    /**
     * HTML template pro notifikaci "s tvým e-mailem se někdo pokusil registrovat".
     * Používá se v OWASP-compliant register flow (always-202).
     *
     * @param forgotPasswordLink kompletní URL na forgot-password flow
     * @return formátovaný HTML string
     */
    public static String createAccountExistsNotificationEmail(String forgotPasswordLink) {
        return String.format("""
            <div style="font-family: Arial, sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 5px;">
                <h2 style="color: #E85D04;">Pokus o registraci s vaším e-mailem</h2>
                <p>Dobrý den,</p>
                <p>někdo se právě pokusil zaregistrovat účet na CheckFood s vaší e-mailovou adresou.</p>
                <p><strong>Pokud to nejste vy</strong>, tuto zprávu můžete bez obav ignorovat — váš účet zůstává v bezpečí a nebyl vytvořen žádný nový.</p>
                <p><strong>Pokud to jste vy a zapomněli jste, že již máte účet</strong>, přihlaste se svým heslem, nebo si ho obnovte:</p>
                <a href="%s" style="background-color: #E85D04; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">Obnovit heslo</a>
                <p style="margin-top: 20px; font-size: 12px; color: #888;">Tato zpráva byla odeslána automaticky. Neodpovídejte na ni.</p>
            </div>
            """, forgotPasswordLink);
    }

    /**
     * Private constructor - utility class nesmí být instantiated.
     */
    private EmailTemplates() {
        throw new UnsupportedOperationException("Utility class");
    }
}