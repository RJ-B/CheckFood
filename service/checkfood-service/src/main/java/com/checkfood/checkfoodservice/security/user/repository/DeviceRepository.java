package com.checkfood.checkfoodservice.security.user.repository;

import com.checkfood.checkfoodservice.security.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Repository pro správu klientských zařízení a relací.
 * Zajišťuje perzistenci dat pro bezpečnostní audit a správu aktivních relací.
 */
@Repository
public interface DeviceRepository extends JpaRepository<DeviceEntity, Long> {

    /**
     * Najde zařízení podle jeho unikátního identifikátoru.
     */
    Optional<DeviceEntity> findByDeviceIdentifier(String deviceIdentifier);

    /**
     * Najde konkrétní zařízení patřící specifickému uživateli podle hardware identifikátoru.
     */
    Optional<DeviceEntity> findByDeviceIdentifierAndUser(String deviceIdentifier, UserEntity user);

    /**
     * Vrátí seznam všech registrovaných zařízení uživatele.
     */
    List<DeviceEntity> findAllByUser(UserEntity user);

    /**
     * Smaže konkrétní zařízení podle jeho identifikátoru (hardware ID).
     */
    @Modifying
    @Transactional
    void deleteByDeviceIdentifier(String deviceIdentifier);

    /**
     * Bezpečně smaže konkrétní zařízení podle databázového ID a vlastníka.
     * Tato metoda je klíčová pro nové API odhlašování jednotlivých zařízení.
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.id = :id AND d.user = :user")
    void deleteByIdAndUser(@Param("id") Long id, @Param("user") UserEntity user);

    /**
     * Hromadné smazání všech zařízení uživatele.
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM DeviceEntity d WHERE d.user = :user")
    void deleteAllByUser(@Param("user") UserEntity user);

    /**
     * Zjistí, zda uživatel již má registrované konkrétní zařízení.
     */
    boolean existsByDeviceIdentifierAndUser(String deviceIdentifier, UserEntity user);
}