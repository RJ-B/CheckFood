package com.checkfood.checkfoodservice.security.user.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.repository.DeviceRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Služba pro správu uživatelských zařízení a relací.
 * Zajišťuje, že JWT tokeny jsou validní pouze pro existující a aktivní relace.
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class DeviceServiceImpl implements DeviceService {

    private final DeviceRepository deviceRepository;
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;

    @Override
    public DeviceEntity save(DeviceEntity device) {
        return deviceRepository.findByDeviceIdentifierAndUser(device.getDeviceIdentifier(), device.getUser())
                .map(existingDevice -> {
                    existingDevice.setLastActiveAt(LocalDateTime.now());
                    existingDevice.setLastIpAddress(request.getRemoteAddr());
                    existingDevice.setUserAgent(request.getHeader("User-Agent"));
                    existingDevice.setDeviceName(device.getDeviceName());
                    return deviceRepository.save(existingDevice);
                })
                .orElseGet(() -> {
                    DeviceEntity saved = deviceRepository.save(device);
                    log.info("Nové zařízení registrováno pro uživatele ID: {}", device.getUser().getId());
                    return saved;
                });
    }

    // --- DOPLNĚNÉ METODY PRO AUTH SERVICE ---

    @Override
    @Transactional(readOnly = true)
    public boolean existsByIdentifierAndUser(String identifier, UserEntity user) {
        // Klíčová metoda pro ochranu proti zneužití - kontroluje, zda relace stále žije v DB
        return deviceRepository.existsByDeviceIdentifierAndUser(identifier, user);
    }

    @Override
    public void updateLastActive(String identifier) {
        // Aktualizuje čas poslední aktivity při každém refresh tokenu
        deviceRepository.findByDeviceIdentifier(identifier)
                .ifPresent(device -> {
                    device.setLastActiveAt(LocalDateTime.now());
                    device.setLastIpAddress(request.getRemoteAddr());
                    deviceRepository.save(device);
                });
    }

    // ----------------------------------------

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

    @Override
    public void deleteByIdentifier(String deviceIdentifier) {
        log.info("Odstraňování zařízení s identifikátorem: {}", deviceIdentifier);
        deviceRepository.deleteByDeviceIdentifier(deviceIdentifier);
    }

    @Override
    public void removeByIdAndUser(Long deviceId, UserEntity user) {
        log.info("Pokus o odhlášení zařízení ID: {} pro uživatele: {}", deviceId, user.getEmail());

        if (!deviceRepository.existsById(deviceId)) {
            throw new IllegalArgumentException("Zařízení s ID " + deviceId + " neexistuje.");
        }

        deviceRepository.deleteByIdAndUser(deviceId, user);
        log.info("Zařízení ID: {} bylo zpracováno pro odhlášení.", deviceId);
        publishAudit(user.getId(), AuditAction.LOGOUT);
    }

    @Override
    public void removeAllByUser(UserEntity user) {
        log.warn("Hromadné odhlášení všech zařízení pro uživatele ID: {}", user.getId());
        deviceRepository.deleteAllByUser(user);
        publishAudit(user.getId(), AuditAction.LOGOUT);
    }

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