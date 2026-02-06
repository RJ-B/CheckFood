package com.checkfood.checkfoodservice.security.user.dto.response;

import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserProfileResponse {

    private Long id;
    private String email;
    private String firstName;
    private String lastName;
    private Boolean isActive;
    private LocalDateTime createdAt;
    private List<String> roles;
    private List<DeviceResponse> devices;
}