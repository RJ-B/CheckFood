package com.checkfood.checkfoodservice.security.module.oauth.mapper;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import org.mapstruct.*;

import java.util.stream.Collectors;

/**
 * Mapper pro transformaci mezi OAuth daty a sjednocenými autentizačními DTO.
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface OAuthMapper {

    /**
     * Mapuje externí data z poskytovatele na interní entitu uživatele.
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "providerId", source = "providerUserId")
    @Mapping(target = "authProvider", source = "providerType")
    @Mapping(target = "enabled", constant = "true")
    @Mapping(target = "password", ignore = true) // Explicitní ignorování hesla při vytváření entity
    UserEntity toEntity(OAuthUserInfo userInfo);

    /**
     * Mapuje UserEntity na sjednocený UserResponse.
     * Zajišťuje, že se do UI dostanou pouze veřejné informace bez hesla.
     */
    @Mapping(target = "id", source = "id")
    @Mapping(target = "isActive", source = "enabled")
    @Mapping(target = "role", expression = "java(mapPrimaryRole(user))")
    @Mapping(target = "authorities", expression = "java(mapAuthorities(user))")
    UserResponse toUserResponse(UserEntity user);

    /**
     * Sestaví sjednocenou AuthResponse pro frontend.
     */
    default AuthResponse toResponse(String accessToken, String refreshToken, Long expiresIn, UserEntity user) {
        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .expiresIn(expiresIn)
                .tokenType("Bearer")
                .user(toUserResponse(user))
                .build();
    }

    /**
     * Extrahuje primární roli pro jednoduché zobrazení v UI.
     */
    default String mapPrimaryRole(UserEntity user) {
        if (user.getRoles() == null || user.getRoles().isEmpty()) return "USER";
        return user.getRoles().iterator().next().toString();
    }

    /**
     * Mapuje všechny role/oprávnění na set řetězců pro frontendovou logiku oprávnění.
     */
    default java.util.Set<String> mapAuthorities(UserEntity user) {
        if (user.getRoles() == null) return java.util.Collections.emptySet();
        return user.getRoles().stream()
                .map(Object::toString)
                .collect(Collectors.toSet());
    }
}