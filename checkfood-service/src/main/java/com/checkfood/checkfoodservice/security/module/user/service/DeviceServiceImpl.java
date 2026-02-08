package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.repository.DeviceRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Servisní vrstva pro správu životního cyklu klientských zařízení a relací.
 * Zajišťuje integritu Refresh tokenů skrze validaci aktivních session v databázi.
 * Implementuje logiku pro sledování geolokace (IP) a identifikaci terminálů (User-Agent).
 */
@Service
@RequiredArgsConstructor
@Transactional
public class DeviceServiceImpl implements DeviceService {

    private final DeviceRepository deviceRepository;
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;
    private final UserLogger userLogger;

    /**
     * Zajišťuje persistenci nebo aktualizaci stavu zařízení.
     * Implementuje logiku 'upsert' na základě unikátního identifikátoru a vazby na uživatele.
     *
     * @param device transportní entita s daty o zařízení
     * @return synchronizovaná perzistentní entita
     */
    @Override
    public DeviceEntity save(DeviceEntity device) {
        return deviceRepository.findByDeviceIdentifierAndUser(device.getDeviceIdentifier(), device.getUser())
                .map(existingDevice -> {
                    // ✅ Sjednoceno na lastLogin: Aktualizace stávající relace
                    existingDevice.setLastLogin(LocalDateTime.now());
                    existingDevice.setLastIpAddress(request.getRemoteAddr());
                    existingDevice.setUserAgent(request.getHeader("User-Agent"));
                    existingDevice.setDeviceName(device.getDeviceName());
                    return deviceRepository.save(existingDevice);
                })
                .orElseGet(() -> {
                    // Inicializace nové relace
                    DeviceEntity saved = deviceRepository.save(device);
                    userLogger.logUserCreated("Nové zařízení registrováno: " + device.getDeviceIdentifier());
                    return saved;
                });
    }

    /**
     * Predikát pro ověření existence aktivní relace.
     * Kritický bod pro bezpečnostní kontrolu při rotaci JWT Refresh tokenů.
     */
    @Override
    @Transactional(readOnly = true)
    public boolean existsByIdentifierAndUser(String identifier, UserEntity user) {
        return deviceRepository.existsByDeviceIdentifierAndUser(identifier, user);
    }

    /**
     * Aktualizace časové značky aktivity při každé interakci (např. refresh tokenu).
     * Umožňuje sledování pohybu uživatele mezi sítěmi (IP update).
     *
     * @param identifier unikátní HW/SW identifikátor klientské aplikace
     */
    @Override
    public void updateLastLogin(String identifier) {
        deviceRepository.findByDeviceIdentifier(identifier)
                .ifPresent(device -> {
                    // ✅ Sjednoceno na lastLogin
                    device.setLastLogin(LocalDateTime.now());
                    device.setLastIpAddress(request.getRemoteAddr());
                    deviceRepository.save(device);
                });
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<DeviceEntity> findById(Long id) {
        return deviceRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<DeviceEntity> findByIdentifier(String deviceIdentifier) {
        return deviceRepository.findByDeviceIdentifier(deviceIdentifier);
    }

    @Override
    @Transactional(readOnly = true)
    public List<DeviceEntity> findAllByUser(UserEntity user) {
        return deviceRepository.findAllByUser(user);
    }

    /**
     * Okamžitá terminace relace na základě identifikátoru.
     * Používá se pro standardní logout proces.
     */
    @Override
    public void deleteByIdentifier(String deviceIdentifier) {
        userLogger.logUserDeleted("Terminace zařízení: " + deviceIdentifier);
        deviceRepository.deleteByDeviceIdentifier(deviceIdentifier);
    }

    /**
     * Autorizované odstranění konkrétní relace.
     * Zajišťuje, že uživatel může manipulovat pouze s vlastními registrovanými zařízeními.
     */
    @Override
    public void removeByIdAndUser(Long deviceId, UserEntity user) {
        userLogger.logUserDeleted("Odstranění relace ID: " + deviceId + " pro uživatele: " + user.getEmail());

        if (!deviceRepository.existsById(deviceId)) {
            throw UserException.invalidOperation("Specifikované zařízení neexistuje.");
        }

        deviceRepository.deleteByIdAndUser(deviceId, user);
        publishAudit(user.getId(), AuditAction.LOGOUT);
    }

    /**
     * Hromadná invalidace všech aktivních relací uživatelského účtu.
     * Bezpečnostní mechanismus pro vynucení odhlášení ze všech terminálů.
     */
    @Override
    public void removeAllByUser(UserEntity user) {
        userLogger.logUserDeleted("Kompletní flush relací pro uživatele ID: " + user.getId());
        deviceRepository.deleteAllByUser(user);
        publishAudit(user.getId(), AuditAction.LOGOUT);
    }

    /**
     * Integrace se systémem asynchronního auditu pro záznam bezpečnostních událostí.
     */
    private void publishAudit(Long userId, AuditAction action) {
        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        userId,
                        action,
                        AuditStatus.SUCCESS,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }
}