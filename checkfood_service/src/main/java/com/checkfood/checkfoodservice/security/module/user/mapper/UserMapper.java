package com.checkfood.checkfoodservice.security.module.user.mapper;

import com.checkfood.checkfoodservice.infrastructure.storage.service.PrivateStorage;
import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.dto.response.*;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.mapstruct.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * MapStruct mapper pro transformaci uživatelských entit na DTO a opačně.
 * Zajišťuje konzistentní převod mezi entitami a DTO s eliminací citlivých dat z výstupů.
 *
 * <p>Avatar URL je rozhodována za běhu: pokud uživatel nahrál vlastní avatar
 * (uložen v privátním GCS bucketu), vrací se V4 signed URL s defaultní platností 1h.
 * Jinak se použije {@code profileImageUrl} z OAuth providera (Google/Apple).
 *
 * @author Rostislav Jirák
 * @version 2.0.0
 * @see UserEntity
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.ERROR)
public abstract class UserMapper {

    @Autowired
    @PrivateStorage
    protected StorageService privateStorage;

    /**
     * Převede uživatelskou entitu na profilové DTO pro endpoint {@code /api/user/me}.
     *
     * @param user uživatelská entita
     * @return profilová data uživatele
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", source = "roles", qualifiedByName = "mapPrimaryRole")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    public abstract UserProfileResponse toProfile(UserEntity user);

    /**
     * Převede uživatelskou entitu na autentizační DTO pro odpověď po přihlášení.
     * Vrací primární roli a technická Spring Security oprávnění.
     *
     * @param user uživatelská entita
     * @return autentizační data uživatele
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", source = "roles", qualifiedByName = "mapPrimaryRole")
    @Mapping(target = "authorities", source = "authorities", qualifiedByName = "mapAuthoritiesToSet")
    @Mapping(target = "needsRestaurantClaim", ignore = true)
    @Mapping(target = "needsOnboarding", ignore = true)
    public abstract UserResponse toAuth(UserEntity user);

    /**
     * Převede uživatelskou entitu na zjednodušené DTO pro použití v seznamech.
     *
     * @param user uživatelská entita
     * @return souhrnná data uživatele
     */
    @Mapping(target = "isActive", source = "enabled")
    public abstract UserSummaryResponse toSummary(UserEntity user);

