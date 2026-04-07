package com.checkfood.checkfoodservice.infrastructure.storage.controller;

import com.checkfood.checkfoodservice.infrastructure.storage.dto.UploadResponse;
import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;

import java.io.IOException;
import java.util.Set;
import java.util.UUID;

/**
 * REST kontroler pro nahrávání souborů do úložiště.
 * Přístupný pro uživatele s rolí OWNER nebo MANAGER.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/uploads")
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
@RequiredArgsConstructor
public class UploadController {

    private static final Set<String> ALLOWED_MIME_TYPES = Set.of(
            "image/jpeg", "image/png", "image/webp", "image/gif"
    );

    /** Maximální velikost souboru: 10 MB */
    private static final long MAX_FILE_SIZE_BYTES = 10 * 1024 * 1024L;

    private final StorageService storageService;

    /**
     * Nahraje soubor do zadaného adresáře úložiště a vrátí veřejnou URL.
     *
     * @param file      nahrávaný soubor
     * @param directory cílový adresář v úložišti
     * @return URL a název uloženého souboru
     * @throws IOException při chybě čtení obsahu souboru
     */
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<UploadResponse> upload(
            @RequestParam("file") MultipartFile file,
            @RequestParam("directory") String directory) throws IOException {

        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_MIME_TYPES.contains(contentType.toLowerCase())) {
            throw new ResponseStatusException(HttpStatus.UNSUPPORTED_MEDIA_TYPE,
                    "Nepodporovaný typ souboru. Povoleny jsou: " + ALLOWED_MIME_TYPES);
        }

        if (file.getSize() > MAX_FILE_SIZE_BYTES) {
            throw new ResponseStatusException(HttpStatus.PAYLOAD_TOO_LARGE,
                    "Soubor je příliš velký. Maximální velikost je 10 MB.");
        }

        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String filename = UUID.randomUUID() + extension;

        String path = storageService.store(
                directory,
                filename,
                file.getBytes(),
                file.getContentType()
        );

        String url = storageService.getPublicUrl(path);

        return ResponseEntity.ok(UploadResponse.builder()
                .url(url)
                .filename(filename)
                .build());
    }

    /**
     * Smaže soubor z úložiště podle jeho relativní cesty.
     * Cesta je extrahována z URL (odstraní prefix /uploads/ nebo GCS base URL).
     *
     * @param path relativní cesta k souboru (např. profile/abc.jpg)
     * @return 204 No Content při úspěchu
     */
    @DeleteMapping
    public ResponseEntity<Void> delete(@RequestParam("path") String path) {
        storageService.delete(path);
        return ResponseEntity.noContent().build();
    }
}
