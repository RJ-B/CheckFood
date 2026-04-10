package com.checkfood.checkfoodservice.infrastructure.storage.service;

import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.HttpMethod;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import lombok.extern.slf4j.Slf4j;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

/**
 * Implementace souborového úložiště využívající Google Cloud Storage.
 *
 * <p>Instanciuje se přes {@link com.checkfood.checkfoodservice.infrastructure.storage.config.StorageConfig}
 * — nikoliv přes komponentní sken — protože jednu třídu používáme dvakrát
 * (jednou pro veřejný bucket, jednou pro privátní s podporou signed URL).
 *
 * @author Rostislav Jirák
 * @version 2.0.0
 */
@Slf4j
public class GcsStorageService implements StorageService {

    private final Storage storage;
    private final String bucketName;
    private final boolean useSignedUrls;

    /**
     * @param bucketName    název GCS bucketu
     * @param useSignedUrls pokud {@code true}, {@link #getDownloadUrl(String)} vrací V4 signed URL;
     *                      pokud {@code false}, vrací přímou veřejnou URL.
     */
    public GcsStorageService(String bucketName, boolean useSignedUrls) {
        this.storage = StorageOptions.getDefaultInstance().getService();
        this.bucketName = bucketName;
        this.useSignedUrls = useSignedUrls;
        log.info("[GcsStorage] Initialized bucket={} signedUrls={}", bucketName, useSignedUrls);
    }

    @Override
    public String store(String directory, String filename, byte[] data, String contentType) {
        if (directory == null || directory.contains("..") || directory.startsWith("/")) {
            throw new IllegalArgumentException("Neplatný adresář úložiště: " + directory);
        }
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
        if (path == null || path.isBlank()) {
            return;
        }
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
    public String getDownloadUrl(String path) {
        return getDownloadUrl(path, DEFAULT_SIGNED_URL_TTL);
    }

    @Override
    public String getDownloadUrl(String path, Duration ttl) {
        if (path == null || path.isBlank()) {
            return null;
        }
        if (!useSignedUrls) {
            return String.format("https://storage.googleapis.com/%s/%s", bucketName, path);
        }
        try {
            BlobInfo blobInfo = BlobInfo.newBuilder(BlobId.of(bucketName, path)).build();
            return storage.signUrl(
                    blobInfo,
                    ttl.toMinutes(),
                    TimeUnit.MINUTES,
                    Storage.SignUrlOption.withV4Signature(),
                    Storage.SignUrlOption.httpMethod(HttpMethod.GET)
            ).toString();
        } catch (Exception e) {
            log.error("[GcsStorage] Failed to sign URL for {}: {}", path, e.getMessage());
            return null;
        }
    }
}
