package com.checkfood.checkfoodservice.infrastructure.storage.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Konfigurace statického servírování nahraných souborů pro lokální profil.
 * Mapuje URL prefix {@code /uploads/**} na lokální adresář s nahranými soubory.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@Profile("local")
public class StorageConfig implements WebMvcConfigurer {

    @Value("${app.storage.upload-dir:./uploads}")
    private String uploadDir;

    /**
     * Registruje handler pro statické soubory z adresáře nahrávání dostupný přes {@code /uploads/**}.
     *
     * @param registry registr resource handlerů Spring MVC
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + uploadDir + "/");
    }
}
