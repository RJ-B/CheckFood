package com.checkfood.checkfoodservice.security.module.user.mapper;

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
 * Centrální mapper pro transformaci uživatelských dat.
 * Zajišťuje konzistentní převod mezi entitami a DTO s ohledem na bezpečnost a výkon.
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.ERROR)
public interface UserMapper {

    /**
     * Mapování identity na klientský profil (pro endpoint /api/user/me).
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", source = "roles", qualifiedByName = "mapPrimaryRole")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    UserProfileResponse toProfile(UserEntity user);

    /**
     * Mapování pro autentizační odpověď (použito v AuthMapper).
     * Sjednoceno s Flutter modelem: vrací primární roli a technická oprávnění.
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", source = "roles", qualifiedByName = "mapPrimaryRole")
    @Mapping(target = "authorities", source = "authorities", qualifiedByName = "mapAuthoritiesToSet")
    @Mapping(target = "needsRestaurantClaim", ignore = true)
    @Mapping(target = "needsOnboarding", ignore = true)
    UserResponse toAuth(UserEntity user);

    /**
     * Zjednodušená transformace pro seznamy uživatelů.
     * Ponecháno pro budoucí využití v seznamech či vyhledávání.
     */
    @Mapping(target = "isActive", source = "enabled")
    UserSummaryResponse toSummary(UserEntity user);

    /**
     * Úplná reprezentace pro systémovou administraci.
     * Obsahuje detailní sety rolí i oprávnění.
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "roles", source = "roles", qualifiedByName = "mapRolesToSet")
    @Mapping(target = "authorities", source = "authorities", qualifiedByName = "mapAuthoritiesToSet")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    UserAdminResponse toAdmin(UserEntity user);

    /**
     * Mapování zařízení s detekcí aktuální session.
     */
    @Mapping(target = "currentDevice", expression = "java(device.getDeviceIdentifier().equals(currentDeviceIdentifier))")
    @Mapping(target = "deviceIdentifier", source = "device.deviceIdentifier")
    DeviceResponse toDeviceResponse(DeviceEntity device, String currentDeviceIdentifier);

    /**
     * Pomocná metoda pro mapování kolekce zařízení.
     */
    default List<DeviceResponse> toDeviceResponseList(Collection<DeviceEntity> devices, String currentDeviceIdentifier) {
        if (devices == null) return Collections.emptyList();
        return devices.stream()
                .map(device -> toDeviceResponse(device, currentDeviceIdentifier))
                .toList();
    }

    /**
     * Bezpečná aktualizace entity z požadavku na změnu profilu.
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
    @Mapping(target = "authProvider", ignore = true)
    @Mapping(target = "providerId", ignore = true)
    void updateEntityFromRequest(UpdateProfileRequest request, @MappingTarget UserEntity entity);

    // --- Implementace pomocných (Named) metod ---

    @Named("calculateGlobalLastLogin")
    default LocalDateTime calculateGlobalLastLogin(Set<DeviceEntity> devices) {
        if (devices == null || devices.isEmpty()) return null;
        return devices.stream()
                .map(DeviceEntity::getLastLogin)
                .filter(java.util.Objects::nonNull)
                .max(LocalDateTime::compareTo)
                .orElse(null);
    }

    @Named("mapPrimaryRole")
    default String mapPrimaryRole(Set<RoleEntity> roles) {
        if (roles == null || roles.isEmpty()) return "USER";
        var names = roles.stream().map(RoleEntity::getName).collect(Collectors.toSet());
        if (names.contains("ADMIN")) return "ADMIN";
        if (names.contains("OWNER")) return "OWNER";
        if (names.contains("MANAGER")) return "MANAGER";
        return "USER";
    }

    @Named("mapAuthoritiesToSet")
    default Set<String> mapAuthoritiesToSet(Collection<? extends GrantedAuthority> authorities) {
        if (authorities == null) return Collections.emptySet();
        return authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toSet());
    }

    @Named("mapRolesToSet")
    default Set<String> mapRolesToSet(Set<RoleEntity> roles) {
        if (roles == null) return Collections.emptySet();
        return roles.stream().map(RoleEntity::getName).collect(Collectors.toSet());
    }
}