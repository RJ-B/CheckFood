package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.auth.validator.PasswordValidator;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Kompletní implementace servisní vrstvy pro správu uživatelů (JDK 21).
 *
 * Změny:
 * - Odstraněny audity a závislosti na HTTP requestu.
 * - Logování pouze úspěšných změn stavu (Happy Path).
 * - Výjimky se nelogují zde, ale v Exception Handleru.
 * - Použití 'var' pro lepší čitelnost.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final PasswordValidator passwordValidator;
    private final RoleService roleService;
    private final UserMapper userMapper;
    private final UserLogger userLogger;

    @Override
    public UserEntity save(UserEntity user) {
        boolean isNew = (user.getId() == null);

        var saved = userRepository.save(user);

        if (isNew) {
            userLogger.logUserCreated(saved.getEmail());
        } else {
            userLogger.logUserUpdated(saved.getEmail());
        }

        return saved;
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> UserException.userNotFoundById(id));
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> UserException.userNotFound(email));
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findWithAllDetailsByEmail(String email) {
        return userRepository.findWithAllDetailsByEmail(email)
                .orElseThrow(() -> UserException.userWithDetailsNotFound(email));
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findWithRolesByEmail(String email) {
        return userRepository.findWithRolesByEmail(email)
                .orElseThrow(() -> UserException.userWithRolesNotFound(email));
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public List<UserEntity> findAll() {
        return userRepository.findAll();
    }

    @Override
    public void changePassword(Long userId, String currentPassword, String newPassword) {
        var user = findById(userId);

        // 1. Ověření starého hesla
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            // Vyhazujeme chybu, logování řeší handler
            throw UserException.invalidOperation("Stávající heslo není správné.");
        }

        // 2. Validace nového hesla
        passwordValidator.validate(newPassword);

        // 3. Uložení
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        userLogger.logPasswordChanged(user.getEmail());
    }

    @Override
    public UserEntity updateProfile(String email, UpdateProfileRequest updateRequest) {
        // Načteme uživatele (používáme metodu s detaily pro jistotu fetchování vztahů)
        var user = findWithAllDetailsByEmail(email);

        // Mapování změn z DTO do Entity
        userMapper.updateEntityFromRequest(updateRequest, user);

        var saved = userRepository.save(user);

        userLogger.logUserUpdated(email);

        return saved;
    }

    @Override
    public void assignRole(Long userId, String roleName) {
        var user = findById(userId);
        var role = roleService.findByName(roleName);

        // Set.add vrací true, pokud prvek ještě nebyl v množině
        if (user.getRoles().add(role)) {
            userRepository.save(user);
            userLogger.logRoleAssigned(user.getEmail(), roleName);
        } else {
            // Role už byla přiřazena - logujeme jako info/debug, ale nechybujeme
            userLogger.logRoleAlreadyAssigned(user.getEmail(), roleName, userId);
        }
    }
}