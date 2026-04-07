package com.checkfood.checkfoodservice.module.restaurant.onboarding.service;

import com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding.OnboardingHoursRequest;
import com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding.OnboardingInfoRequest;
import com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding.OnboardingStatusResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;

import java.util.List;
import java.util.UUID;

/**
 * Interface pro správu onboardingu majitele restaurace — aktualizace informací, otevírací doby, stolů a publikace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface OwnerOnboardingService {

    /**
     * Vrátí restauraci přiřazenou přihlášenému majiteli.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @return detail restaurace
     */
    RestaurantResponse getMyRestaurant(String userEmail);

    /**
     * Aktualizuje základní informace restaurace (název, popis, kontakty, adresa, typ kuchyně).
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param request   nové informace o restauraci
     * @return aktualizovaný detail restaurace
     */
    RestaurantResponse updateInfo(String userEmail, OnboardingInfoRequest request);

    /**
     * Aktualizuje otevírací dobu restaurace.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param request   nová otevírací doba
     * @return aktualizovaný detail restaurace
     */
    RestaurantResponse updateHours(String userEmail, OnboardingHoursRequest request);

    /**
     * Vrátí seznam stolů restaurace přihlášeného majitele.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @return seznam stolů
     */
    List<RestaurantTableResponse> getTables(String userEmail);

    /**
     * Přidá nový stůl do restaurace přihlášeného majitele.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param request   parametry nového stolu
     * @return přidaný stůl
     */
    RestaurantTableResponse addTable(String userEmail, RestaurantTableRequest request);

    /**
     * Aktualizuje existující stůl restaurace.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param tableId   identifikátor stolu
     * @param request   nové parametry stolu
     * @return aktualizovaný stůl
     */
    RestaurantTableResponse updateTable(String userEmail, UUID tableId, RestaurantTableRequest request);

    /**
     * Smaže stůl z restaurace přihlášeného majitele.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param tableId   identifikátor stolu ke smazání
     */
    void deleteTable(String userEmail, UUID tableId);

    /**
     * Vrátí stav onboardingu restaurace — přehled splnění jednotlivých kroků.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @return stav onboardingu
     */
    OnboardingStatusResponse getOnboardingStatus(String userEmail);

    /**
     * Publikuje restauraci — nastaví stav ACTIVE a označí onboarding jako dokončený.
     * Vyžaduje splnění minimálních podmínek (název, otevírací doba, stůl, menu).
     *
     * @param userEmail e-mail přihlášeného majitele
     * @return aktualizovaný detail publikované restaurace
     */
    RestaurantResponse publish(String userEmail);
}
