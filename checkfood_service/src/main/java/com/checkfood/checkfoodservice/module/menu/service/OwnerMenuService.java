package com.checkfood.checkfoodservice.module.menu.service;

import com.checkfood.checkfoodservice.module.menu.dto.request.MenuCategoryRequest;
import com.checkfood.checkfoodservice.module.menu.dto.request.MenuItemRequest;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuItemResponse;

import java.util.List;
import java.util.UUID;

/**
 * Service interface pro správu menu vlastníkem restaurace — CRUD operace nad kategoriemi a položkami.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface OwnerMenuService {

    /**
     * Vrátí kompletní menu restaurace vlastníka včetně neaktivních kategorií.
     *
     * @param userEmail e-mail přihlášeného vlastníka
     * @return seznam kategorií s položkami
     */
    List<MenuCategoryResponse> getOwnerMenu(String userEmail);

    /**
     * Vytvoří novou kategorii menu pro restauraci vlastníka.
     *
     * @param userEmail e-mail přihlášeného vlastníka
     * @param request   data nové kategorie
     * @return vytvořená kategorie
     */
    MenuCategoryResponse createCategory(String userEmail, MenuCategoryRequest request);

    /**
     * Aktualizuje existující kategorii menu.
     *
     * @param userEmail  e-mail přihlášeného vlastníka
     * @param categoryId UUID kategorie
     * @param request    aktualizovaná data kategorie
     * @return aktualizovaná kategorie s položkami
     */
    MenuCategoryResponse updateCategory(String userEmail, UUID categoryId, MenuCategoryRequest request);

    /**
     * Smaže kategorii menu i s jejími položkami.
     *
     * @param userEmail  e-mail přihlášeného vlastníka
     * @param categoryId UUID kategorie ke smazání
     */
    void deleteCategory(String userEmail, UUID categoryId);

    /**
     * Vytvoří novou položku menu v dané kategorii.
     *
     * @param userEmail  e-mail přihlášeného vlastníka
     * @param categoryId UUID kategorie
     * @param request    data nové položky
     * @return vytvořená položka menu
     */
    MenuItemResponse createItem(String userEmail, UUID categoryId, MenuItemRequest request);

    /**
     * Aktualizuje existující položku menu.
     *
     * @param userEmail e-mail přihlášeného vlastníka
     * @param itemId    UUID položky menu
     * @param request   aktualizovaná data položky
     * @return aktualizovaná položka menu
     */
    MenuItemResponse updateItem(String userEmail, UUID itemId, MenuItemRequest request);

    /**
     * Smaže položku menu.
     *
     * @param userEmail e-mail přihlášeného vlastníka
     * @param itemId    UUID položky menu ke smazání
     */
    void deleteItem(String userEmail, UUID itemId);
}
