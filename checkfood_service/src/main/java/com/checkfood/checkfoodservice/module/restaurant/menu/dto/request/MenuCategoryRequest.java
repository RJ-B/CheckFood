package com.checkfood.checkfoodservice.module.restaurant.menu.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * Request DTO pro vytvoření nebo aktualizaci kategorie menu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
