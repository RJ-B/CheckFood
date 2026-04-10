package com.checkfood.checkfoodservice.security.module.user.controller;

import com.checkfood.checkfoodservice.infrastructure.storage.service.PrivateStorage;
import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * REST controller pro správu avataru přihlášeného uživatele.
 * Avatary se ukládají do <b>privátního</b> GCS bucketu — všechny URL pro čtení
 * jsou V4 signed URL s defaultní platností 1 hodina.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@RestController
@Transactional
public class UserMediaController {

    private static final Set<String> ALLOWED_MIME = Set.of(
            "image/jpeg", "image/png", "image/webp"
    );
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024L;

    private final UserRepository userRepository;
    private final StorageService privateStorage;

    public UserMediaController(
            UserRepository userRepository,
            @PrivateStorage StorageService privateStorage) {
        this.userRepository = userRepository;
        this.privateStorage = privateStorage;
    }

    @PostMapping(value = "/api/user/me/avatar", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Map<String, String>> uploadAvatar(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("file") MultipartFile file) {

        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Uživatel nenalezen."));
        validateFile(file);

        String oldPath = user.getAvatarObjectPath();
        String directory = "users/" + user.getId() + "/avatar";
        String filename = randomFilename(file);

        try {
            String newPath = privateStorage.store(directory, filename, file.getBytes(), file.getContentType());
            String signedUrl = privateStorage.getDownloadUrl(newPath);

            user.setAvatarObjectPath(newPath);
            user.setUpdatedAt(LocalDateTime.now());
            userRepository.save(user);

            if (oldPath != null && !oldPath.equals(newPath)) {
                privateStorage.delete(oldPath);
            }
            return ResponseEntity.ok(Map.of("url", signedUrl));
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Chyba při ukládání avataru: " + e.getMessage(), e);
        }
    }

    @DeleteMapping("/api/user/me/avatar")
    public ResponseEntity<Void> deleteAvatar(
            @AuthenticationPrincipal UserDetails userDetails) {
        UserEntity user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Uživatel nenalezen."));
        String oldPath = user.getAvatarObjectPath();
        user.setAvatarObjectPath(null);
        user.setUpdatedAt(LocalDateTime.now());
        userRepository.save(user);
        if (oldPath != null) {
            privateStorage.delete(oldPath);
        }
        return ResponseEntity.noContent().build();
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
}
