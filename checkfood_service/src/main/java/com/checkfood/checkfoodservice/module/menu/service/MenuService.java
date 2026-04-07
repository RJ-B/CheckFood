package com.checkfood.checkfoodservice.module.menu.service;

import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;

import java.util.List;
import java.util.UUID;

/**
 * Servisní rozhraní pro čtení veřejného menu restaurace zákazníky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface MenuService {

    /**
     * Vrátí seznam aktivních kategorií menu s dostupnými položkami pro danou restauraci.
     *
     * @param restaurantId UUID restaurace
     * @return seznam kategorií s položkami, prázdné kategorie jsou vynechány
     */
    List<MenuCategoryResponse> getMenu(UUID restaurantId);
}
