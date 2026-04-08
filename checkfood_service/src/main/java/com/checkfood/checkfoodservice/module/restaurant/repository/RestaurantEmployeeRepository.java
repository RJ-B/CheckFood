package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repozitář pro správu pracovních vztahů zaměstnanců a restaurací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface RestaurantEmployeeRepository extends JpaRepository<RestaurantEmployee, Long> {

    /**
     * Najde členství uživatele v konkrétní restauraci, včetně eager load uživatele a restaurace.
     *
     * @param userId       ID uživatele
     * @param restaurantId UUID restaurace
     * @return Optional s členstvím, nebo prázdný pokud neexistuje
     */
    @EntityGraph(attributePaths = {"user", "restaurant"})
    Optional<RestaurantEmployee> findByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    /**
     * Najde první členství uživatele (libovolná restaurace), včetně eager load restaurace.
     *
     * @param userId ID uživatele
     * @return Optional s prvním nalezeným členstvím
     */
    @EntityGraph(attributePaths = {"restaurant"})
    Optional<RestaurantEmployee> findByUserId(Long userId);

    /**
     * Načte všechna členství uživatele ve všech restauracích, včetně eager load restaurace.
     *
     * @param userId ID uživatele
     * @return seznam všech členství uživatele
     */
    @EntityGraph(attributePaths = {"restaurant"})
    List<RestaurantEmployee> findAllByUserId(Long userId);

    /**
     * Načte všechny zaměstnance restaurace, včetně eager load uživatele.
     *
     * @param restaurantId UUID restaurace
     * @return seznam zaměstnanců
     */
    @EntityGraph(attributePaths = {"user"})
    List<RestaurantEmployee> findAllByRestaurantId(UUID restaurantId);

    /**
     * Ověří, zda uživatel již je zaměstnancem dané restaurace.
     *
     * @param userId       ID uživatele
     * @param restaurantId UUID restaurace
     * @return {@code true} pokud vztah existuje
     */
    boolean existsByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    /**
     * Najde první členství uživatele s danou rolí.
     *
     * @param userId ID uživatele
     * @param role   požadovaná role
     * @return Optional s prvním nalezeným členstvím
     */
    Optional<RestaurantEmployee> findFirstByUserIdAndRole(Long userId, RestaurantEmployeeRole role);

    /**
     * Odstraní zaměstnance dle ID záznamu a ID restaurace (bezpečnostní kontrola).
     *
     * @param id           ID záznamu zaměstnance
     * @param restaurantId UUID restaurace
     */
    void deleteByIdAndRestaurantId(Long id, UUID restaurantId);

    /**
     * Smaže všechny záznamy zaměstnanců pro danou restauraci.
     * Používá se při mazání restaurace (GDPR mazání účtu vlastníka).
     *
     * @param restaurantId UUID restaurace
     */
    void deleteAllByRestaurantId(UUID restaurantId);

    /**
     * Smaže všechny záznamy zaměstnanectví daného uživatele (GDPR mazání účtu).
     *
     * @param userId ID uživatele
     */
    void deleteAllByUserId(Long userId);

    /**
     * Najde všechny restaurace kde je uživatel OWNER.
     *
     * @param userId ID uživatele
     * @param role   role (OWNER)
     * @return seznam employee záznamů
     */
    List<RestaurantEmployee> findAllByUserIdAndRole(Long userId, RestaurantEmployeeRole role);
}