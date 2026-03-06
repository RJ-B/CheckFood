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
 * Service pro správu zařízení uživatelů (Sessions).
 *
 * Verze JDK 21:
 * - Bez auditů.
 * - Logování pouze úspěšných operací.
 * - Konzistentní používání UserException.
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
                    // Update existujícího zařízení (Meta data)
                    existingDevice.setLastLogin(LocalDateTime.now());
                    try {
                        existingDevice.setLastIpAddress(request.getRemoteAddr());
                        existingDevice.setUserAgent(request.getHeader("User-Agent"));
                    } catch (Exception ignored) {}

                    existingDevice.setDeviceName(device.getDeviceName());
                    existingDevice.setDeviceType(device.getDeviceType());

                    // Logovat update není nutné při každém requestu, bylo by to hlučné
                    return deviceRepository.save(existingDevice);
                })
                .orElseGet(() -> {
                    // Registrace nového zařízení
                    try {
                        device.setLastIpAddress(request.getRemoteAddr());
                        device.setUserAgent(request.getHeader("User-Agent"));
                    } catch (Exception ignored) {}

                    var saved = deviceRepository.save(device);

                    // Logování úspěchu
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
    @Transactional(readOnly = true)
    public List<DeviceResponse> findAllUserDevicesWithStatus(String email, String accessToken) {
        // 1. Získání uživatele
        var user = userRepository.findByEmail(email)
                .orElseThrow(() -> UserException.userNotFound(email));

        // 2. Načtení všech relací
        var devices = deviceRepository.findAllByUser(user);

        // 3. Extrakce ID aktuálního zařízení (pokud selže, vyhodí JwtException, což je OK)
        String currentDeviceIdentifier = jwtService.extractDeviceIdentifier(accessToken);

        // 4. Mapování
        return userMapper.toDeviceResponseList(devices, currentDeviceIdentifier);
    }

    @Override
    public void deleteByIdentifier(String deviceIdentifier) {
        // Zde můžeme ověřit existenci, pokud chceme být striktní, ale delete je často idempotentní
        deviceRepository.deleteByDeviceIdentifier(deviceIdentifier);

        // Logování úspěchu (bez kontextu uživatele, pokud ho nemáme po ruce, logujeme jen ID)
        userLogger.logDeviceRemoved(deviceIdentifier, "unknown-user");
    }

    @Override
    public void removeByIdentifierAndUser(String deviceIdentifier, UserEntity user) {
        var deviceOpt = deviceRepository.findByDeviceIdentifierAndUser(deviceIdentifier, user);

        if (deviceOpt.isEmpty()) {
            // Vyhazujeme byznys výjimku
            throw UserException.invalidOperation("Zařízení neexistuje nebo nepatří tomuto uživateli.");
        }

        deviceRepository.deleteByDeviceIdentifierAndUser(deviceIdentifier, user);

        // Logování úspěchu
        userLogger.logDeviceRemoved(deviceIdentifier, user.getEmail());
    }

    @Override
    public void removeAllByUser(UserEntity user) {
        long count = deviceRepository.countByUser(user);
        deviceRepository.deleteAllByUser(user);

        // Logování úspěchu
        userLogger.logAllDevicesRemoved(user.getEmail(), (int) count);
    }

    @Override
    public void removeAllByUserExceptCurrent(UserEntity user, String currentDeviceIdentifier) {
        long count = deviceRepository.countByUser(user);
        deviceRepository.deleteAllByUserExceptDevice(user, currentDeviceIdentifier);

        userLogger.logAllDevicesRemoved(user.getEmail(), (int) Math.max(0, count - 1));
    }

    // --- Pomocné metody ---

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

        // Pro logování si vytáhneme identifier, pokud chceme být precizní (volitelné)
        // Zde stačí smazat
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
            // Pri zapnuti: ulozit FCM token
            device.setFcmToken(fcmToken);
        } else {
            // Pri vypnuti: smazat FCM token (GDPR — neodesílat na deaktivovany token)
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