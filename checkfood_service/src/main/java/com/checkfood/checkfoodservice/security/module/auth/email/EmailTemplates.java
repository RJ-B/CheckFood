package com.checkfood.checkfoodservice.security.module.auth.email;

/**
 * Šablony HTML emailů pro autentizační proces.
 * Centralizuje email markup pro snadnou údržbu a konzistentní design.
 */
public class EmailTemplates {

    /**
     * Vytvoří HTML šablonu pro verifikační email s aktivačním odkazem.
     * Email obsahuje tlačítko pro aktivaci účtu a alternativní textový odkaz.
     * Odkaz je platný 24 hodin.
     *
     * @param activationLink kompletní URL pro aktivaci účtu
     * @return HTML string s formátovaným emailem
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

    private EmailTemplates() {
        throw new UnsupportedOperationException("Utility class");
    }
}