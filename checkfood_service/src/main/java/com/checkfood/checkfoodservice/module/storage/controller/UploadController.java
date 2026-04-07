package com.checkfood.checkfoodservice.module.storage.controller;

import com.checkfood.checkfoodservice.module.storage.dto.UploadResponse;
import com.checkfood.checkfoodservice.module.storage.service.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
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
