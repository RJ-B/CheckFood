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

@RestController
@RequestMapping("/api/v1/uploads")
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
@RequiredArgsConstructor
public class UploadController {

    private final StorageService storageService;

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
}
