package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.SpecialDayDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.AddEmployeeRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeePermissionsRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeeRoleRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateMyRestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeePermissionsResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;

import java.util.List;
import java.util.UUID;

/**
 * Service rozhraní pro správu vlastních restaurací, zaměstnanců a výjimečných dní z pohledu majitele nebo manažera.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface MyRestaurantService {

    /**
     * Vrátí seznam všech restaurací, ke kterým má přihlášený uživatel přístup.
     *
     * @param userEmail e-mail přihlášeného uživatele
     * @return seznam response DTO restaurací
     */
    List<RestaurantResponse> getMyRestaurants(String userEmail);

    /**
     * Vrátí detail konkrétní restaurace patřící přihlášenému uživateli.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace (nebo null pro první přiřazenou)
     * @return response DTO restaurace
     */
    RestaurantResponse getMyRestaurant(String userEmail, UUID restaurantId);

    /**
     * Aktualizuje základní informace o restauraci, otevírací dobu a výjimečné dny.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     * @param request      request s novými daty
     * @return aktualizované response DTO restaurace
     */
    RestaurantResponse updateMyRestaurant(String userEmail, UUID restaurantId, UpdateMyRestaurantRequest request);

    /**
     * Načte seznam zaměstnanců restaurace (bez vlastníka).
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     * @return seznam response DTO zaměstnanců
     */
    List<EmployeeResponse> getEmployees(String userEmail, UUID restaurantId);

    /**
     * Přidá nového zaměstnance do restaurace na základě e-mailu.
     *
     * @param userEmail    e-mail přihlášeného vlastníka
     * @param restaurantId UUID restaurace
     * @param request      request s e-mailem a rolí nového zaměstnance
     * @return response DTO nového zaměstnance
     */
    EmployeeResponse addEmployee(String userEmail, UUID restaurantId, AddEmployeeRequest request);

    /**
     * Změní roli zaměstnance a aktualizuje jeho výchozí oprávnění.
     *
     * @param userEmail    e-mail přihlášeného vlastníka
     * @param restaurantId UUID restaurace
     * @param employeeId   ID záznamu zaměstnance
     * @param request      request s novou rolí
     * @return aktualizované response DTO zaměstnance
     */
    EmployeeResponse updateEmployeeRole(String userEmail, UUID restaurantId, Long employeeId, UpdateEmployeeRoleRequest request);

    /**
     * Odebere zaměstnance z restaurace a zruší mu příslušnou Spring Security roli.
     *
     * @param userEmail    e-mail přihlášeného vlastníka
     * @param restaurantId UUID restaurace
     * @param employeeId   ID záznamu zaměstnance
     */
    void removeEmployee(String userEmail, UUID restaurantId, Long employeeId);

    /**
     * Vrátí efektivní oprávnění zaměstnance.
     *
     * @param userEmail    e-mail přihlášeného vlastníka
     * @param restaurantId UUID restaurace
     * @param employeeId   ID záznamu zaměstnance
     * @return response DTO s oprávněními
     */
    EmployeePermissionsResponse getEmployeePermissions(String userEmail, UUID restaurantId, Long employeeId);

    /**
     * Aktualizuje granulární oprávnění zaměstnance.
     *
     * @param userEmail    e-mail přihlášeného vlastníka
     * @param restaurantId UUID restaurace
     * @param employeeId   ID záznamu zaměstnance
     * @param request      request s novou sadou oprávnění
     * @return aktualizované response DTO oprávnění
     */
    EmployeePermissionsResponse updateEmployeePermissions(String userEmail, UUID restaurantId, Long employeeId, UpdateEmployeePermissionsRequest request);

    /**
     * Vrátí seznam výjimečných dní restaurace.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     * @return seznam DTO výjimečných dní
     */
    List<SpecialDayDto> getSpecialDays(String userEmail, UUID restaurantId);

    /**
     * Nahradí seznam výjimečných dní restaurace novými záznamy.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     * @param specialDays  nový seznam výjimečných dní
     * @return aktualizovaný seznam výjimečných dní
     */
    List<SpecialDayDto> updateSpecialDays(String userEmail, UUID restaurantId, List<SpecialDayDto> specialDays);
}