    /**
     * Převede uživatelskou entitu na administrativní DTO s úplnými daty.
     * Obsahuje detailní sety rolí i Spring Security oprávnění.
     *
     * @param user uživatelská entita
     * @return administrativní data uživatele
     */
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "roles", source = "roles", qualifiedByName = "mapRolesToSet")
    @Mapping(target = "authorities", source = "authorities", qualifiedByName = "mapAuthoritiesToSet")
    @Mapping(target = "lastLogin", source = "devices", qualifiedByName = "calculateGlobalLastLogin")
    public abstract UserAdminResponse toAdmin(UserEntity user);

    /**
     * Převede entitu zařízení na DTO s příznakem aktuální session.
     *
     * @param device                  entita zařízení
     * @param currentDeviceIdentifier identifikátor zařízení aktuálního požadavku
     * @return DTO zařízení s nastaveným příznakem {@code currentDevice}
     */
    @Mapping(target = "currentDevice", expression = "java(device.getDeviceIdentifier().equals(currentDeviceIdentifier))")
    @Mapping(target = "deviceIdentifier", source = "device.deviceIdentifier")
    @Mapping(target = "active", source = "device.active")
    public abstract DeviceResponse toDeviceResponse(DeviceEntity device, String currentDeviceIdentifier);

    /**
     * Převede kolekci entit zařízení na seznam DTO.
     *
     * @param devices                 kolekce entit zařízení
     * @param currentDeviceIdentifier identifikátor aktuálního zařízení pro označení
     * @return seznam DTO zařízení, nebo prázdný seznam pokud je vstup {@code null}
     */
    public List<DeviceResponse> toDeviceResponseList(Collection<DeviceEntity> devices, String currentDeviceIdentifier) {
        if (devices == null) return Collections.emptyList();
        return devices.stream()
                .map(device -> toDeviceResponse(device, currentDeviceIdentifier))
                .toList();
    }

    /**
     * Aktualizuje uživatelskou entitu z požadavku na změnu profilu.
     * Citlivá a systémová pole (heslo, role, ID) jsou ignorována.
     *
     * @param request vstupní data profilu
     * @param entity  cílová uživatelská entita k aktualizaci
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
    @Mapping(target = "ownerTier", ignore = true)
    @Mapping(target = "avatarObjectPath", ignore = true)
    public abstract void updateEntityFromRequest(UpdateProfileRequest request, @MappingTarget UserEntity entity);

    /**
     * Vypočítá čas posledního přihlášení jako maximum ze všech registrovaných zařízení.
     *
     * @param devices sada zařízení uživatele
     * @return nejnovější čas přihlášení, nebo {@code null} pokud žádné zařízení neexistuje
     */
    @Named("calculateGlobalLastLogin")
    public LocalDateTime calculateGlobalLastLogin(Set<DeviceEntity> devices) {
        if (devices == null || devices.isEmpty()) return null;
        return devices.stream()
                .map(DeviceEntity::getLastLogin)
                .filter(java.util.Objects::nonNull)
                .max(LocalDateTime::compareTo)
                .orElse(null);
    }

    /**
     * Určí primární roli uživatele podle hierarchie: ADMIN > OWNER > MANAGER > STAFF > USER.
     *
     * @param roles sada rolí uživatele
     * @return název primární role
     */
    @Named("mapPrimaryRole")
    public String mapPrimaryRole(Set<RoleEntity> roles) {
        if (roles == null || roles.isEmpty()) return "USER";
        var names = roles.stream().map(RoleEntity::getName).collect(Collectors.toSet());
        if (names.contains("ADMIN")) return "ADMIN";
        if (names.contains("OWNER")) return "OWNER";
        if (names.contains("MANAGER")) return "MANAGER";
        if (names.contains("STAFF")) return "STAFF";
        return "USER";
    }

    /**
     * Převede kolekci Spring Security oprávnění na sadu řetězců.
     *
     * @param authorities kolekce grantovaných oprávnění
     * @return sada názvů oprávnění, nebo prázdná sada pro {@code null} vstup
     */
    @Named("mapAuthoritiesToSet")
    public Set<String> mapAuthoritiesToSet(Collection<? extends GrantedAuthority> authorities) {
        if (authorities == null) return Collections.emptySet();
        return authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toSet());
    }

    /**
     * Převede sadu entit rolí na sadu jejich názvů.
     *
     * @param roles sada entit rolí
     * @return sada názvů rolí, nebo prázdná sada pro {@code null} vstup
     */
    @Named("mapRolesToSet")
    public Set<String> mapRolesToSet(Set<RoleEntity> roles) {
        if (roles == null) return Collections.emptySet();
        return roles.stream().map(RoleEntity::getName).collect(Collectors.toSet());
    }

    // ---------- AVATAR URL RESOLUTION ----------

    /**
     * Po automapování přepíše {@code profileImageUrl} v target DTO na signed URL,
     * pokud má uživatel custom avatar uploadovaný v privátním bucketu.
     * Jinak ponechá hodnotu z {@link UserEntity#getProfileImageUrl()} (OAuth fallback).
     */
    @AfterMapping
    protected void resolveAvatarUrl(@MappingTarget UserProfileResponse target, UserEntity source) {
        String resolved = resolveAvatar(source);
        if (resolved != null) {
            target.setProfileImageUrl(resolved);
        }
    }

    @AfterMapping
    protected void resolveAvatarUrl(@MappingTarget UserSummaryResponse target, UserEntity source) {
        String resolved = resolveAvatar(source);
        if (resolved != null) {
            target.setProfileImageUrl(resolved);
        }
    }

    @AfterMapping
    protected void resolveAvatarUrl(@MappingTarget UserAdminResponse target, UserEntity source) {
        String resolved = resolveAvatar(source);
        if (resolved != null) {
            target.setProfileImageUrl(resolved);
        }
    }

    /**
     * Vrátí URL pro custom avatar (signed URL z privátního bucketu) nebo {@code null},
     * pokud uživatel nemá nahraný custom avatar (caller pak ponechá OAuth fallback).
     */
    private String resolveAvatar(UserEntity user) {
        if (user == null || user.getAvatarObjectPath() == null || user.getAvatarObjectPath().isBlank()) {
            return null;
        }
        return privateStorage.getDownloadUrl(user.getAvatarObjectPath());
    }
}