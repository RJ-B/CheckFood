package com.checkfood.checkfoodservice.security.user.service;

import com.checkfood.checkfoodservice.security.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import java.util.List;
import java.util.Optional;

/**
 * Rozhraní pro správu uživatelských zařízení a relací.
 */
public interface DeviceService {

    DeviceEntity save(DeviceEntity device);

    Optional<DeviceEntity> findById(Long id);

    Optional<DeviceEntity> findByIdentifier(String deviceIdentifier);

    List<DeviceEntity> findAllByUser(UserEntity user);

    /**
     * Kontroluje, zda dané zařízení stále existuje pro konkrétního uživatele.
     * Klíčové pro validaci Refresh Tokenu a ochranu proti zneužití po odhlášení.
     */
    boolean existsByIdentifierAndUser(String identifier, UserEntity user);

    /**
     * Aktualizuje čas poslední aktivity zařízení a IP adresu.
     * Volá se při každém úspěšném obnovení access tokenu.
     */
    void updateLastActive(String identifier);

    /**
     * Odstraní zařízení podle jeho unikátního identifikátoru.
     */
    void deleteByIdentifier(String deviceIdentifier);

    /**
     * Bezpečné odstranění zařízení s kontrolou vlastníka.
     */
    void removeByIdAndUser(Long deviceId, UserEntity user);

    /**
     * Odstraní všechna zařízení (relace) daného uživatele.
     */
    void removeAllByUser(UserEntity user);
}