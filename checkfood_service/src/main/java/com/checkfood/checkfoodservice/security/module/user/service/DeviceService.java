package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.user.dto.response.DeviceResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.NotificationPreferenceResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;

import java.util.List;
import java.util.Optional;

/**
 * Kontrakt pro správu životního cyklu klientských zařízení a jejich relací.
 * Definuje operace pro orchestraci bezpečnostních mechanismů navázaných na konkrétní terminály.
 * Zajišťuje integritu Refresh tokenů skrze perzistentní sledování aktivních session.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface DeviceService {

    /**
     * Zajišťuje synchronizaci stavu zařízení v databázi.
     * Provádí aktualizaci metadat pro existující relace nebo inicializaci nových záznamů.
     *
     * @param device transportní entita zařízení
     * @return synchronizovaná perzistentní entita
     */
    DeviceEntity save(DeviceEntity device);

    /**
     * Resolvuje zařízení na základě primárního klíče.
     *
     * @param id interní identifikátor záznamu
     * @return Optional s entitou zařízení
     */
    Optional<DeviceEntity> findById(Long id);

    /**
     * Resolvuje zařízení na základě unikátního klientského identifikátoru.
     *
     * @param deviceIdentifier řetězec jednoznačně identifikující HW/SW terminál
     * @return Optional s entitou zařízení
     */
    Optional<DeviceEntity> findByIdentifier(String deviceIdentifier);

    /**
     * Agreguje všechna aktivní i historická zařízení asociovaná s konkrétní identitou.
     * Používá se pro přehled aktivních relací v uživatelském profilu.
     *
     * @param user vlastník zařízení
     * @return kolekce registrovaných zařízení
     */
    List<DeviceEntity> findAllByUser(UserEntity user);

    /**
     * Vrátí seznam zařízení převedený na DTO s příznakem aktuálního zařízení.
     * Porovná deviceIdentifier s identifikátorem v Access Tokenu a označí současné zařízení.
     *
     * @param email       emailová adresa uživatele
     * @param accessToken JWT access token obsahující deviceIdentifier
     * @return seznam zařízení s označením aktuálního terminálu
     */
    List<DeviceResponse> findAllUserDevicesWithStatus(String email, String accessToken);

    /**
     * Verifikuje vazbu mezi identifikátorem relace a uživatelským subjektem.
     * Kritická komponenta pro prevenci "Session Hijacking" při rotaci Refresh tokenů.
     *
     * @param identifier klientský identifikátor zařízení
     * @param user subjekt uplatňující nárok na relaci
     * @return true v případě validní a existující vazby
     */
    boolean existsByIdentifierAndUser(String identifier, UserEntity user);

    /**
     * Aktualizuje časovou značku posledního přihlášení a interakce zařízení.
     * Zahrnuje refresh metadat jako je aktuální IP adresa pro auditní účely.
     *
     * @param identifier identifikátor zařízení k aktualizaci
     */
    void updateLastLogin(String identifier);

    /**
     * Okamžitá terminace relace na základě identifikátoru.
     * Slouží k invalidaci všech bezpečnostních artefaktů vydaných pro daný terminál.
     *
     * @param deviceIdentifier identifikátor zařízení k odstranění
     */
    void deleteByIdentifier(String deviceIdentifier);

    /**
     * Autorizované odstranění specifické relace se striktní kontrolou vlastnictví.
     * Zabraňuje neautorizované manipulaci s cizími relacemi v rámci multi-device prostředí.
     *
     * @param deviceId interní ID zařízení
     * @param user subjekt provádějící operaci
     * @throws UserException pokud cílová relace neexistuje nebo došlo k porušení vlastnictví
     */
    void removeByIdAndUser(Long deviceId, UserEntity user);

    /**
     * Autorizované odstranění relace pomocí String identifikátoru.
     * Bezpečnější alternativa k removeByIdAndUser, která neodhaluje interní Long ID.
     * Umožňuje frontendové aplikaci odstranit zařízení pomocí UUID identifikátoru.
     *
     * @param deviceIdentifier String identifikátor zařízení (UUID)
     * @param user             subjekt provádějící operaci
     * @throws UserException pokud cílová relace neexistuje nebo nepatří danému uživateli
     */
    void removeByIdentifierAndUser(String deviceIdentifier, UserEntity user);

    /**
     * Hromadná invalidace veškerých aktivních relací uživatele.
     * Využívá se pro bezpečnostní "Emergency Logout" napříč všemi terminály.
     *
     * @param user uživatel, jehož relace mají být terminovány
     */
    void removeAllByUser(UserEntity user);

    /**
     * Odhlásí všechna zařízení uživatele kromě aktuálního.
     * Používá se v profilu při akci "Odhlásit ostatní zařízení".
     *
     * @param user uživatel
     * @param currentDeviceIdentifier identifikátor aktuálního zařízení (zachová se)
     */
    void removeAllByUserExceptCurrent(UserEntity user, String currentDeviceIdentifier);

    /**
     * Deaktivuje zařízení pomocí identifikátoru (soft-logout).
     * Záznam zůstane v DB s isActive = false.
     *
     * @param deviceIdentifier identifikátor zařízení
     * @param user vlastník zařízení
     */
    void deactivateByIdentifierAndUser(String deviceIdentifier, UserEntity user);

    /**
     * Deaktivuje konkrétní zařízení podle ID (soft-logout).
     * Záznam zůstane v DB s isActive = false.
     *
     * @param deviceId interní ID zařízení
     * @param user vlastník zařízení
     */
    void deactivateByIdAndUser(Long deviceId, UserEntity user);

    /**
     * Deaktivuje všechna zařízení uživatele kromě aktuálního (bulk soft-logout).
     * Záznamy zůstanou v DB s isActive = false.
     *
     * @param user uživatel
     * @param currentDeviceIdentifier identifikátor aktuálního zařízení (zachová se aktivní)
     */
    void deactivateAllByUserExceptCurrent(UserEntity user, String currentDeviceIdentifier);

    /**
     * Aktualizuje FCM token a preference notifikaci pro dane zarizeni.
     *
     * @param deviceIdentifier identifikator zarizeni
     * @param user vlastnik zarizeni
     * @param fcmToken FCM token (muze byt null pri vypnuti)
     * @param notificationsEnabled true = zapnout, false = vypnout
     * @return aktualni stav notifikaci
     */
    NotificationPreferenceResponse updateNotificationPreference(
            String deviceIdentifier, UserEntity user, String fcmToken, boolean notificationsEnabled);

    /**
     * Zjisti stav notifikaci pro dane zarizeni.
     *
     * @param deviceIdentifier identifikator zarizeni
     * @param user vlastnik zarizeni
     * @return aktualni stav notifikaci
     */
    NotificationPreferenceResponse getNotificationPreference(String deviceIdentifier, UserEntity user);
}