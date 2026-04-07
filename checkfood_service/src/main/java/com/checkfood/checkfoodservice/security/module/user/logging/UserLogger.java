package com.checkfood.checkfoodservice.security.module.user.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro úspěšné operace v User modulu (happy path).
 * Chybové stavy jsou logovány výhradně v UserExceptionHandler.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class UserLogger extends SecurityLogger {

    /**
     * Zaloguje vytvoření nového uživatelského účtu.
     *
     * @param email e-mailová adresa nového uživatele
     */
    public void logUserCreated(String email) {
        this.info("Vytvořen nový uživatel: {}", email);
    }

    /**
     * Zaloguje aktualizaci dat uživatelského účtu.
     *
     * @param email e-mailová adresa uživatele
     */
    public void logUserUpdated(String email) {
        this.info("Aktualizována data uživatele: {}", email);
    }

    /**
     * Zaloguje smazání uživatelského účtu.
     *
     * @param email e-mailová adresa smazaného uživatele
     */
    public void logUserDeleted(String email) {
        this.info("Smazán uživatel: {}", email);
    }

    /**
     * Zaloguje úspěšnou změnu hesla uživatele.
     *
     * @param email e-mailová adresa uživatele
     */
    public void logPasswordChanged(String email) {
        this.info("Uživatel '{}' si úspěšně změnil heslo.", email);
    }

    /**
     * Zaloguje přiřazení nové role uživateli.
     *
     * @param email e-mailová adresa uživatele
     * @param role  název přiřazené role
     */
    public void logRoleAssigned(String email, String role) {
        this.info("Uživateli '{}' byla přidělena role '{}'.", email, role);
    }

    /**
     * Zaloguje pokus o přiřazení role, která je uživateli již přiřazena.
     *
     * @param email  e-mailová adresa uživatele
     * @param role   název role
     * @param userId ID uživatele
     */
    public void logRoleAlreadyAssigned(String email, String role, Long userId) {
        this.info("Role '{}' již byla uživateli '{}' (ID: {}) přidělena.", role, email, userId);
    }

    /**
     * Zaloguje odebrání role uživateli.
     *
     * @param email e-mailová adresa uživatele
     * @param role  název odebrané role
     */
    public void logRoleRemoved(String email, String role) {
        this.info("Uživateli '{}' byla odebrána role '{}'.", email, role);
    }

    /**
     * Zaloguje vytvoření nové systémové role.
     *
     * @param name název vytvořené role
     * @param id   ID nové role
     */
    public void logRoleCreated(String name, Long id) {
        this.info("Vytvořena nová role: {} (ID: {}).", name, id);
    }

    /**
     * Zaloguje aktualizaci systémové role.
     *
     * @param name název aktualizované role
     * @param id   ID role
     */
    public void logRoleUpdated(String name, Long id) {
        this.info("Aktualizována role: {} (ID: {}).", name, id);
    }

    /**
     * Zaloguje smazání systémové role.
     *
     * @param name název smazané role
     * @param id   ID role
     */
    public void logRoleDeleted(String name, Long id) {
        this.info("Smazána role: {} (ID: {}).", name, id);
    }

    /**
     * Zaloguje registraci nového zařízení pro uživatele.
     *
     * @param deviceId identifikátor zařízení
     * @param email    e-mailová adresa vlastníka
     */
    public void logDeviceRegistered(String deviceId, String email) {
        this.info("Registrováno nové zařízení '{}' pro uživatele '{}'.", deviceId, email);
    }

    /**
     * Zaloguje odebrání zařízení uživatele.
     *
     * @param deviceId identifikátor odebraného zařízení
     * @param email    e-mailová adresa vlastníka
     */
    public void logDeviceRemoved(String deviceId, String email) {
        this.info("Odstraněno zařízení '{}' uživatele '{}'.", deviceId, email);
    }

    /**
     * Zaloguje hromadné odebrání zařízení uživatele.
     *
     * @param email e-mailová adresa uživatele
     * @param count počet odebraných zařízení
     */
    public void logAllDevicesRemoved(String email, int count) {
        this.info("Odstraněno {} zařízení uživatele '{}'.", count, email);
    }
}