package com.checkfood.checkfoodservice.application.mapper.user;

import com.checkfood.checkfoodservice.application.dto.request.user.UserRegisterRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.user.UserProfileResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.user.UserResponseDto;
import com.checkfood.checkfoodservice.application.entity.user.User;

import org.mapstruct.Mapper;

/**
 * Mapper pro převod mezi User entitou a DTO objekty.
 *
 * Používá se v:
 * - UserService
 * - UserController
 *
 * ❗ Neobsahuje žádnou business logiku
 */
@Mapper(componentModel = "spring")
public interface UserMapper {

    // TODO: User <- UserRegisterRequestDto
    User toEntity(UserRegisterRequestDto dto);

    // TODO: User -> UserResponseDto
    UserResponseDto toResponse(User user);

    // TODO: User -> UserProfileResponseDto
    UserProfileResponseDto toProfileResponse(User user);
}
