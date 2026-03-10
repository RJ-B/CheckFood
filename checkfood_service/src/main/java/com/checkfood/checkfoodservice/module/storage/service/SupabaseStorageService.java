package com.checkfood.checkfoodservice.module.storage.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
@Profile("prod")
public class SupabaseStorageService implements StorageService {

    private final RestTemplate supabaseRestTemplate;
    private final String supabaseUrl;
    private final String bucket;

    public SupabaseStorageService(
            @Qualifier("supabaseRestTemplate") RestTemplate supabaseRestTemplate,
            @Value("${supabase.url}") String supabaseUrl,
            @Value("${supabase.storage.bucket}") String bucket) {
        this.supabaseRestTemplate = supabaseRestTemplate;
        this.supabaseUrl = supabaseUrl;
        this.bucket = bucket;
    }

    @Override
    public String store(String directory, String filename, byte[] data, String contentType) {
        String objectPath = directory + "/" + filename;
        String uploadUrl = supabaseUrl + "/storage/v1/object/" + bucket + "/" + objectPath;

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(
                contentType != null ? contentType : "application/octet-stream"));
        // Upsert = true -> prepisuje existujici soubor
        headers.set("x-upsert", "true");

        HttpEntity<byte[]> entity = new HttpEntity<>(data, headers);

        try {
            ResponseEntity<String> response = supabaseRestTemplate.exchange(
                    uploadUrl, HttpMethod.POST, entity, String.class);

            if (!response.getStatusCode().is2xxSuccessful()) {
                throw new RuntimeException("Supabase upload failed: " + response.getStatusCode()
                        + " - " + response.getBody());
            }

            log.info("[SupabaseStorage] Uploaded: {}", objectPath);
            return objectPath;
        } catch (Exception e) {
            log.error("[SupabaseStorage] Upload failed: {}", objectPath, e);
            throw new RuntimeException("Failed to upload to Supabase Storage: " + objectPath, e);
        }
    }

    @Override
    public void delete(String path) {
        String deleteUrl = supabaseUrl + "/storage/v1/object/" + bucket + "/" + path;

        try {
            supabaseRestTemplate.delete(deleteUrl);
            log.info("[SupabaseStorage] Deleted: {}", path);
        } catch (Exception e) {
            log.warn("[SupabaseStorage] Delete failed: {}", path, e);
        }
    }

    @Override
    public String getPublicUrl(String path) {
        return supabaseUrl + "/storage/v1/object/public/" + bucket + "/" + path;
    }
}
