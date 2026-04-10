package com.checkfood.checkfoodservice.infrastructure.storage.config;

import com.checkfood.checkfoodservice.infrastructure.storage.service.GcsStorageService;
import com.checkfood.checkfoodservice.infrastructure.storage.service.LocalFilesystemStorageService;
import com.checkfood.checkfoodservice.infrastructure.storage.service.PrivateStorage;
import com.checkfood.checkfoodservice.infrastructure.storage.service.PublicStorage;
import com.checkfood.checkfoodservice.infrastructure.storage.service.StorageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Spring konfigurace registrující dva {@link StorageService} beany:
 * {@link PublicStorage} pro veřejný content a {@link PrivateStorage} pro privátní content
 * (avatary, KYC). Implementace se přepíná podle aktivního profilu — v {@code prod}
 * se používá {@link GcsStorageService} (Google Cloud Storage), v {@code local}/{@code test}
 * {@link LocalFilesystemStorageService} se subadresáři {@code uploads/public} a {@code uploads/private}.
 *
 * <p>V lokálním profilu navíc registruje resource handler pro statické servírování
 * uploadovaných souborů pod {@code /uploads/**}.
 *
 * @author Rostislav Jirák
 * @version 2.0.0
 */
@Configuration
public class StorageConfig {

    // ---------- PROD: GCS ----------

    @Bean
    @PublicStorage
    @Profile("prod")
    public StorageService publicGcsStorage(
            @Value("${gcs.public-bucket-name}") String bucketName) {
        return new GcsStorageService(bucketName, false);
    }

    @Bean
    @PrivateStorage
    @Profile("prod")
    public StorageService privateGcsStorage(
            @Value("${gcs.private-bucket-name}") String bucketName) {
        return new GcsStorageService(bucketName, true);
    }

    // ---------- LOCAL/TEST: filesystem ----------

    @Bean
    @PublicStorage
    @Profile({"local", "test"})
    public StorageService publicLocalStorage(
            @Value("${app.storage.public-dir:./uploads/public}") String dir) {
        return new LocalFilesystemStorageService(dir, "/uploads/public");
    }

    @Bean
    @PrivateStorage
    @Profile({"local", "test"})
    public StorageService privateLocalStorage(
            @Value("${app.storage.private-dir:./uploads/private}") String dir) {
        return new LocalFilesystemStorageService(dir, "/uploads/private");
    }

    /**
     * Resource handler pro lokální vývoj — servíruje uploadovaný obsah pod {@code /uploads/**}.
     * V produkci se obsah servíruje přímo z GCS / signed URL.
     */
    @Configuration
    @Profile({"local", "test"})
    public static class LocalUploadResourceConfig implements WebMvcConfigurer {

        @Value("${app.storage.public-dir:./uploads/public}")
        private String publicDir;

        @Value("${app.storage.private-dir:./uploads/private}")
        private String privateDir;

        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {
            registry.addResourceHandler("/uploads/public/**")
                    .addResourceLocations("file:" + publicDir + "/");
            registry.addResourceHandler("/uploads/private/**")
                    .addResourceLocations("file:" + privateDir + "/");
        }
    }
}
