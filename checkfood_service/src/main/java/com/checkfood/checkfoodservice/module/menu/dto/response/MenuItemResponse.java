package com.checkfood.checkfoodservice.module.menu.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MenuItemResponse {

    private UUID id;
    private String name;
    private String description;
    private int priceMinor;
    private String currency;
    private String imageUrl;
    private boolean available;
}
