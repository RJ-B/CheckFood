package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * DTO poskytující detailní administrativní pohled na uživatelský účet včetně rolí a oprávnění.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserAdminResponse {

    private Long id;

    private String email;

    private String firstName;

    private String lastName;

    private String profileImageUrl;

    private LocalDateTime lastLogin;
    private Set<String> authorities;

    private Boolean isActive;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private Set<String> roles;
}