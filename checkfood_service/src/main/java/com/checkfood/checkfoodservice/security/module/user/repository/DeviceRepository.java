package com.checkfood.checkfoodservice.security.module.user.repository;

import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Repository pro správu klientských zařízení a aktivních relací uživatelů.
 * Zajišťuje perzistenci dat pro bezpečnostní audit, správu refresh tokenů a session management.
 * Každé zařízení je jednoznačně identifikováno device identifierem a vázáno na uživatele.
 *
 * @see DeviceEntity
 * @see UserEntity
 */
@Repository
public interface DeviceRepository extends JpaRepository<DeviceEntity, Long> {

    /**
     * Najde zařízení podle jeho unikátního identifikátoru.
     * Používá se při validaci refresh tokenů a kontrole existence zařízení.
     *
     * @param deviceIdentifier unikátní identifikátor zařízení
     * @return Optional se zařízením nebo prázdný Optional
     */
    Optional<DeviceEntity> findByDeviceIdentifier(String deviceIdentifier);

    /**
     * Najde konkrétní zařízení patřící specifickému uživateli.
     * Bezpečnější varianta než findByDeviceIdentifier, kontroluje vlastnictví.
     * Používá se při refresh token validaci pro ověření, že token patří správnému uživateli.
     *
     * @param deviceIdentifier unikátní identifikátor zařízení
     * @param user vlastník zařízení
     * @return Optional se zařízením nebo prázdný Optional
     */
    Optional<DeviceEntity> findByDeviceIdentifierAndUser(String deviceIdentifier, UserEntity user);

    /**
     * Vrátí seznam všech registrovaných zařízení uživatele.
     * Používá se pro zobrazení aktivních relací v user profilu.
     * Uživatel může vidět kde všude je přihlášen a případně relace odhlásit.
     *
     * @param user uživatel, jehož zařízení hledáme
     * @return seznam všech zařízení uživatele
     */
    List<DeviceEntity> findAllByUser(UserEntity user);

    /**
     * Smaže zařízení podle jeho identifikátoru.
     * Používá se při logout operaci pro invalidaci refresh tokenů.
     *
     * @param deviceIdentifier unikátní identifikátor zařízení ke smazání
     */
    @Modifying
    @Transactional
    void deleteByDeviceIdentifier(String deviceIdentifier);

    /**
     * Bezpečně smaže konkrétní zařízení pouze pokud patří danému uživateli.
     * Klíčová metoda pro logout API, zabraňuje odhlášení zařízení jiného uživatele.
     * Používá se když uživatel odhlašuje konkrétní relaci ze seznamu aktivních zařízení.
     *
     * @param id databázové ID zařízení
     * @param user vlastník zařízení (bezpečnostní kontrola)
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.id = :id AND d.user = :user")
    void deleteByIdAndUser(@Param("id") Long id, @Param("user") UserEntity user);

    /**
     * Hromadné smazání všech zařízení uživatele.
     * Používá se při kompletním odhlášení ze všech zařízení najednou.
     * Invaliduje všechny refresh tokeny uživatele.
     *
     * @param user uživatel, jehož zařízení mají být smazána
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.user = :user")
    void deleteAllByUser(@Param("user") UserEntity user);

    /**
     * Zjistí, zda uživatel již má registrované konkrétní zařízení.
     * Efektivnější než findByDeviceIdentifierAndUser pro pouhé ověření existence.
     * Používá se při login pro rozhodnutí mezi update a insert zařízení.
     *
     * @param deviceIdentifier unikátní identifikátor zařízení
     * @param user vlastník zařízení
     * @return true pokud zařízení existuje, jinak false
     */
    boolean existsByDeviceIdentifierAndUser(String deviceIdentifier, UserEntity user);
}