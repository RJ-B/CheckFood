package com.checkfood.checkfoodservice.module.menu.service;

import com.checkfood.checkfoodservice.module.menu.dto.request.MenuCategoryRequest;
import com.checkfood.checkfoodservice.module.menu.dto.request.MenuItemRequest;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuItemResponse;

import java.util.List;
import java.util.UUID;

public interface OwnerMenuService {
    List<MenuCategoryResponse> getOwnerMenu(String userEmail);

    MenuCategoryResponse createCategory(String userEmail, MenuCategoryRequest request);

    MenuCategoryResponse updateCategory(String userEmail, UUID categoryId, MenuCategoryRequest request);

    void deleteCategory(String userEmail, UUID categoryId);

    MenuItemResponse createItem(String userEmail, UUID categoryId, MenuItemRequest request);

    MenuItemResponse updateItem(String userEmail, UUID itemId, MenuItemRequest request);

    void deleteItem(String userEmail, UUID itemId);
}
