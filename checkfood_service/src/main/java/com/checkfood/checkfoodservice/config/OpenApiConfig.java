package com.checkfood.checkfoodservice.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace OpenAPI (Swagger) dokumentace.
 * Definuje základní metadata o API dostupné pro frontend a testování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class OpenApiConfig {

    /**
     * Vytvoří OpenAPI bean s metadaty aplikace CheckFood.
     *
     * @return nakonfigurovaný OpenAPI objekt
     */
    @Bean
    public OpenAPI checkFoodOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("CheckFood API")
                        .description("Backend služba pro aplikaci CheckFood")
                        .version("v1.0.0"));
    }
}