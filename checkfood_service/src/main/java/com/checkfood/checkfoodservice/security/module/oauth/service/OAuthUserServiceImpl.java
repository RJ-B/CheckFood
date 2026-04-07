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
 * Implementace správy uživatelských entit pro OAuth přihlašování (JIT provisioning).
 * Vyhledává existující uživatele dle provider ID nebo e-mailu a vytváří nové účty
 * pro uživatele přihlašující se poprvé.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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
        return userRepository.findByAuthProviderAndProviderId(
                userInfo.getProviderType(),
                userInfo.getProviderUserId()
        ).orElseGet(() -> handleUserByEmail(userInfo));
    }

    /**
     * Pokusí se najít uživatele podle e-mailu a buď ho propojí s OAuth identitou,
     * nebo vytvoří nový účet.
     *
     * @param userInfo data uživatele od OAuth poskytovatele
     * @return nalezená nebo nově vytvořená entita uživatele
     */
    private UserEntity handleUserByEmail(OAuthUserInfo userInfo) {
        return userRepository.findByEmail(userInfo.getEmail())
                .map(existingUser -> validateAndLinkUser(existingUser, userInfo))
                .orElseGet(() -> createNewUser(userInfo));
    }

    /**
     * Ověří, že existující uživatel pochází od stejného OAuth poskytovatele, a aktualizuje jeho data.
     *
     * @param existingUser existující uživatelská entita
     * @param userInfo     data uživatele od OAuth poskytovatele
     * @return aktualizovaná uživatelská entita
     * @throws com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException pokud se poskytovatelé neshodují
     */
    private UserEntity validateAndLinkUser(UserEntity existingUser, OAuthUserInfo userInfo) {
        if (existingUser.getAuthProvider() != userInfo.getProviderType()) {
            throw OAuthException.accountProviderMismatch(
                    userInfo.getEmail(),
                    existingUser.getAuthProvider().name()
            );
        }

        return updateExistingUser(existingUser, userInfo);
    }

    /**
     * Aktualizuje atributy existujícího uživatele z dat OAuth poskytovatele a uloží změny.
     *
     * @param user     existující uživatelská entita k aktualizaci
     * @param userInfo data uživatele od OAuth poskytovatele
     * @return uložená aktualizovaná entita
     */
    private UserEntity updateExistingUser(UserEntity user, OAuthUserInfo userInfo) {
        mapUserAttributes(user, userInfo);

        if (user.getProviderId() == null) {
            user.setProviderId(userInfo.getProviderUserId());
        }

        return userRepository.save(user);
    }

    /**
     * Vytvoří a uloží nový uživatelský účet na základě dat od OAuth poskytovatele.
     * Přiřadí výchozí roli USER a označí účet jako ověřený (enabled).
     *
     * @param userInfo data uživatele od OAuth poskytovatele
     * @return nově vytvořená a uložená entita uživatele
     */
    private UserEntity createNewUser(OAuthUserInfo userInfo) {
        var newUser = oauthMapper.toEntity(userInfo);
        mapUserAttributes(newUser, userInfo);
        newUser.setEnabled(true);

        var userRole = roleRepository.findByName("USER")
                .orElseThrow(() -> OAuthException.internalError("Konfigurace systemu je neplatna: Role 'USER' nenalezena.", null));

        newUser.setRoles(Set.of(userRole));

        var savedUser = userRepository.save(newUser);

        oauthLogger.logSuccessfulOAuthRegistration(savedUser.getEmail(), savedUser.getAuthProvider());

        return savedUser;
    }

    /**
     * Namapuje nenulové atributy z OAuth dat na uživatelskou entitu.
     * Prázdné nebo nulové hodnoty jsou ignorovány, aby nedošlo k přepsání existujících dat.
     *
     * @param entity   cílová uživatelská entita
     * @param userInfo zdrojová data od OAuth poskytovatele
     */
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