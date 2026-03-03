package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.logging.OAuthLogger;
import com.checkfood.checkfoodservice.security.module.oauth.mapper.OAuthMapper;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

/**
 * Service pro správu uživatelů přihlášených přes OAuth.
 *
 * Změny pro JDK 21:
 * - Odstraněno logování chyb (řeší Handler).
 * - Použití 'var'.
 * - Správné použití OAuthException.
 */
@Service
@RequiredArgsConstructor
public class OAuthUserServiceImpl implements OAuthUserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final OAuthMapper oauthMapper;
    private final OAuthLogger oauthLogger;

    @Override
    @Transactional
    public UserEntity getOrCreateUser(OAuthUserInfo userInfo) {
        // 1. Hledáme podle Provider ID (nejspolehlivější)
        return userRepository.findByAuthProviderAndProviderId(
                userInfo.getProviderType(),
                userInfo.getProviderUserId()
        ).orElseGet(() -> handleUserByEmail(userInfo));
    }

    private UserEntity handleUserByEmail(OAuthUserInfo userInfo) {
        // 2. Hledáme podle emailu (prolinkování účtů)
        return userRepository.findByEmail(userInfo.getEmail())
                .map(existingUser -> validateAndLinkUser(existingUser, userInfo))
                .orElseGet(() -> createNewUser(userInfo));
    }

    private UserEntity validateAndLinkUser(UserEntity existingUser, OAuthUserInfo userInfo) {
        // KONTROLA: Pokud se provider liší, vyhodíme výjimku.
        // Nelogujeme chybu zde, Handler ji zaloguje jako SECURITY_ACCOUNT_STATE warning.
        if (existingUser.getAuthProvider() != userInfo.getProviderType()) {
            throw OAuthException.accountProviderMismatch(
                    userInfo.getEmail(),
                    existingUser.getAuthProvider().name()
            );
        }

        return updateExistingUser(existingUser, userInfo);
    }

    private UserEntity updateExistingUser(UserEntity user, OAuthUserInfo userInfo) {
        mapUserAttributes(user, userInfo);

        if (user.getProviderId() == null) {
            user.setProviderId(userInfo.getProviderUserId());
        }

        return userRepository.save(user);
    }

    private UserEntity createNewUser(OAuthUserInfo userInfo) {
        var newUser = oauthMapper.toEntity(userInfo);
        mapUserAttributes(newUser, userInfo);
        newUser.setEnabled(true); // OAuth účty jsou vždy aktivní

        var userRole = roleRepository.findByName("USER")
                .orElseThrow(() -> OAuthException.internalError("Konfigurace systému je neplatná: Role 'USER' nenalezena.", null));

        newUser.setRoles(Set.of(userRole));

        var savedUser = userRepository.save(newUser);

        // Logování úspěchu
        oauthLogger.logSuccessfulOAuthRegistration(savedUser.getEmail(), savedUser.getAuthProvider());

        return savedUser;
    }

    private void mapUserAttributes(UserEntity entity, OAuthUserInfo userInfo) {
        if (userInfo.getFirstName() != null && !userInfo.getFirstName().isBlank()) {
            entity.setFirstName(userInfo.getFirstName());
        }
        if (userInfo.getLastName() != null && !userInfo.getLastName().isBlank()) {
            entity.setLastName(userInfo.getLastName());
        }
        if (userInfo.getProfileImageUrl() != null && !userInfo.getProfileImageUrl().isBlank()) {
            entity.setProfileImageUrl(userInfo.getProfileImageUrl());
        }
    }
}