package com.example.CheckFood.domain.user;

public class UserMapper {

    public static User toEntity(UserDto dto) {
        return User.builder()
                .firstName(dto.getFirstName())
                .lastName(dto.getLastName())
                .email(dto.getEmail())
                .phone(dto.getPhone())
                .username(dto.getUsername())
                .password(dto.getPassword())
                .age(dto.getAge())
                .role(dto.getRole())
                .build();
    }

    public static UserDto toDto(User user) {
        return UserDto.builder()
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .phone(user.getPhone())
                .username(user.getUsername())
                .password("********") // nebo null – nezobrazovat heslo!
                .age(user.getAge())
                .role(user.getRole())
                .build();
    }
}
