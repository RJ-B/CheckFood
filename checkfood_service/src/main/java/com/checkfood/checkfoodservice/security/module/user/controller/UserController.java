package com.checkfood.checkfoodservice.security.module.user.controller;

import com.checkfood.checkfoodservice.security.module.user.dto.request.AssignRoleRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.ChangePasswordRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
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
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST kontroler pro správu uživatelských účtů a profilů.
 * Poskytuje endpointy pro zobrazení profilu, změnu hesla, aktualizaci profilu a správu zařízení.
 * Admin endpointy jsou chráněny @PreAuthorize("hasRole('ADMIN')").
 *
 * @see UserService
 * @see DeviceService
 */
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final DeviceService deviceService;
    private final UserMapper userMapper;
    private final ChangePasswordValidator changePasswordValidator;
    private final UpdateProfileValidator updateProfileValidator;

    /**
     * Vrátí kompletní profil přihlášeného uživatele.
     * Načítá data včetně rolí a registrovaných zařízení pomocí optimalizovaného dotazu.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @return profilová odpověď s kompletními informacemi o uživateli
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

        userService.changePassword(
                user.getId(),
                request.getCurrentPassword(),
                request.getNewPassword(),
                request.getConfirmPassword()
        );

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
     * Odhlásí uživatele ze všech zařízení najednou.
     * Invaliduje všechny refresh tokeny smazáním všech záznamů o zařízeních.
     * Používá se při podezření na kompromitaci účtu.
     *
     * @param userDetails autentizační detaily z Security kontextu
     * @return HTTP 204 No Content po úspěšném odhlášení
     */
    @PostMapping("/logout-all")
    public ResponseEntity<Void> logoutAll(@AuthenticationPrincipal UserDetails userDetails) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        deviceService.removeAllByUser(user);
        return ResponseEntity.noContent().build();
    }

    /**
     * Odhlásí konkrétní zařízení uživatele.
     * Používá se pro selektivní ukončení relace z určitého zařízení.
     * Ověřuje vlastnictví zařízení před smazáním.
     *
     * @param deviceId ID zařízení k odstranění
     * @param userDetails autentizační detaily z Security kontextu
     * @return HTTP 204 No Content po úspěšném odstranění
     */
    @DeleteMapping("/devices/{deviceId}")
    public ResponseEntity<Void> logoutDevice(
            @PathVariable Long deviceId,
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        deviceService.removeByIdAndUser(deviceId, user);
        return ResponseEntity.noContent().build();
    }
}