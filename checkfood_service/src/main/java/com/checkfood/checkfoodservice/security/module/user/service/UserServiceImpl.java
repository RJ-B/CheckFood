package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionMemberRepository;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionRepository;
import com.checkfood.checkfoodservice.module.order.repository.OrderRepository;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaPhotoRepository;
import com.checkfood.checkfoodservice.module.panorama.repository.PanoramaSessionRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.RecurringReservationRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationChangeRequestRepository;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.favourite.repository.UserFavouriteRestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.TableGroupRepository;
import com.checkfood.checkfoodservice.security.audit.repository.AuditLogRepository;
import com.checkfood.checkfoodservice.security.module.auth.repository.PasswordResetTokenRepository;
import com.checkfood.checkfoodservice.security.module.auth.repository.VerificationTokenRepository;
import com.checkfood.checkfoodservice.security.module.auth.validator.PasswordValidator;
import com.checkfood.checkfoodservice.security.module.mfa.repository.MfaBackupCodeRepository;
import com.checkfood.checkfoodservice.security.module.mfa.repository.MfaSecretRepository;
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
import java.util.UUID;
import java.util.stream.Collectors;

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

    // Repozitáře pro GDPR mazání účtu
    private final VerificationTokenRepository verificationTokenRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final MfaSecretRepository mfaSecretRepository;
    private final MfaBackupCodeRepository mfaBackupCodeRepository;
    private final AuditLogRepository auditLogRepository;
    private final UserFavouriteRestaurantRepository userFavouriteRestaurantRepository;
    private final ReservationRepository reservationRepository;
    private final RecurringReservationRepository recurringReservationRepository;
    private final ReservationChangeRequestRepository reservationChangeRequestRepository;
    private final OrderRepository orderRepository;
    private final DiningSessionMemberRepository diningSessionMemberRepository;
    private final DiningSessionRepository diningSessionRepository;
    private final RestaurantEmployeeRepository restaurantEmployeeRepository;
    private final RestaurantRepository restaurantRepository;
    private final MenuCategoryRepository menuCategoryRepository;
    private final MenuItemRepository menuItemRepository;
    private final RestaurantTableRepository restaurantTableRepository;
    private final TableGroupRepository tableGroupRepository;
    private final PanoramaSessionRepository panoramaSessionRepository;
    private final PanoramaPhotoRepository panoramaPhotoRepository;

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
    public UserEntity findWithRolesById(Long id) {
        return userRepository.findWithRolesById(id)
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

    @Override
    @Transactional
    public void deleteAccount(Long userId) {
        var user = findById(userId);
        String email = user.getEmail();

        // 1. Pokud je uživatel OWNER — smaž všechny jeho restaurace a jejich data
        var ownerEntries = restaurantEmployeeRepository.findAllByUserIdAndRole(userId, RestaurantEmployeeRole.OWNER);
        for (var entry : ownerEntries) {
            deleteRestaurantData(entry.getRestaurant().getId());
        }

        // 2. Smaž data vázaná na uživatele (mimo FK cascade)
        // Reservation change requesty pro rezervace uživatele
        var userReservations = reservationRepository.findAllByUserIdOrderByDateDescStartTimeDesc(userId);
        if (!userReservations.isEmpty()) {
            var reservationIds = userReservations.stream()
                    .map(r -> r.getId())
                    .collect(Collectors.toList());
            reservationChangeRequestRepository.deleteAllByReservationIdIn(reservationIds);
        }

        // Opakující se rezervace uživatele
        recurringReservationRepository.deleteAllByUserId(userId);

        // Rezervace uživatele — ANONYMIZACE (zachovat pro statistiky restaurací)
        reservationRepository.anonymizeByUserId(userId);

        // Dining session membership uživatele
        diningSessionMemberRepository.deleteAllByUserId(userId);

        // Objednávky uživatele — ANONYMIZACE (zachovat pro statistiky restaurací)
        orderRepository.anonymizeByUserId(userId);

        // Oblíbené restaurace
        userFavouriteRestaurantRepository.deleteAllByUserId(userId);

        // MFA
        mfaBackupCodeRepository.deleteByUserId(userId);
        mfaSecretRepository.findByUserId(userId).ifPresent(mfaSecretRepository::delete);

        // Auth tokeny
        verificationTokenRepository.deleteByUserId(userId);
        passwordResetTokenRepository.deleteByUserId(userId);

        // Audit logy (nullable user_id — smaž přímo)
        auditLogRepository.deleteByUserId(userId);

        // Employee záznamy (ne-OWNER) — ostatní restaurace
        restaurantEmployeeRepository.deleteAllByUserId(userId);

        // 3. Smaž uživatele (cascade odstraní devices + user_roles)
        userRepository.delete(user);

        userLogger.logUserDeleted(email);
    }

    /**
     * Smaže všechna data restaurace v transakci (volá se při mazání vlastníka).
     *
     * @param restaurantId UUID restaurace k smazání
     */
    private void deleteRestaurantData(UUID restaurantId) {
        // Panorama fotky a session
        var panoramaSessions = panoramaSessionRepository.findAllByRestaurantIdOrderByCreatedAtDesc(restaurantId);
        for (var session : panoramaSessions) {
            panoramaPhotoRepository.deleteAllBySessionId(session.getId());
        }
        panoramaSessionRepository.deleteAllByRestaurantId(restaurantId);

        // Dining sessions (smaž nejdřív členy, pak sessions)
        var diningSessions = diningSessionRepository.findAllByRestaurantId(restaurantId);
        for (var session : diningSessions) {
            diningSessionMemberRepository.deleteAllBySessionId(session.getId());
        }
        diningSessionRepository.deleteAllById(
                diningSessions.stream().map(ds -> ds.getId()).collect(Collectors.toList())
        );

        // Objednávky restaurace
        orderRepository.deleteAllByRestaurantId(restaurantId);

        // Reservation change requesty pro rezervace restaurace
        var restaurantReservationIds = reservationRepository.findAllByRestaurantId(restaurantId)
                .stream()
                .map(r -> r.getId())
                .collect(Collectors.toList());
        if (!restaurantReservationIds.isEmpty()) {
            reservationChangeRequestRepository.deleteAllByReservationIdIn(restaurantReservationIds);
        }

        // Opakující se rezervace restaurace
        recurringReservationRepository.deleteAllByRestaurantId(restaurantId);

        // Rezervace restaurace
        reservationRepository.deleteAllByRestaurantId(restaurantId);

        // Menu položky → kategorie
        var categories = menuCategoryRepository.findAllByRestaurantId(restaurantId);
        for (var category : categories) {
            menuItemRepository.deleteAllByCategoryId(category.getId());
        }
        menuCategoryRepository.deleteAllByRestaurantId(restaurantId);

        // Stoly a skupiny stolů
        tableGroupRepository.deleteAllByRestaurantId(restaurantId);
        restaurantTableRepository.deleteAllByRestaurantId(restaurantId);

        // Zaměstnanci restaurace
        restaurantEmployeeRepository.deleteAllByRestaurantId(restaurantId);

        // Restaurace samotná
        restaurantRepository.deleteById(restaurantId);
    }
}