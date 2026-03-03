package com.checkfood.checkfoodservice.module.owner.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ClaimEmailConfirmRequest {
    @NotBlank
    private String ico;

    @NotBlank
    private String code;
}
