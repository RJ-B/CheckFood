package com.checkfood.checkfoodservice.security.user.service;

import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.exception.RoleNotFoundException;
import com.checkfood.checkfoodservice.security.user.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Služba pro správu uživatelských rolí.
 * Zajišťuje logiku pro vyhledávání a validaci rolí v rámci RBAC systému.
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;

    @Override
    public RoleEntity save(RoleEntity role) {
        log.info("Ukládání nebo aktualizace role: {}", role.getName());
        return roleRepository.save(role);
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
                .orElseThrow(() -> {
                    log.error("Role s názvem '{}' nebyla nalezena", name);
                    return new RoleNotFoundException("Role nebyla nalezena: " + name);
                });
    }

    @Override
    @Transactional(readOnly = true)
    public RoleEntity findByNameWithPermissions(String name) {
        return roleRepository.findWithPermissionsByName(name)
                .orElseThrow(() -> new RoleNotFoundException("Role nebyla nalezena: " + name));
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
        log.debug("Hromadné vyhledávání rolí pro: {}", names);
        return roleRepository.findAllByNameIn(names);
    }
}