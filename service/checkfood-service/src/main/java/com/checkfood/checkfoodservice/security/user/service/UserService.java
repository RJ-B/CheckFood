package com.checkfood.checkfoodservice.security.user.service;

import com.checkfood.checkfoodservice.security.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import java.util.List;

public interface UserService {

    UserEntity save(UserEntity user);

    UserEntity findById(Long id);

    UserEntity findByEmail(String email);

    UserEntity findWithRolesByEmail(String email);

    // --- PŘIDÁNO: Metoda pro kompletní profil ---
    /**
     * Najde uživatele včetně rolí a zařízení (pro endpoint /me).
     */
    UserEntity findWithAllDetailsByEmail(String email);
    // --------------------------------------------

    boolean existsByEmail(String email);

    List<UserEntity> findAll();

    void changePassword(Long userId, String currentPassword, String newPassword, String confirmPassword);

    UserEntity updateProfile(String email, UpdateProfileRequest request);

    void assignRole(Long userId, String roleName);
}