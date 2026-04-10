package com.checkfood.checkfoodservice.infrastructure.storage.service;

import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;

/**
 * Implementace souborového úložiště ukládající soubory na lokální filesystem.
 * Pro lokální vývoj — neexistují signed URL, vždy vrací relativní cestu pod {@code /uploads/...}.
 *
 * <p>Instanciuje se přes {@link com.checkfood.checkfoodservice.infrastructure.storage.config.StorageConfig}
 * — pro každý logický bucket (public/private) jeden subadresář pod {@code uploadDir}.
 *
 * @author Rostislav Jirák
 * @version 2.0.0
 */
@Slf4j
public class LocalFilesystemStorageService implements StorageService {

    private final Path uploadDir;
    private final String urlPrefix;

    /**
     * @param uploadDirPath kořenový adresář pro ukládání souborů (např. {@code ./uploads/public})
     * @param urlPrefix     prefix vracený z {@link #getDownloadUrl(String)} (např. {@code /uploads/public})
     */
    public LocalFilesystemStorageService(String uploadDirPath, String urlPrefix) {
        this.uploadDir = Paths.get(uploadDirPath).toAbsolutePath().normalize();
        this.urlPrefix = urlPrefix.endsWith("/") ? urlPrefix.substring(0, urlPrefix.length() - 1) : urlPrefix;
        try {
            Files.createDirectories(this.uploadDir);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory: " + uploadDirPath, e);
        }
        log.info("[LocalStorage] Initialized dir={} urlPrefix={}", this.uploadDir, this.urlPrefix);
    }

    @Override
    public String store(String directory, String filename, byte[] data, String contentType) {
        if (directory == null || directory.contains("..") || directory.startsWith("/")) {
            throw new IllegalArgumentException("Neplatný adresář úložiště: " + directory);
        }
        try {
            Path targetDir = uploadDir.resolve(directory).normalize();
            if (!targetDir.startsWith(uploadDir)) {
                throw new SecurityException("Invalid directory path");
            }
            Files.createDirectories(targetDir);

            Path targetFile = targetDir.resolve(filename).normalize();
            if (!targetFile.startsWith(targetDir)) {
                throw new SecurityException("Invalid filename");
            }

            Files.write(targetFile, data);
            log.debug("Stored file: {}", targetFile);

            return directory + "/" + filename;
        } catch (IOException e) {
            throw new RuntimeException("Failed to store file: " + filename, e);
        }
    }

    @Override
    public void delete(String path) {
        if (path == null || path.isBlank()) {
            return;
        }
        try {
            Path targetFile = uploadDir.resolve(path).normalize();
            if (!targetFile.startsWith(uploadDir)) {
                throw new SecurityException("Invalid path");
            }
            Files.deleteIfExists(targetFile);
            log.debug("Deleted file: {}", targetFile);
        } catch (IOException e) {
            log.warn("Failed to delete file: {}", path, e);
        }
    }

    @Override
    public String getDownloadUrl(String path) {
        if (path == null || path.isBlank()) {
            return null;
        }
        return urlPrefix + "/" + path;
    }

    @Override
    public String getDownloadUrl(String path, Duration ttl) {
        return getDownloadUrl(path);
    }
}
