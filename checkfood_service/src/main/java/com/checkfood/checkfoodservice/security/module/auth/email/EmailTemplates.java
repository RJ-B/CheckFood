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
     * Private constructor - utility class nesmí být instantiated.
     */
    private EmailTemplates() {
        throw new UnsupportedOperationException("Utility class");
    }
}