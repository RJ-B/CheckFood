package com.example.CheckFood.domain.user.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserUpdateRequest {
    private String firstName;
    private String lastName;
    private String phone;
    private Integer age;
    private String profileImage;
}
