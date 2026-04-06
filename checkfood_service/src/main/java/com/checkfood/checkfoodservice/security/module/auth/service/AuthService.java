package com.checkfood.checkfoodservice.security.module.auth.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LogoutRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RefreshRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Service interface pro autentizaci a správu uživatelských účtů.
 * Zajišťuje orchestraci mezi zabezpečením, správou uživatelů, evidencí zařízení a email verifikací.
 *
 * @see AuthServiceImpl
 */
public interface AuthService {

    /**
     * Zaregistruje nového uživatele a zahájí proces verifikace emailu.
     * Vytvoří neaktivní účet s výchozí rolí a odešle verifikační email.
     * Tokeny se nevracejí - uživatel musí nejprve aktivovat účet kliknutím na odkaz v emailu.
     *
     * @param requestDto registrační data včetně osobních údajů a informací o zařízení
     */
    void register(RegisterRequest requestDto);

    /**
     * Zaregistruje nového uživatele s rolí OWNER a zahájí verifikaci emailu.
     * Po přihlášení bude uživatel přesměrován na claim restaurace.
     *
     * @param requestDto registrační data
     */
    void registerOwner(RegisterRequest requestDto);

    /**
     * Aktivuje uživatelský účet na základě verifikačního tokenu z emailu.
     * Po úspěšné validaci nastaví účet jako aktivní a umožní přihlášení.
     *
     * @param token verifikační token z emailového odkazu
     */
    void verifyAccount(String token);

    /**
     * Vygeneruje nový verifikační token a odešle ho na email uživatele.
     * Zneplatní všechny předchozí tokeny daného uživatele.
     * Používá se když původní email nedorazil nebo token vypršel.
     *
     * @param email emailová adresa uživatele
     */
    void resendVerificationCode(String email);

    /**
     * Ověří přihlašovací údaje a vytvoří novou autentizovanou relaci.
     * Vyžaduje aktivovaný účet. Registruje zařízení a generuje access a refresh tokeny.
     *
     * @param request přihlašovací údaje a informace o zařízení
     * @return autentizační odpověď s tokeny a informacemi o uživateli
     */
    AuthResponse login(LoginRequest request);

    /**
     * Obnoví access token pomocí platného refresh tokenu.
     * Implementuje strategii rotace tokenů - starý refresh token je invalidován
     * a vrácen je nový pár tokenů.
     *
     * @param request obsahuje refresh token a identifikátor zařízení
     * @return nový pár access a refresh tokenů
     */
    TokenResponse refreshToken(RefreshRequest request);

    /**
     * Provede odhlášení uživatele a ukončí relaci na daném zařízení.
     * Invaliduje refresh token a odstraní záznam o zařízení z databáze.
     * Ověřuje, že refresh token patří přihlášenému uživateli (prevence logout hijack).
     *
     * @param request obsahuje refresh token a identifikátor zařízení
     * @param authenticatedEmail email přihlášeného uživatele z Security kontextu
     */
    void logout(LogoutRequest request, String authenticatedEmail);

    /**
     * Vrátí informace o aktuálně přihlášeném uživateli ze Security kontextu.
     *
     * @param userDetails autentizační detaily z Security Contextu
     * @return DTO s informacemi o uživateli
     */
    UserResponse getCurrentUser(UserDetails userDetails);

    /**
     * Zpracuje žádost o obnovu hesla. Vygeneruje reset token a odešle email.
     * Vrací void a NEINDIKUJE zda email existuje (prevence user enumeration).
     *
     * @param email emailová adresa uživatele
     */
    void requestPasswordReset(String email);

    /**
     * Provede reset hesla na základě platného tokenu.
     *
     * @param token reset token z emailového odkazu
     * @param newPassword nové heslo (validováno přes PasswordPolicy)
     */
    void resetPassword(String token, String newPassword);
}