package com.checkfood.checkfoodservice.security.module.user.controller;

import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.dto.request.AssignRoleRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.ChangePasswordRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateNotificationRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.response.DeviceResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.NotificationPreferenceResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserAdminResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserProfileResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserSummaryResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.module.user.service.DeviceService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import com.checkfood.checkfoodservice.security.module.user.validator.ChangePasswordValidator;
import com.checkfood.checkfoodservice.security.module.user.validator.UpdateProfileValidator;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST kontroler pro správu uživatelských účtů a profilů.
 * Poskytuje endpointy pro zobrazení profilu, změnu hesla, aktualizaci profilu a správu zařízení.
 * Admin endpointy jsou chráněny {@code @PreAuthorize("hasRole('ADMIN')")}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserService
 * @see DeviceService
 */
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final DeviceService deviceService;
    private final JwtService jwtService;
    private final UserMapper userMapper;
    private final ChangePasswordValidator changePasswordValidator;
    private final UpdateProfileValidator updateProfileValidator;

    /**
     * Vrátí profilové informace o přihlášeném uživateli.
     * Seznam zařízení není součástí profilu, je dostupný přes {@code /devices}.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @return detailní profilová data uživatele
     */
    @GetMapping("/me")
    public ResponseEntity<UserProfileResponse> getProfile(
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        UserEntity user = userService.findWithAllDetailsByEmail(userDetails.getUsername());
        return ResponseEntity.ok(userMapper.toProfile(user));
    }

    /**
     * Změní heslo přihlášeného uživatele.
     * Validuje současné heslo, sílu nového hesla a shodu s potvrzením.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @param request obsahuje současné heslo, nové heslo a potvrzení
     * @return HTTP 204 No Content po úspěšné změně
     */
    @PostMapping("/change-password")
    public ResponseEntity<Void> changePassword(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody ChangePasswordRequest request
    ) {
        changePasswordValidator.validate(request);
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        userService.changePassword(user.getId(), request.getCurrentPassword(), request.getNewPassword());

        return ResponseEntity.noContent().build();
    }

    /**
     * Aktualizuje profilové informace přihlášeného uživatele.
     * Umožňuje změnu jména a dalších profilových údajů.
     * Používá PATCH pro částečnou aktualizaci.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @param request data pro aktualizaci profilu
     * @return aktualizovaný profil uživatele
     */
    @PatchMapping("/profile")
    public ResponseEntity<UserProfileResponse> updateProfile(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody UpdateProfileRequest request
    ) {
        updateProfileValidator.validate(request);

        UserEntity updatedUser = userService.updateProfile(userDetails.getUsername(), request);

        return ResponseEntity.ok(userMapper.toProfile(updatedUser));
    }

    /**
     * Vrátí seznam všech uživatelů v systému (admin endpoint).
     * Obsahuje pouze základní informace pro přehled.
     *
     * @return seznam uživatelů se základními informacemi
     */
    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<List<UserSummaryResponse>> getAllUsers() {
        List<UserSummaryResponse> users = userService.findAll()
                .stream()
                .map(userMapper::toSummary)
                .toList();
        return ResponseEntity.ok(users);
    }

    /**
     * Vrátí detailní informace o konkrétním uživateli (admin endpoint).
     * Obsahuje kompletní informace včetně všech rolí.
     *
     * @param id ID uživatele
     * @return detailní informace o uživateli
     */
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<UserAdminResponse> getUserById(@PathVariable Long id) {
        UserEntity user = userService.findById(id);
        return ResponseEntity.ok(userMapper.toAdmin(user));
    }

    /**
     * Přiřadí roli uživateli (admin endpoint).
     * Používá se pro správu oprávnění v admin rozhraní.
     *
     * @param request obsahuje ID uživatele a název role
     * @return HTTP 200 OK po úspěšném přiřazení
     */
    @PostMapping("/assign-role")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> assignRole(@Valid @RequestBody AssignRoleRequest request) {
        userService.assignRole(request.getUserId(), request.getRoleName());
        return ResponseEntity.ok().build();
    }

    /**
     * Odhlásí uživatele ze všech ostatních zařízení (soft-logout — deaktivace, zachování v DB).
     * Zachová aktuální zařízení (identifikované z JWT tokenu) aktivní.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @param token Authorization header pro identifikaci aktuálního zařízení
     * @return HTTP 204 No Content po úspěšném odhlášení
     */
    @PostMapping("/logout-all")
    public ResponseEntity<Void> logoutAll(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String token
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        String currentDeviceIdentifier = jwtService.extractDeviceIdentifier(token);
        deviceService.deactivateAllByUserExceptCurrent(user, currentDeviceIdentifier);
        return ResponseEntity.noContent().build();
    }

    /**
     * Fyzicky smaže všechna zařízení uživatele kromě aktuálního.
     * Hard-delete — záznamy jsou odstraněny z DB.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @param token Authorization header pro identifikaci aktuálního zařízení
     * @return HTTP 204 No Content po úspěšném smazání
     */
    @DeleteMapping("/devices/all")
    public ResponseEntity<Void> deleteAllDevices(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String token
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        String currentDeviceIdentifier = jwtService.extractDeviceIdentifier(token);
        deviceService.removeAllByUserExceptCurrent(user, currentDeviceIdentifier);
        return ResponseEntity.noContent().build();
    }

    /**
     * Vrátí seznam všech zařízení přihlášeného uživatele s příznakem aktuální session.
     * Příznak {@code currentDevice = true} je nastaven na základě deviceIdentifier z JWT tokenu.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @param token       Authorization header pro identifikaci aktuálního zařízení
     * @return seznam zařízení s označením aktuálního terminálu
     */
    @GetMapping("/devices")
    public ResponseEntity<List<DeviceResponse>> getUserDevices(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String token
    ) {
        List<DeviceResponse> devices = deviceService.findAllUserDevicesWithStatus(
                userDetails.getUsername(),
                token
        );
        return ResponseEntity.ok(devices);
    }

    /**
     * Soft-logout konkrétního zařízení — deaktivuje zařízení (isActive = false), zachová v DB.
     * Používá se pro vzdálené odhlášení z jiného zařízení bez fyzického smazání záznamu.
     *
     * @param deviceId ID zařízení k deaktivaci
     * @param userDetails autentizační detaily z Security kontextu
     * @return HTTP 204 No Content po úspěšné deaktivaci
     */
    @PostMapping("/devices/{deviceId}/logout")
    public ResponseEntity<Void> logoutDevice(
            @PathVariable Long deviceId,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String token
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        String currentDeviceIdentifier = jwtService.extractDeviceIdentifier(token);
        deviceService.findById(deviceId).ifPresent(device -> {
            if (device.getDeviceIdentifier().equals(currentDeviceIdentifier)) {
                throw com.checkfood.checkfoodservice.security.module.user.exception.UserException
                        .invalidOperation("Nelze odhlásit aktuální zařízení. Použijte standardní odhlášení.");
            }
        });
        deviceService.deactivateByIdAndUser(deviceId, user);
        return ResponseEntity.noContent().build();
    }

    /**
     * Hard-delete konkrétního zařízení — fyzicky odstraní záznam z DB.
     * Ověřuje vlastnictví zařízení před smazáním.
     *
     * @param deviceId ID zařízení k odstranění
     * @param userDetails autentizační detaily z Security kontextu
     * @return HTTP 204 No Content po úspěšném odstranění
     */
    @DeleteMapping("/devices/{deviceId}")
    public ResponseEntity<Void> deleteDevice(
            @PathVariable Long deviceId,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String token
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        String currentDeviceIdentifier = jwtService.extractDeviceIdentifier(token);
        deviceService.findById(deviceId).ifPresent(device -> {
            if (device.getDeviceIdentifier().equals(currentDeviceIdentifier)) {
                throw com.checkfood.checkfoodservice.security.module.user.exception.UserException
                        .invalidOperation("Nelze smazat aktuální zařízení. Použijte standardní odhlášení.");
            }
        });
        deviceService.removeByIdAndUser(deviceId, user);
        return ResponseEntity.noContent().build();
    }

    /**
     * Aktualizuje preferenci push notifikaci a FCM token pro dane zarizeni.
     * Pouziva se pri zapnuti/vypnuti notifikaci v profilu uzivatele.
     *
     * @param userDetails autentizacni detaily z Security kontextu
     * @param request obsahuje deviceIdentifier, fcmToken a notificationsEnabled
     * @return aktualni stav notifikaci pro zarizeni
     */
    @PutMapping("/devices/notifications")
    public ResponseEntity<NotificationPreferenceResponse> updateNotificationPreference(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody UpdateNotificationRequest request
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        NotificationPreferenceResponse response = deviceService.updateNotificationPreference(
                request.getDeviceIdentifier(),
                user,
                request.getFcmToken(),
                request.getNotificationsEnabled()
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Zjisti stav push notifikaci pro dane zarizeni.
     * Pouziva se pri inicializaci profilu pro nastaveni stavu switche.
     *
     * @param userDetails autentizacni detaily z Security kontextu
     * @param deviceIdentifier identifikator zarizeni (query param)
     * @return aktualni stav notifikaci
     */
    @GetMapping("/devices/notifications")
    public ResponseEntity<NotificationPreferenceResponse> getNotificationPreference(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam String deviceIdentifier
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        NotificationPreferenceResponse response = deviceService.getNotificationPreference(
                deviceIdentifier, user
        );
        return ResponseEntity.ok(response);
    }
}