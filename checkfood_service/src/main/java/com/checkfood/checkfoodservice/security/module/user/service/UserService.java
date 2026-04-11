package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;

import java.util.List;

/**
 * Service interface pro správu uživatelských účtů a profilů.
 * Definuje operace pro manipulaci s identitou uživatele, správu hesel a řízení přístupu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface UserService {

    /**
     * Uloží nebo aktualizuje uživatelskou entitu v perzistentním úložišti.
     *
     * @param user uživatelská entita k uložení
     * @return uložená entita s vygenerovaným ID a časovými razítky
     */
    UserEntity save(UserEntity user);

    /**
     * Vyhledá uživatele podle jeho unikátního ID.
     *
     * @param id ID uživatele
     * @return nalezená uživatelská entita
     * @throws UserException pokud uživatel s daným ID neexistuje
     */
    UserEntity findById(Long id);

    /**
     * Vyhledá uživatele podle ID a eager načte jeho role. Použít tam, kde je
     * výsledek mapován na DTO obsahující role — jinak hrozí
     * {@code LazyInitializationException} mimo otevřenou transakci.
     *
     * @param id ID uživatele
     * @return entita včetně načtených rolí
     * @throws UserException pokud uživatel s daným ID neexistuje
     */
    UserEntity findWithRolesById(Long id);

    /**
     * Vyhledá uživatele podle e-mailové adresy s využitím líného načítání.
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita
     * @throws UserException pokud uživatel s daným e-mailem neexistuje
     */
    UserEntity findByEmail(String email);

    /**
     * Vyhledá uživatele včetně jeho rolí v rámci jednoho databázového dotazu.
     * Klíčové pro procesy autentizace a autorizace (Spring Security).
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita s načtenými rolemi
     */
    UserEntity findWithRolesByEmail(String email);

    /**
     * Vyhledá uživatele včetně všech přidružených detailů (role, zařízení).
     * Optimalizováno pro zobrazení kompletního profilu a správu relací.
     *
     * @param email emailová adresa uživatele
     * @return nalezená uživatelská entita s kompletními daty
     */
    UserEntity findWithAllDetailsByEmail(String email);

    /**
     * Ověří, zda v systému již existuje účet se zadanou e-mailovou adresou.
     *
     * @param email e-mailová adresa k ověření
     * @return true, pokud je e-mail již registrován, jinak false
     */
    boolean existsByEmail(String email);

    /**
     * Vrátí seznam všech registrovaných uživatelů.
     *
     * @return seznam uživatelských entit
     */
    List<UserEntity> findAll();

    /**
     * Provede bezpečnou změnu hesla uživatele.
     * Před změnou dochází k ověření stávajícího hesla a validaci síly nového hesla.
     * Shoda hesel je garantována volající stranou (frontendem).
     *
     * @param userId ID uživatele
     * @param currentPassword stávající heslo pro verifikaci identity
     * @param newPassword nové heslo splňující bezpečnostní kritéria
     * @throws UserException pokud je stávající heslo neplatné nebo nové heslo nevyhovuje pravidlům
     */
    void changePassword(Long userId, String currentPassword, String newPassword);

    /**
     * Aktualizuje osobní údaje uživatele na základě požadavku.
     *
     * @param email emailová adresa uživatele, jehož profil se aktualizuje
     * @param request DTO obsahující nové profilové údaje
     * @return aktualizovaná uživatelská entita
     */
    UserEntity updateProfile(String email, UpdateProfileRequest request);

    /**
     * Přiřadí uživateli novou roli pro rozšíření jeho oprávnění.
     *
     * @param userId ID uživatele
     * @param roleName název role (např. "ADMIN", "MANAGER")
     */
    void assignRole(Long userId, String roleName);

    /**
     * Odebere uživateli roli.
     *
     * @param userId ID uživatele
     * @param roleName název role k odebrání (např. "STAFF", "MANAGER")
     */
    void removeRole(Long userId, String roleName);

    /**
     * Trvale smaže uživatelský účet a veškerá data s ním spojená (GDPR right to erasure).
     * Pokud je uživatel OWNER, smaže i všechny jeho restaurace a jejich data.
     * Operace je transakční — buď se smaže vše, nebo nic.
     *
     * @param userId ID uživatele k trvalému smazání
     */
    void deleteAccount(Long userId);
}