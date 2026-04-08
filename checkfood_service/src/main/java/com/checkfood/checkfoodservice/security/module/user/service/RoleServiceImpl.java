package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Implementace servisní vrstvy pro správu uživatelských rolí s logováním operací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;
    private final UserLogger userLogger;

    /**
     * Uloží nebo aktualizuje roli v systému.
     * Automaticky detekuje, zda jde o novou roli nebo aktualizaci pro správné logování.
     */
    @Override
    public RoleEntity save(RoleEntity role) {
        boolean isUpdate = role.getId() != null;

        var saved = roleRepository.save(role);

        if (isUpdate) {
            userLogger.logRoleUpdated(saved.getName(), saved.getId());
        } else {
            userLogger.logRoleCreated(saved.getName(), saved.getId());
        }

        return saved;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<RoleEntity> findById(Long id) {
        return roleRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public RoleEntity findByName(String name) {
        return roleRepository.findByName(name)
                .orElseThrow(() -> UserException.roleNotFound(name));
    }

    @Override
    @Transactional(readOnly = true)
    public RoleEntity findByNameWithPermissions(String name) {
        return roleRepository.findByName(name)
                .orElseThrow(() -> UserException.roleNotFound(name));
    }

    @Override
    @Transactional(readOnly = true)
    public List<RoleEntity> findAll() {
        return roleRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<RoleEntity> findAllByNames(Collection<String> names) {
        if (names == null || names.isEmpty()) {
            return List.of();
        }
        return roleRepository.findAllByNameIn(names);
    }

    /**
     * Smaže roli podle ID.
     *
     * @param id ID role ke smazání
     * @throws UserException pokud role s daným ID neexistuje
     */
    public void deleteById(Long id) {
        var role = roleRepository.findById(id)
                .orElseThrow(() -> UserException.roleNotFoundById(id));

        roleRepository.delete(role);
        userLogger.logRoleDeleted(role.getName(), id);
    }
}