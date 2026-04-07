package com.checkfood.checkfoodservice.infrastructure.storage.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Implementace souborového úložiště ukládající soubory na lokální filesystem.
 * Aktivní pro profily {@code local} a {@code test}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Service
@Profile({"local", "test"})
public class LocalFilesystemStorageService implements StorageService {

    private final Path uploadDir;

    /**
     * Vytvoří službu a zajistí existenci konfigurovaneho adresáře pro nahrávání souborů.
     *
     * @param uploadDirPath cesta k adresáři pro ukládání souborů (výchozí: {@code ./uploads})
     */
    public LocalFilesystemStorageService(
            @Value("${app.storage.upload-dir:./uploads}") String uploadDirPath) {
        this.uploadDir = Paths.get(uploadDirPath).toAbsolutePath().normalize();
        try {
            Files.createDirectories(this.uploadDir);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory: " + uploadDirPath, e);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String store(String directory, String filename, byte[] data, String contentType) {
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

    /**
     * {@inheritDoc}
     */
    @Override
    public void delete(String path) {
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

    /**
     * {@inheritDoc}
     */
    @Override
    public String getPublicUrl(String path) {
        return "/uploads/" + path;
    }
}
