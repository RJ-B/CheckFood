package com.example.CheckFood.domain.product;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDto {

    @NotBlank(message = "Název produktu je povinný")
    private String name;

    private String description;

    @NotNull(message = "Cena je povinná")
    private Double price;

    @NotBlank(message = "Kategorie je povinná")
    private String category;

    @NotNull(message = "ID restaurace je povinné")
    private Long restaurantId;
}
