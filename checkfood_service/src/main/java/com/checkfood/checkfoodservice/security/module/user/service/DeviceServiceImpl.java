package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.dto.response.DeviceResponse;
import com.checkfood.checkfoodservice.security.module.user.dto.response.NotificationPreferenceResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.module.user.repository.DeviceRepository;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Implementace servisní vrstvy pro správu klientských zařízení a jejich relací.
 * Poskytuje operace pro registraci, aktualizaci, deaktivaci a odstraňování zařízení
 * s důrazem na bezpečnostní kontroly vlastnictví a konzistentní logování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional
public class DeviceServiceImpl implements DeviceService {

    private final DeviceRepository deviceRepository;
    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final UserMapper userMapper;
    private final HttpServletRequest request;
    private final UserLogger userLogger;

    @Override
    public DeviceEntity save(DeviceEntity device) {
        return deviceRepository.findByDeviceIdentifierAndUser(device.getDeviceIdentifier(), device.getUser())
                .map(existingDevice -> {
                    existingDevice.setLastLogin(LocalDateTime.now());
                    existingDevice.setActive(true);
                    try {
                        existingDevice.setLastIpAddress(request.getRemoteAddr());
                        existingDevice.setUserAgent(request.getHeader("User-Agent"));
                    } catch (Exception ignored) {}

                    existingDevice.setDeviceName(device.getDeviceName());
                    existingDevice.setDeviceType(device.getDeviceType());

                    return deviceRepository.save(existingDevice);
                })
                .orElseGet(() -> {
                    try {
                        device.setLastIpAddress(request.getRemoteAddr());
                        device.setUserAgent(request.getHeader("User-Agent"));
                    } catch (Exception ignored) {}

                    var saved = deviceRepository.save(device);
                    userLogger.logDeviceRegistered(saved.getDeviceIdentifier(), device.getUser().getEmail());
                    return saved;
                });
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByIdentifierAndUser(String identifier, UserEntity user) {
        return deviceRepository.existsByDeviceIdentifierAndUser(identifier, user);
    }

    @Override
    public void updateLastLogin(String identifier) {
        deviceRepository.findByDeviceIdentifier(identifier)
                .ifPresent(device -> {
                    device.setLastLogin(LocalDateTime.now());
                    try {
                        device.setLastIpAddress(request.getRemoteAddr());
                    } catch (Exception ignored) {}
                    deviceRepository.save(device);
                });
    }

    @Override
    @Transactional
    public List<DeviceResponse> findAllUserDevicesWithStatus(String email, String accessToken) {
        var user = userRepository.findByEmail(email)
                .orElseThrow(() -> UserException.userNotFound(email));

        String currentDeviceIdentifier = jwtService.extractDeviceIdentifier(accessToken);

        if (currentDeviceIdentifier != null
                && !deviceRepository.existsByDeviceIdentifierAndUser(currentDeviceIdentifier, user)) {
            var newDevice = DeviceEntity.builder()
                    .deviceIdentifier(currentDeviceIdentifier)
                    .deviceName("Unknown Device")
                    .deviceType("UNKNOWN")
                    .user(user)
                    .active(true)
                    .lastLogin(java.time.LocalDateTime.now())
                    .build();
            deviceRepository.save(newDevice);
        }

        var devices = deviceRepository.findAllByUser(user);

        return userMapper.toDeviceResponseList(devices, currentDeviceIdentifier);
    }

    @Override
    public void deleteByIdentifier(String deviceIdentifier) {
        deviceRepository.deleteByDeviceIdentifier(deviceIdentifier);
        userLogger.logDeviceRemoved(deviceIdentifier, "unknown-user");
    }

    @Override
    public void removeByIdentifierAndUser(String deviceIdentifier, UserEntity user) {
        var deviceOpt = deviceRepository.findByDeviceIdentifierAndUser(deviceIdentifier, user);

        if (deviceOpt.isEmpty()) {
            throw UserException.invalidOperation("Zařízení neexistuje nebo nepatří tomuto uživateli.");
        }

        deviceRepository.deleteByDeviceIdentifierAndUser(deviceIdentifier, user);
        userLogger.logDeviceRemoved(deviceIdentifier, user.getEmail());
    }

    @Override
    public void removeAllByUser(UserEntity user) {
        long count = deviceRepository.countByUser(user);
        deviceRepository.deleteAllByUser(user);
        userLogger.logAllDevicesRemoved(user.getEmail(), (int) count);
    }

    @Override
    public void removeAllByUserExceptCurrent(UserEntity user, String currentDeviceIdentifier) {
        long count = deviceRepository.countByUser(user);
        deviceRepository.deleteAllByUserExceptDevice(user, currentDeviceIdentifier);

        userLogger.logAllDevicesRemoved(user.getEmail(), (int) Math.max(0, count - 1));
    }

    @Override
    public void deactivateByIdentifierAndUser(String deviceIdentifier, UserEntity user) {
        var device = deviceRepository.findByDeviceIdentifierAndUser(deviceIdentifier, user)
                .orElseThrow(() -> UserException.invalidOperation(
                        "Zařízení neexistuje nebo nepatří tomuto uživateli."));

        device.setActive(false);
        deviceRepository.save(device);

        userLogger.logDeviceRemoved(deviceIdentifier, user.getEmail());
    }

    @Override
    public void deactivateByIdAndUser(Long deviceId, UserEntity user) {
        var device = deviceRepository.findById(deviceId)
                .filter(d -> d.getUser().getId().equals(user.getId()))
                .orElseThrow(() -> UserException.invalidOperation(
                        "Zařízení s ID " + deviceId + " nebylo nalezeno nebo nepatří tomuto uživateli."));

        device.setActive(false);
        deviceRepository.save(device);

        userLogger.logDeviceRemoved("ID:" + deviceId, user.getEmail());
    }

    @Override
    public void deactivateAllByUserExceptCurrent(UserEntity user, String currentDeviceIdentifier) {
        var devices = deviceRepository.findAllByUser(user);
        var toDeactivate = devices.stream()
                .filter(d -> !d.getDeviceIdentifier().equals(currentDeviceIdentifier))
                .peek(d -> d.setActive(false))
                .toList();

        deviceRepository.saveAll(toDeactivate);

        userLogger.logAllDevicesRemoved(user.getEmail(), toDeactivate.size());
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

    @Override
    public void removeByIdAndUser(Long deviceId, UserEntity user) {
        if (!deviceRepository.existsByIdAndUser(deviceId, user)) {
            throw UserException.invalidOperation("Zařízení s ID " + deviceId + " nebylo nalezeno.");
        }

        deviceRepository.deleteByIdAndUser(deviceId, user);

        userLogger.logDeviceRemoved("ID:" + deviceId, user.getEmail());
    }

    @Override
    public NotificationPreferenceResponse updateNotificationPreference(
            String deviceIdentifier, UserEntity user, String fcmToken, boolean notificationsEnabled) {

        DeviceEntity device = deviceRepository.findByDeviceIdentifierAndUser(deviceIdentifier, user)
                .orElseThrow(() -> UserException.invalidOperation(
                        "Zarizeni s identifikatorem '" + deviceIdentifier + "' nebylo nalezeno."));

        device.setNotificationsEnabled(notificationsEnabled);

        if (notificationsEnabled) {
            device.setFcmToken(fcmToken);
        } else {
            device.setFcmToken(null);
        }

        deviceRepository.save(device);

        userLogger.logDeviceRegistered(deviceIdentifier, user.getEmail());

        return NotificationPreferenceResponse.builder()
                .notificationsEnabled(device.isNotificationsEnabled())
                .hasFcmToken(device.getFcmToken() != null && !device.getFcmToken().isBlank())
                .build();
    }

    @Override
    @Transactional(readOnly = true)
    public NotificationPreferenceResponse getNotificationPreference(String deviceIdentifier, UserEntity user) {

        DeviceEntity device = deviceRepository.findByDeviceIdentifierAndUser(deviceIdentifier, user)
                .orElseThrow(() -> UserException.invalidOperation(
                        "Zarizeni s identifikatorem '" + deviceIdentifier + "' nebylo nalezeno."));

        return NotificationPreferenceResponse.builder()
                .notificationsEnabled(device.isNotificationsEnabled())
                .hasFcmToken(device.getFcmToken() != null && !device.getFcmToken().isBlank())
                .build();
    }
}