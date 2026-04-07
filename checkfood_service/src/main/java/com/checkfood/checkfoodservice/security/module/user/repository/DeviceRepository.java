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
 * Repository pro správu klientských zařízení a aktivních sessions uživatelů.
 * Zajišťuje perzistenci dat pro bezpečnostní audit, správu refresh tokenů a session management.
 * Každé zařízení je jednoznačně identifikováno device identifierem a vázáno na uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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
     * Používá se pro zobrazení aktivních sessions v user profilu.
     * Uživatel může vidět kde všude je přihlášen a případně session odhlásit.
     *
     * @param user uživatel, jehož zařízení hledáme
     * @return seznam všech zařízení uživatele
     */
    List<DeviceEntity> findAllByUser(UserEntity user);

    /**
     * Zjistí, zda existuje zařízení s daným ID, které patří konkrétnímu uživateli.
     * Klíčové pro bezpečné mazání podle ID (prevence smazání cizího zařízení).
     *
     * @param id ID zařízení
     * @param user vlastník
     * @return true pokud zařízení existuje a patří uživateli
     */
    boolean existsByIdAndUser(Long id, UserEntity user);

    /**
     * Spočítá počet aktivních zařízení uživatele.
     * Používá se pro logování při hromadném odhlášení (např. "Odhlášeno 5 zařízení").
     *
     * @param user uživatel
     * @return počet zařízení
     */
    long countByUser(UserEntity user);

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
     * Používá se když uživatel odhlašuje konkrétní session ze seznamu aktivních zařízení.
     *
     * @param id databázové ID zařízení
     * @param user vlastník zařízení (bezpečnostní kontrola)
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.id = :id AND d.user = :user")
    void deleteByIdAndUser(@Param("id") Long id, @Param("user") UserEntity user);

    /**
     * Bezpečně smaže zařízení podle identifikátoru pouze pokud patří danému uživateli.
     * Alternativa k deleteByIdAndUser, která používá String identifier místo Long ID.
     * Bezpečnější pro frontend API, které nepracuje s interními databázovými ID.
     * Používá se v metodě removeByIdentifierAndUser v DeviceService.
     *
     * @param deviceIdentifier unikátní identifikátor zařízení
     * @param user vlastník zařízení (bezpečnostní kontrola)
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.deviceIdentifier = :deviceIdentifier AND d.user = :user")
    void deleteByDeviceIdentifierAndUser(@Param("deviceIdentifier") String deviceIdentifier, @Param("user") UserEntity user);

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
     * Smaže všechna zařízení uživatele kromě aktuálního.
     * Používá se při odhlášení ostatních zařízení z profilu.
     *
     * @param user uživatel, jehož zařízení mají být smazána
     * @param currentIdentifier identifikátor aktuálního zařízení, které se zachová
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.user = :user AND d.deviceIdentifier <> :currentIdentifier")
    void deleteAllByUserExceptDevice(@Param("user") UserEntity user, @Param("currentIdentifier") String currentIdentifier);
}