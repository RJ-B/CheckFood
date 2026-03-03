package com.checkfood.checkfoodservice.security.module.user.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro operace v modulu User.
 * Slouží POUZE pro logování úspěšných operací (Happy Path).
 */
@Component
public class UserLogger extends SecurityLogger {

    // --- USER OPERATIONS ---

    public void logUserCreated(String email) {
        this.info("Vytvořen nový uživatel: {}", email);
    }

    public void logUserUpdated(String email) {
        this.info("Aktualizována data uživatele: {}", email);
    }

    public void logUserDeleted(String email) {
        this.info("Smazán uživatel: {}", email);
    }

    public void logPasswordChanged(String email) {
        this.info("Uživatel '{}' si úspěšně změnil heslo.", email);
    }

    // --- ROLE ASSIGNMENT ---

    public void logRoleAssigned(String email, String role) {
        this.info("Uživateli '{}' byla přidělena role '{}'.", email, role);
    }

    // ✅ PŘIDÁNO: Chybějící metoda pro UserService
    public void logRoleAlreadyAssigned(String email, String role, Long userId) {
        this.info("Role '{}' již byla uživateli '{}' (ID: {}) přidělena.", role, email, userId);
    }

    public void logRoleRemoved(String email, String role) {
        this.info("Uživateli '{}' byla odebrána role '{}'.", email, role);
    }

    // --- ROLE MANAGEMENT (RoleService) ---

    // ✅ PŘIDÁNO: Chybějící metody pro RoleService
    public void logRoleCreated(String name, Long id) {
        this.info("Vytvořena nová role: {} (ID: {}).", name, id);
    }

    // ✅ PŘIDÁNO
    public void logRoleUpdated(String name, Long id) {
        this.info("Aktualizována role: {} (ID: {}).", name, id);
    }

    // ✅ PŘIDÁNO
    public void logRoleDeleted(String name, Long id) {
        this.info("Smazána role: {} (ID: {}).", name, id);
    }

    // --- DEVICE MANAGEMENT ---

    public void logDeviceRegistered(String deviceId, String email) {
        this.info("Registrováno nové zařízení '{}' pro uživatele '{}'.", deviceId, email);
    }

    public void logDeviceRemoved(String deviceId, String email) {
        this.info("Odstraněno zařízení '{}' uživatele '{}'.", deviceId, email);
    }

    public void logAllDevicesRemoved(String email, int count) {
        this.info("Odstraněno {} zařízení uživatele '{}'.", count, email);
    }
}