package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;

import java.util.List;

/**
 * Service interface pro správu uživatelských účtů a profilů.
 * Poskytuje operace pro CRUD, autentizaci, správu hesel a přiřazování rolí.
 */
public interface UserService {

    /**
     * Uloží nebo aktualizuje uživatelskou entitu.
     *
     * @param user uživatelská entita k uložení
     * @return uložená entita s vygenerovaným ID
     */
    UserEntity save(UserEntity user);

    /**
     * Najde uživatele podle ID.
     *
     * @param id ID uživatele
     * @return nalezená uživatelská entita
     * @throws UserException pokud uživatel není nalezen
     */
    UserEntity findById(Long id);

    /**
     * Najde uživatele podle emailové adresy.
     * Načítá pouze základní data bez vztahů (lazy loading).
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita
     * @throws UserException pokud uživatel není nalezen
     */
    UserEntity findByEmail(String email);

    /**
     * Najde uživatele včetně rolí v jednom dotazu.
     * Kritické pro Spring Security autentizaci a autorizaci.
     * Používá EntityGraph pro prevenci N+1 problému.
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita s eager načtenými rolemi
     * @throws UserException pokud uživatel není nalezen
     */
    UserEntity findWithRolesByEmail(String email);

    /**
     * Najde uživatele včetně všech vztahů (role, zařízení) v jednom dotazu.
     * Používá se pro endpoint /api/auth/me a další operace vyžadující kompletní profil.
     * Používá EntityGraph pro optimalizaci výkonu (prevence N+1).
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita s eager načtenými vztahy
     * @throws UserException pokud uživatel není nalezen
     */
    UserEntity findWithAllDetailsByEmail(String email);

    /**
     * Ověří existenci uživatele s danou emailovou adresou.
     *
     * @param email emailová adresa k ověření
     * @return true pokud uživatel existuje, jinak false
     */
    boolean existsByEmail(String email);

    /**
     * Vrátí seznam všech uživatelů v systému.
     *
     * @return seznam všech uživatelů
     */
    List<UserEntity> findAll();

    /**
     * Změní heslo uživatele po ověření současného hesla.
     * Validuje sílu nového hesla a zajišťuje shodu s potvrzením.
     * Operace je auditována pro bezpečnostní účely.
     *
     * @param userId ID uživatele
     * @param currentPassword současné heslo pro ověření
     * @param newPassword nové heslo
     * @param confirmPassword potvrzení nového hesla
     * @throws UserException pokud současné heslo není správné nebo nová hesla se neshodují
     */
    void changePassword(Long userId, String currentPassword, String newPassword, String confirmPassword);

    /**
     * Aktualizuje profilové informace uživatele.
     * Načítá uživatele včetně vztahů pro úplnou aktualizaci.
     *
     * @param email emailová adresa uživatele
     * @param request data pro aktualizaci profilu
     * @return aktualizovaná uživatelská entita
     */
    UserEntity updateProfile(String email, UpdateProfileRequest request);

    /**
     * Přiřadí roli uživateli.
     * Používá se v admin rozhraní pro správu oprávnění.
     *
     * @param userId ID uživatele
     * @param roleName název role k přiřazení
     */
    void assignRole(Long userId, String roleName);
}