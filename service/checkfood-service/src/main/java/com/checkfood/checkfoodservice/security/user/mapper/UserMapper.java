package com.checkfood.checkfoodservice.security.user.mapper;

import com.checkfood.checkfoodservice.security.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.user.dto.response.DeviceResponse;
import com.checkfood.checkfoodservice.security.user.dto.response.UserAdminResponse;
import com.checkfood.checkfoodservice.security.user.dto.response.UserProfileResponse;
import com.checkfood.checkfoodservice.security.user.dto.response.UserSummaryResponse;
import com.checkfood.checkfoodservice.security.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Profesionální mapper využívající MapStruct.
 * Odstraněna veškerá logika fullName, data jsou mapována přímo z firstName a lastName.
 */
@Mapper(componentModel = "spring")
public interface UserMapper {

    // --- MAPOVÁNÍ PROFILU (/api/user/me) ---
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "roles", source = "roles", qualifiedByName = "mapRolesToList")
    UserProfileResponse toProfile(UserEntity user);

    // --- MAPOVÁNÍ ZAŘÍZENÍ ---
    DeviceResponse toDeviceResponse(DeviceEntity device);

    // --- MAPOVÁNÍ SUMMARY (Seznamy v adminu) ---
    @Mapping(target = "isActive", source = "enabled")
    // MapStruct automaticky namapuje firstName a lastName, protože se názvy v entitě a DTO shodují
    UserSummaryResponse toSummary(UserEntity user);

    // --- MAPOVÁNÍ ADMIN DETAILU (/api/user/{id}) ---
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "roles", source = "roles", qualifiedByName = "mapRolesToSet")
    UserAdminResponse toAdmin(UserEntity user);

    // --- MAPOVÁNÍ AUTH RESPONSE (Login / Register) ---
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", source = "roles", qualifiedByName = "mapPrimaryRole")
    // Zde UserResponse získá firstName a lastName automaticky
    UserResponse toAuth(UserEntity user);

    // --- AKTUALIZACE ENTITY Z REQUESTU ---
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "email", ignore = true)
    @Mapping(target = "password", ignore = true)
    @Mapping(target = "roles", ignore = true)
    @Mapping(target = "enabled", ignore = true)
    @Mapping(target = "devices", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    void updateEntityFromRequest(UpdateProfileRequest request, @MappingTarget UserEntity entity);

    // --- LOGIKA MAPOVÁNÍ (Helper Methods) ---

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

    @Named("mapPrimaryRole")
    default String mapPrimaryRole(Set<RoleEntity> roles) {
        if (roles == null || roles.isEmpty()) return "ROLE_USER";
        // Vracíme název první role (např. "ADMIN" nebo "USER")
        return roles.iterator().next().getName();
    }
}