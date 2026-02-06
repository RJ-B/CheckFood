package com.checkfood.checkfoodservice.security.user.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.auth.validator.PasswordValidator;
import com.checkfood.checkfoodservice.security.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.exception.UserNotFoundException;
import com.checkfood.checkfoodservice.security.user.mapper.UserMapper; // Přidáno
import com.checkfood.checkfoodservice.security.user.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final PasswordValidator passwordValidator;
    private final RoleService roleService;
    private final UserMapper userMapper; // Přidáno pro automatizaci update
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;

    @Override
    public UserEntity save(UserEntity user) {
        log.debug("Ukládání uživatele: {}", user.getEmail());
        return userRepository.save(user);
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("Uživatel s ID " + id + " nebyl nalezen."));
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new UserNotFoundException("Uživatel s emailem " + email + " nebyl nalezen."));
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findWithAllDetailsByEmail(String email) {
        return userRepository.findWithAllDetailsByEmail(email)
                .orElseThrow(() -> new UserNotFoundException("Uživatel s emailem " + email + " nebyl nalezen."));
    }

    @Override
    @Transactional(readOnly = true)
    public UserEntity findWithRolesByEmail(String email) {
        return userRepository.findWithRolesByEmail(email)
                .orElseThrow(() -> new UserNotFoundException("Uživatel s emailem " + email + " nebyl nalezen."));
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
    public void changePassword(Long userId, String currentPassword, String newPassword, String confirmPassword) {
        UserEntity user = findById(userId);

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            publishAudit(userId, AuditAction.PASSWORD_CHANGED, AuditStatus.FAILED);
            throw new IllegalArgumentException("Stávající heslo není správné.");
        }

        if (!newPassword.equals(confirmPassword)) {
            publishAudit(userId, AuditAction.PASSWORD_CHANGED, AuditStatus.FAILED);
            throw new IllegalArgumentException("Nová hesla se neshodují.");
        }

        passwordValidator.validate(newPassword);

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        log.info("Heslo úspěšně změněno pro uživatele: {}", user.getEmail());
        publishAudit(userId, AuditAction.PASSWORD_CHANGED, AuditStatus.SUCCESS);
    }

    @Override
    public UserEntity updateProfile(String email, UpdateProfileRequest updateRequest) {
        // ZMĚNA: Načteme uživatele rovnou i s rolemi a zařízeními (EntityGraph)
        UserEntity user = findWithAllDetailsByEmail(email);

        // Mapování polí (firstName, lastName)
        userMapper.updateEntityFromRequest(updateRequest, user);

        UserEntity saved = userRepository.save(user);

        log.info("Profil aktualizován pro uživatele: {}", email);
        publishAudit(user.getId(), AuditAction.PROFILE_UPDATED, AuditStatus.SUCCESS);

        return saved;
    }

    @Override
    public void assignRole(Long userId, String roleName) {
        UserEntity user = findById(userId);
        RoleEntity role = roleService.findByName(roleName);

        user.getRoles().add(role);
        userRepository.save(user);

        log.info("Role {} byla přiřazena uživateli {}", roleName, user.getEmail());
    }

    private void publishAudit(Long userId, AuditAction action, AuditStatus status) {
        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        userId,
                        action,
                        status,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }
}