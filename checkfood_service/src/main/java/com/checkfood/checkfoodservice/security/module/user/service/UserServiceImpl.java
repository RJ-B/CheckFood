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
 * Implementace servisní vrstvy pro správu uživatelských účtů, hesel a rolí.
 * Logování probíhá výhradně pro úspěšné operace, výjimky jsou logovány v exception handleru.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserService
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

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw UserException.invalidOperation("Stávající heslo není správné.");
        }

        passwordValidator.validate(newPassword);

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        userLogger.logPasswordChanged(user.getEmail());
    }

    @Override
    public UserEntity updateProfile(String email, UpdateProfileRequest updateRequest) {
        var user = findWithAllDetailsByEmail(email);

        userMapper.updateEntityFromRequest(updateRequest, user);

        var saved = userRepository.save(user);

        userLogger.logUserUpdated(email);

        return saved;
    }

    @Override
    public void assignRole(Long userId, String roleName) {
        var user = findById(userId);
        var role = roleService.findByName(roleName);

        if (user.getRoles().add(role)) {
            userRepository.save(user);
            userLogger.logRoleAssigned(user.getEmail(), roleName);
        } else {
            userLogger.logRoleAlreadyAssigned(user.getEmail(), roleName, userId);
        }
    }

    @Override
    public void removeRole(Long userId, String roleName) {
        var user = findById(userId);
        var role = roleService.findByName(roleName);

        if (user.getRoles().remove(role)) {
            userRepository.save(user);
            userLogger.logRoleRemoved(user.getEmail(), roleName);
        }
    }
}