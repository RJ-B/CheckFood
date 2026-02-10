package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace OpenAPI / Swagger dokumentace.
 *
 * Slouží výhradně:
 * - pro dokumentaci REST API
 * - pro vývojáře a testování
 *
 * Nemá žádný vliv na běh business logiky.
 */

@Configuration
public class OpenApiConfig {

    // TODO:
    // - API metadata
    // - security schema (JWT)
    // - grouping endpointů
}
