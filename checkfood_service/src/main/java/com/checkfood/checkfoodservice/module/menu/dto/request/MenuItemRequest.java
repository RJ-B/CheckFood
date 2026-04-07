package com.checkfood.checkfoodservice.module.menu.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * Request DTO pro vytvoření nebo aktualizaci položky menu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MenuItemRequest {
    @NotBlank(message = "Název položky je povinný")
    @Size(max = 150)
    private String name;

    @Size(max = 500)
    private String description;

    @Min(value = 0, message = "Cena musí být nezáporná")
    private int priceMinor;

    @Size(max = 3)
    @Builder.Default
    private String currency = "CZK";

    private String imageUrl;

    @Builder.Default
    private boolean available = true;

    private int sortOrder;
}
