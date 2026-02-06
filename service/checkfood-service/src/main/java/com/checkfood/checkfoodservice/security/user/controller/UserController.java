package com.checkfood.checkfoodservice.security.user.controller;

import com.checkfood.checkfoodservice.security.user.dto.request.AssignRoleRequest;
import com.checkfood.checkfoodservice.security.user.dto.request.ChangePasswordRequest;
import com.checkfood.checkfoodservice.security.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.user.dto.response.UserAdminResponse;
import com.checkfood.checkfoodservice.security.user.dto.response.UserProfileResponse;
import com.checkfood.checkfoodservice.security.user.dto.response.UserSummaryResponse;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.user.service.DeviceService;
import com.checkfood.checkfoodservice.security.user.service.UserService;
import com.checkfood.checkfoodservice.security.user.validator.ChangePasswordValidator;
import com.checkfood.checkfoodservice.security.user.validator.UpdateProfileValidator;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST API Controller pro správu uživatelských účtů a profilů.
 */
@Slf4j
@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final DeviceService deviceService;
    private final UserMapper userMapper;

    private final ChangePasswordValidator changePasswordValidator;
    private final UpdateProfileValidator updateProfileValidator;

    @GetMapping("/me")
    public ResponseEntity<UserProfileResponse> getProfile(
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        // Načte uživatele včetně rolí a zařízení pomocí optimalizovaného dotazu
        UserEntity user = userService.findWithAllDetailsByEmail(userDetails.getUsername());
        return ResponseEntity.ok(userMapper.toProfile(user));
    }

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

    @PatchMapping("/profile") // Doporučeno PATCH pro částečnou aktualizaci
    public ResponseEntity<UserProfileResponse> updateProfile(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody UpdateProfileRequest request
    ) {
        updateProfileValidator.validate(request);

        UserEntity updatedUser = userService.updateProfile(userDetails.getUsername(), request);
        log.info("Uživatel {} aktualizoval svůj profil.", userDetails.getUsername());

        return ResponseEntity.ok(userMapper.toProfile(updatedUser));
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<List<UserSummaryResponse>> getAllUsers() {
        List<UserSummaryResponse> users = userService.findAll()
                .stream()
                .map(userMapper::toSummary)
                .toList();
        return ResponseEntity.ok(users);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<UserAdminResponse> getUserById(@PathVariable Long id) {
        UserEntity user = userService.findById(id);
        return ResponseEntity.ok(userMapper.toAdmin(user));
    }

    @PostMapping("/assign-role")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> assignRole(@Valid @RequestBody AssignRoleRequest request) {
        userService.assignRole(request.getUserId(), request.getRoleName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/logout-all")
    public ResponseEntity<Void> logoutAll(@AuthenticationPrincipal UserDetails userDetails) {
        UserEntity user = userService.findByEmail(userDetails.getUsername());
        deviceService.removeAllByUser(user);
        log.warn("Uživatel {} vynutil odhlášení ze všech zařízení.", user.getEmail());
        return ResponseEntity.noContent().build();
    }

    /**
     * Odhlásí konkrétní zařízení uživatele.
     * @param deviceId ID zařízení k odstranění
     * @param userDetails detaily přihlášeného uživatele pro ověření vlastnictví
     */
    @DeleteMapping("/devices/{deviceId}")
    public ResponseEntity<Void> logoutDevice(
            @PathVariable Long deviceId,
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        log.info("Uživatel {} požaduje odhlášení zařízení s ID: {}", userDetails.getUsername(), deviceId);

        // Získáme uživatele, abychom měli jistotu, že maže svoje zařízení
        UserEntity user = userService.findByEmail(userDetails.getUsername());

        // Voláme service pro bezpečné odstranění
        deviceService.removeByIdAndUser(deviceId, user);

        return ResponseEntity.noContent().build();
    }
}