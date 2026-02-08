package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.module.auth.validator.PasswordValidator;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Implementace user servisu pro správu uživatelských účtů a profilů.
 * Zajišťuje CRUD operace, změnu hesla, aktualizaci profilů a správu rolí.
 * Všechny operace jsou auditovány a logovány pro bezpečnostní účely.
 *
 * @see UserService
 * @see UserRepository
 * @see UserLogger
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
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;
    private final UserLogger userLogger;

    /**
     * Uloží nebo aktualizuje uživatelskou entitu.
     *
     * @param user uživatelská entita k uložení
     * @return uložená entita s vygenerovaným ID
     */
    @Override
    public UserEntity save(UserEntity user) {
        userLogger.logUserCreated(user.getEmail());
        return userRepository.save(user);
    }

    /**
     * Najde uživatele podle ID.
     *
     * @param id ID uživatele
     * @return nalezená uživatelská entita
     * @throws UserException pokud uživatel není nalezen
     */
    @Override
    @Transactional(readOnly = true)
    public UserEntity findById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> {
                    userLogger.logUserNotFound("ID: " + id);
                    return UserException.userNotFoundById(id);
                });
    }

    /**
     * Najde uživatele podle emailové adresy.
     * Načítá pouze základní data bez vztahů (lazy loading).
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita
     * @throws UserException pokud uživatel není nalezen
     */
    @Override
    @Transactional(readOnly = true)
    public UserEntity findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> {
                    userLogger.logUserNotFound(email);
                    return UserException.userNotFound(email);
                });
    }

    /**
     * Najde uživatele včetně všech vztahů (role, zařízení) v jednom dotazu.
     * Používá EntityGraph pro optimalizaci výkonu (prevence N+1).
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita s eager načtenými vztahy
     * @throws UserException pokud uživatel není nalezen
     */
    @Override
    @Transactional(readOnly = true)
    public UserEntity findWithAllDetailsByEmail(String email) {
        return userRepository.findWithAllDetailsByEmail(email)
                .orElseThrow(() -> {
                    userLogger.logUserNotFound(email);
                    return UserException.userNotFound(email);
                });
    }

    /**
     * Najde uživatele včetně rolí v jednom dotazu.
     * Kritické pro Spring Security autentizaci a autorizaci.
     * Používá EntityGraph pro prevenci N+1 problému.
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita s eager načtenými rolemi
     * @throws UserException pokud uživatel není nalezen
     */
    @Override
    @Transactional(readOnly = true)
    public UserEntity findWithRolesByEmail(String email) {
        return userRepository.findWithRolesByEmail(email)
                .orElseThrow(() -> {
                    userLogger.logUserNotFound(email);
                    return UserException.userNotFound(email);
                });
    }

    /**
     * Ověří existenci uživatele s danou emailovou adresou.
     *
     * @param email emailová adresa k ověření
     * @return true pokud uživatel existuje, jinak false
     */
    @Override
    @Transactional(readOnly = true)
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    /**
     * Vrátí seznam všech uživatelů v systému.
     *
     * @return seznam všech uživatelů
     */
    @Override
    @Transactional(readOnly = true)
    public List<UserEntity> findAll() {
        return userRepository.findAll();
    }

    /**
     * Změní heslo uživatele po ověření současného hesla.
     * Validuje sílu nového hesla a zajišťuje shodu s potvrzením.
     * Operace je auditována pro bezpečnostní účely.
     *
     * @param userId ID uživatele
     * @param currentPassword současné heslo pro ověření
     * @param newPassword nové heslo
     * @param confirmPassword potvrzení nového hesla
     * @throws UserException pokud současné heslo není správné nebo nová hesla se neshodují
     */
    @Override
    public void changePassword(Long userId, String currentPassword, String newPassword, String confirmPassword) {
        UserEntity user = findById(userId);

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            publishAudit(userId, AuditAction.PASSWORD_CHANGED, AuditStatus.FAILED);
            throw UserException.invalidOperation("Stávající heslo není správné.");
        }

        if (!newPassword.equals(confirmPassword)) {
            publishAudit(userId, AuditAction.PASSWORD_CHANGED, AuditStatus.FAILED);
            throw UserException.invalidOperation("Nová hesla se neshodují.");
        }

        passwordValidator.validate(newPassword);

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        userLogger.logPasswordChanged(user.getEmail());
        publishAudit(userId, AuditAction.PASSWORD_CHANGED, AuditStatus.SUCCESS);
    }

    /**
     * Aktualizuje profilové informace uživatele.
     * Načítá uživatele včetně vztahů pro úplnou aktualizaci.
     * Používá UserMapper pro automatizované mapování z DTO na entitu.
     *
     * @param email emailová adresa uživatele
     * @param updateRequest data pro aktualizaci profilu
     * @return aktualizovaná uživatelská entita
     */
    @Override
    public UserEntity updateProfile(String email, UpdateProfileRequest updateRequest) {
        UserEntity user = findWithAllDetailsByEmail(email);

        userMapper.updateEntityFromRequest(updateRequest, user);

        UserEntity saved = userRepository.save(user);

        userLogger.logUserUpdated(email);
        publishAudit(user.getId(), AuditAction.PROFILE_UPDATED, AuditStatus.SUCCESS);

        return saved;
    }

    /**
     * Přiřadí roli uživateli.
     * Používá se v admin rozhraní pro správu oprávnění.
     *
     * @param userId ID uživatele
     * @param roleName název role k přiřazení
     */
    @Override
    public void assignRole(Long userId, String roleName) {
        UserEntity user = findById(userId);
        RoleEntity role = roleService.findByName(roleName);

        user.getRoles().add(role);
        userRepository.save(user);

        userLogger.logUserUpdated(user.getEmail());
    }

    /**
     * Publikuje auditní událost do event systému.
     * Událost obsahuje informace o akci, statusu, uživateli a kontextu požadavku.
     *
     * @param userId ID uživatele
     * @param action typ provedené akce
     * @param status výsledek akce
     */
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