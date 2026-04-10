package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.infrastructure.storage.service.PublicStorage;
import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantPhotoResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantPhoto;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantPhotoRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Implementace správy mediálního obsahu restaurace pomocí veřejného GCS bucketu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@Transactional
public class RestaurantMediaServiceImpl implements RestaurantMediaService {

    private static final Set<String> ALLOWED_MIME = Set.of(
            "image/jpeg", "image/png", "image/webp"
    );
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024L;
    private static final int MAX_GALLERY_PHOTOS = 30;

    private final RestaurantRepository restaurantRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final RestaurantPhotoRepository photoRepository;
    private final UserService userService;
    private final StorageService storageService;

    public RestaurantMediaServiceImpl(
            RestaurantRepository restaurantRepository,
            RestaurantEmployeeRepository employeeRepository,
            RestaurantPhotoRepository photoRepository,
            UserService userService,
            @PublicStorage StorageService storageService) {
        this.restaurantRepository = restaurantRepository;
        this.employeeRepository = employeeRepository;
        this.photoRepository = photoRepository;
        this.userService = userService;
        this.storageService = storageService;
    }

    // ---------- LOGO ----------

    @Override
    public String uploadLogo(String userEmail, UUID restaurantId, MultipartFile file) {
        Restaurant restaurant = authorizeAndGetRestaurant(userEmail, restaurantId);
        validateFile(file);

        String oldUrl = restaurant.getLogoUrl();
        String newUrl = storeAndUrl(file, "restaurants/" + restaurant.getId() + "/logo");

        restaurant.setLogoUrl(newUrl);
        restaurant.setUpdatedAt(LocalDateTime.now());
        restaurantRepository.save(restaurant);

        if (oldUrl != null) {
            deleteFromStorageByUrl(oldUrl);
        }
        return newUrl;
    }

    @Override
    public void deleteLogo(String userEmail, UUID restaurantId) {
        Restaurant restaurant = authorizeAndGetRestaurant(userEmail, restaurantId);
        String oldUrl = restaurant.getLogoUrl();
        restaurant.setLogoUrl(null);
        restaurant.setUpdatedAt(LocalDateTime.now());
        restaurantRepository.save(restaurant);
        if (oldUrl != null) {
            deleteFromStorageByUrl(oldUrl);
        }
    }

    // ---------- COVER ----------

    @Override
    public String uploadCover(String userEmail, UUID restaurantId, MultipartFile file) {
        Restaurant restaurant = authorizeAndGetRestaurant(userEmail, restaurantId);
        validateFile(file);

        String oldUrl = restaurant.getCoverImageUrl();
        String newUrl = storeAndUrl(file, "restaurants/" + restaurant.getId() + "/cover");

        restaurant.setCoverImageUrl(newUrl);
        restaurant.setUpdatedAt(LocalDateTime.now());
        restaurantRepository.save(restaurant);

        if (oldUrl != null) {
            deleteFromStorageByUrl(oldUrl);
        }
        return newUrl;
    }

    @Override
    public void deleteCover(String userEmail, UUID restaurantId) {
        Restaurant restaurant = authorizeAndGetRestaurant(userEmail, restaurantId);
        String oldUrl = restaurant.getCoverImageUrl();
        restaurant.setCoverImageUrl(null);
        restaurant.setUpdatedAt(LocalDateTime.now());
        restaurantRepository.save(restaurant);
        if (oldUrl != null) {
            deleteFromStorageByUrl(oldUrl);
        }
    }

    // ---------- GALLERY ----------

