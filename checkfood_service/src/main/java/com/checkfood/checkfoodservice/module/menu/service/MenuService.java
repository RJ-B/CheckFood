package com.checkfood.checkfoodservice.module.menu.service;

import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;

import java.util.List;
import java.util.UUID;

public interface MenuService {

    List<MenuCategoryResponse> getMenu(UUID restaurantId);
}
