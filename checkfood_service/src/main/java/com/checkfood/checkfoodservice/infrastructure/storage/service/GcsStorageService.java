package com.checkfood.checkfoodservice.infrastructure.storage.service;

import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

/**
 * Implementace souborového úložiště využívající Google Cloud Storage.
 * Aktivní pouze pro profil {@code prod}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Primary
@Service
@Profile("prod")
public class GcsStorageService implements StorageService {

    private final Storage storage;
    private final String bucketName;

    public GcsStorageService(
            @Value("${gcs.bucket-name}") String bucketName) {
        this.storage = StorageOptions.getDefaultInstance().getService();
        this.bucketName = bucketName;
    }

    @Override
    public String store(String directory, String filename, byte[] data, String contentType) {
        String objectPath = directory + "/" + filename;

        BlobId blobId = BlobId.of(bucketName, objectPath);
        BlobInfo blobInfo = BlobInfo.newBuilder(blobId)
                .setContentType(contentType != null ? contentType : "application/octet-stream")
                .build();

        try {
            storage.create(blobInfo, data);
            log.info("[GcsStorage] Uploaded: {}/{}", bucketName, objectPath);
            return objectPath;
        } catch (Exception e) {
            log.error("[GcsStorage] Upload failed: {}", objectPath, e);
            throw new RuntimeException("Failed to upload to GCS: " + objectPath, e);
        }
    }

    @Override
    public void delete(String path) {
        try {
            BlobId blobId = BlobId.of(bucketName, path);
            boolean deleted = storage.delete(blobId);
            if (deleted) {
                log.info("[GcsStorage] Deleted: {}/{}", bucketName, path);
            } else {
                log.warn("[GcsStorage] Object not found for deletion: {}/{}", bucketName, path);
            }
        } catch (Exception e) {
            log.warn("[GcsStorage] Delete failed: {}", path, e);
        }
    }

    @Override
    public String getPublicUrl(String path) {
        return String.format("https://storage.googleapis.com/%s/%s", bucketName, path);
    }
}
