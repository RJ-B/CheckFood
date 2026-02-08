package com.checkfood.checkfoodservice.security.module.user.mapper;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.response.*;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.mapstruct.*;
import org.springframework.security.core.GrantedAuthority;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Komponentní mapper pro transformaci uživatelských entit na DTO.
 * Implementuje logiku pro agregaci dat z distribuovaných relací a normalizaci bezpečnostních autorit.
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface UserMapper {

    /**
     * Mapování identity na klientský profil.
     * Atribut 'lastLogin' je agregován z historie všech asociovaných terminálů.
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "roles", source = "roles", qualifiedByName = "mapRolesToList")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    UserProfileResponse toProfile(UserEntity user);

    /**
     * Mapování relace zařízení.
     * Atributy se párují automaticky na základě shody názvů (lastLogin).
     */
    DeviceResponse toDeviceResponse(DeviceEntity device);

    @Mapping(target = "isActive", source = "enabled")
    UserSummaryResponse toSummary(UserEntity user);

    /**
     * Administrativní reprezentace s úplným auditním a bezpečnostním kontextem.
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "roles", source = "roles", qualifiedByName = "mapRolesToSet")
    @Mapping(target = "authorities", source = "authorities", qualifiedByName = "mapAuthoritiesToSet")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    UserAdminResponse toAdmin(UserEntity user);

    /**
     * Transformace subjektu pro autentizační payload.
     * Zdroj 'authorities' je automaticky resolvován z metody getAuthorities() v UserEntity.
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", source = "roles", qualifiedByName = "mapPrimaryRole")
    @Mapping(target = "authorities", source = "authorities", qualifiedByName = "mapAuthoritiesToSet")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    UserResponse toAuth(UserEntity user);

    /**
     * Aktualizace perzistentní entity z požadavku.
     * Ignoruje pole, která nesmí být měněna skrze profilový update request.
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "email", ignore = true)
    @Mapping(target = "password", ignore = true)
    @Mapping(target = "roles", ignore = true)
    @Mapping(target = "enabled", ignore = true)
    @Mapping(target = "devices", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "authorities", ignore = true)
    void updateEntityFromRequest(UpdateProfileRequest request, @MappingTarget UserEntity entity);

    /**
     * Výpočetní logika pro určení termínu poslední interakce uživatele se systémem.
     * Iteruje skrze všechna zařízení a vrací nejnovější časovou značku.
     */
    @Named("calculateGlobalLastLogin")
    default LocalDateTime calculateGlobalLastLogin(Set<DeviceEntity> devices) {
        if (devices == null || devices.isEmpty()) return null;
        return devices.stream()
                .map(DeviceEntity::getLastLogin)
                .filter(java.util.Objects::nonNull)
                .max(LocalDateTime::compareTo)
                .orElse(null);
    }

    @Named("mapRolesToList")
    default List<String> mapRolesToList(Set<RoleEntity> roles) {
        if (roles == null) return Collections.emptyList();
        return roles.stream().map(RoleEntity::getName).toList();
    }

    @Named("mapRolesToSet")
    default Set<String> mapRolesToSet(Set<RoleEntity> roles) {
        if (roles == null) return Collections.emptySet();
        return roles.stream().map(RoleEntity::getName).collect(Collectors.toSet());
    }

    /**
     * Transformuje kolekci GrantedAuthority (SimpleGrantedAuthority) na sadu textových řetězců.
     */
    @Named("mapAuthoritiesToSet")
    default Set<String> mapAuthoritiesToSet(Collection<? extends GrantedAuthority> authorities) {
        if (authorities == null) return Collections.emptySet();
        return authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toSet());
    }

    /**
     * Extrahuje název primární role uživatele.
     */
    @Named("mapPrimaryRole")
    default String mapPrimaryRole(Set<RoleEntity> roles) {
        if (roles == null || roles.isEmpty()) return "ROLE_USER";
        return roles.iterator().next().getName();
    }
}