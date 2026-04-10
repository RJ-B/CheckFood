package com.checkfood.checkfoodservice.module.restaurant.menu.controller;

import com.checkfood.checkfoodservice.infrastructure.storage.service.PublicStorage;
import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * REST controller pro správu obrázků položek menu. Vlastník/manager restaurace
 * může pro každou položku menu nahrát/nahradit/smazat jeden obrázek.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@RestController
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
@Transactional
public class MenuItemMediaController {

    private static final Set<String> ALLOWED_MIME = Set.of(
            "image/jpeg", "image/png", "image/webp"
    );
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024L;

    private final MenuItemRepository menuItemRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final UserService userService;
    private final StorageService storageService;

    public MenuItemMediaController(
            MenuItemRepository menuItemRepository,
            RestaurantEmployeeRepository employeeRepository,
            UserService userService,
            @PublicStorage StorageService storageService) {
        this.menuItemRepository = menuItemRepository;
        this.employeeRepository = employeeRepository;
        this.userService = userService;
        this.storageService = storageService;
    }

    @PostMapping(value = "/api/v1/owner/restaurants/{restaurantId}/menu-items/{itemId}/image",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Map<String, String>> uploadImage(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId,
            @PathVariable UUID itemId,
            @RequestParam("file") MultipartFile file) {

        MenuItem item = authorizeAndGetItem(userDetails.getUsername(), restaurantId, itemId);
        validateFile(file);

        String oldUrl = item.getImageUrl();
        String directory = "restaurants/" + restaurantId + "/menu-items/" + itemId;
        String filename = randomFilename(file);
        try {
            String objectPath = storageService.store(directory, filename, file.getBytes(), file.getContentType());
            String url = storageService.getDownloadUrl(objectPath);
            item.setImageUrl(url);
            menuItemRepository.save(item);

            if (oldUrl != null) {
                deleteFromStorageByUrl(oldUrl);
            }
            return ResponseEntity.ok(Map.of("url", url));
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Chyba při ukládání obrázku: " + e.getMessage(), e);
        }
    }

    @DeleteMapping("/api/v1/owner/restaurants/{restaurantId}/menu-items/{itemId}/image")
    public ResponseEntity<Void> deleteImage(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId,
            @PathVariable UUID itemId) {
        MenuItem item = authorizeAndGetItem(userDetails.getUsername(), restaurantId, itemId);
        String oldUrl = item.getImageUrl();
        item.setImageUrl(null);
        menuItemRepository.save(item);
        if (oldUrl != null) {
            deleteFromStorageByUrl(oldUrl);
        }
        return ResponseEntity.noContent().build();
    }

    // ---------- HELPERS ----------

    private MenuItem authorizeAndGetItem(String userEmail, UUID restaurantId, UUID itemId) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findByUserIdAndRestaurantId(user.getId(), restaurantId)
                .orElseThrow(RestaurantException::noRestaurantAssigned);
        requireRole(membership, RestaurantEmployeeRole.OWNER, RestaurantEmployeeRole.MANAGER);
        if (!membership.hasPermission(EmployeePermission.EDIT_RESTAURANT_INFO)) {
            throw RestaurantException.permissionDenied(EmployeePermission.EDIT_RESTAURANT_INFO.name());
        }

        MenuItem item = menuItemRepository.findById(itemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Položka menu nenalezena."));
        if (!item.getRestaurantId().equals(restaurantId)) {
            throw RestaurantException.accessDenied();
        }
        return item;
    }

    private void requireRole(RestaurantEmployee membership, RestaurantEmployeeRole... allowedRoles) {
        for (var role : allowedRoles) {
            if (membership.getRole() == role) return;
        }
        throw RestaurantException.accessDenied();
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
                    "Soubor je příliš velký (max 5 MB).");
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

    private void deleteFromStorageByUrl(String url) {
        if (url == null || url.isBlank()) return;
        String objectPath;
        int idx = url.indexOf("/checkfood-uploads/");
        if (idx >= 0) {
            objectPath = url.substring(idx + "/checkfood-uploads/".length());
        } else if (url.startsWith("/uploads/public/")) {
            objectPath = url.substring("/uploads/public/".length());
        } else {
            log.warn("[MenuItemMedia] Nelze extrahovat object path z URL: {}", url);
            return;
        }
        storageService.delete(objectPath);
    }
}
