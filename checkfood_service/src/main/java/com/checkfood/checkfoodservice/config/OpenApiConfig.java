package com.checkfood.checkfoodservice.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace OpenAPI (Swagger) dokumentace.
 * Definuje základní metadata o API dostupné pro frontend a testování.
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI checkFoodOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("CheckFood API")
                        .description("Backend služba pro aplikaci CheckFood")
                        .version("v1.0.0"));
    }
}