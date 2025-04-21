package com.example.CheckFood.domain.user;

import java.util.List;

public interface UserService {
    UserDto createUser(UserDto userDto);
    List<UserDto> getAllUsers();
    UserDto getUserById(Long id);
    void deleteUser(Long id);
}
