package com.checkfood.checkfoodservice.module.menu.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MenuCategoryRequest {
    @NotBlank(message = "Název kategorie je povinný")
    @Size(max = 100)
    private String name;

    private int sortOrder;
}
