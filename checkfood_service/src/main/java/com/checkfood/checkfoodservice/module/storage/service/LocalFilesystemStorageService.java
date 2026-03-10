package com.checkfood.checkfoodservice.module.storage.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Slf4j
@Service
@Profile({"local", "test"})
public class LocalFilesystemStorageService implements StorageService {

    private final Path uploadDir;

    public LocalFilesystemStorageService(
            @Value("${app.storage.upload-dir:./uploads}") String uploadDirPath) {
        this.uploadDir = Paths.get(uploadDirPath).toAbsolutePath().normalize();
        try {
            Files.createDirectories(this.uploadDir);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory: " + uploadDirPath, e);
        }
    }

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

    @Override
    public String getPublicUrl(String path) {
        return "/uploads/" + path;
    }
}