    @Override
    public RestaurantPhotoResponse addGalleryPhoto(String userEmail, UUID restaurantId, MultipartFile file) {
        Restaurant restaurant = authorizeAndGetRestaurant(userEmail, restaurantId);
        validateFile(file);

        long count = photoRepository.countByRestaurantId(restaurant.getId());
        if (count >= MAX_GALLERY_PHOTOS) {
            throw new ResponseStatusException(HttpStatus.PAYLOAD_TOO_LARGE,
                    "Galerie restaurace je plná (max " + MAX_GALLERY_PHOTOS + " fotek).");
        }

        String directory = "restaurants/" + restaurant.getId() + "/gallery";
        String filename = randomFilename(file);
        try {
            String objectPath = storageService.store(directory, filename, file.getBytes(), file.getContentType());
            String url = storageService.getDownloadUrl(objectPath);

            RestaurantPhoto photo = RestaurantPhoto.builder()
                    .restaurantId(restaurant.getId())
                    .photoUrl(url)
                    .objectPath(objectPath)
                    .sortOrder((int) count)
                    .build();
            RestaurantPhoto saved = photoRepository.save(photo);
            return toResponse(saved);
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Chyba při ukládání fotky: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<RestaurantPhotoResponse> listGalleryPhotos(UUID restaurantId) {
        return photoRepository
                .findAllByRestaurantIdOrderBySortOrderAscCreatedAtAsc(restaurantId)
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @Override
    public void deleteGalleryPhoto(String userEmail, UUID restaurantId, UUID photoId) {
        Restaurant restaurant = authorizeAndGetRestaurant(userEmail, restaurantId);
        RestaurantPhoto photo = photoRepository.findById(photoId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Fotka nenalezena."));

        if (!photo.getRestaurantId().equals(restaurant.getId())) {
            throw RestaurantException.accessDenied();
        }
        storageService.delete(photo.getObjectPath());
        photoRepository.delete(photo);
    }

    // ---------- HELPERS ----------

    private Restaurant authorizeAndGetRestaurant(String userEmail, UUID restaurantId) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findByUserIdAndRestaurantId(user.getId(), restaurantId)
                .orElseThrow(RestaurantException::noRestaurantAssigned);
        requireRole(membership, RestaurantEmployeeRole.OWNER, RestaurantEmployeeRole.MANAGER);
        requirePermission(membership, EmployeePermission.EDIT_RESTAURANT_INFO);
        return membership.getRestaurant();
    }

    private void requireRole(RestaurantEmployee membership, RestaurantEmployeeRole... allowedRoles) {
        for (var role : allowedRoles) {
            if (membership.getRole() == role) return;
        }
        throw RestaurantException.accessDenied();
    }

    private void requirePermission(RestaurantEmployee membership, EmployeePermission permission) {
        if (!membership.hasPermission(permission)) {
            throw RestaurantException.permissionDenied(permission.name());
        }
    }

    private void validateFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Soubor je prázdný.");
        }
        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_MIME.contains(contentType.toLowerCase())) {
            throw new ResponseStatusException(HttpStatus.UNSUPPORTED_MEDIA_TYPE,
                    "Nepodporovaný typ. Povoleny: " + ALLOWED_MIME);
        }
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new ResponseStatusException(HttpStatus.PAYLOAD_TOO_LARGE,
                    "Soubor je příliš velký (max 10 MB).");
        }
    }

    private String randomFilename(MultipartFile file) {
        String extension = ".jpg";
        String original = file.getOriginalFilename();
        if (original != null && original.contains(".")) {
            extension = original.substring(original.lastIndexOf("."));
        }
        return UUID.randomUUID() + extension;
    }

    private String storeAndUrl(MultipartFile file, String directory) {
        try {
            String filename = randomFilename(file);
            String objectPath = storageService.store(directory, filename, file.getBytes(), file.getContentType());
            return storageService.getDownloadUrl(objectPath);
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Chyba při ukládání souboru: " + e.getMessage(), e);
        }
    }

    /**
     * Pokusí se z plné URL veřejného GCS souboru extrahovat object path a smazat ho ze storage.
     * Pokud URL neodpovídá známému formátu (např. lokální /uploads/...), použije ji jako object path přímo.
     */
    private void deleteFromStorageByUrl(String url) {
        if (url == null || url.isBlank()) return;
        String objectPath;
        int idx = url.indexOf("/checkfood-uploads/");
        if (idx >= 0) {
            objectPath = url.substring(idx + "/checkfood-uploads/".length());
        } else if (url.startsWith("/uploads/public/")) {
            objectPath = url.substring("/uploads/public/".length());
        } else {
            log.warn("[RestaurantMedia] Nelze extrahovat object path z URL: {}", url);
            return;
        }
        storageService.delete(objectPath);
    }

    private RestaurantPhotoResponse toResponse(RestaurantPhoto photo) {
        return RestaurantPhotoResponse.builder()
                .id(photo.getId())
                .url(photo.getPhotoUrl())
                .sortOrder(photo.getSortOrder())
                .build();
    }
}
