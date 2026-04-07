package com.checkfood.checkfoodservice.client.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace reaktivního WebClienta pro externí volání s vyšší latencí nebo non-blocking komunikací.
 * Business logika sem nikdy nepatří.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class WebClientConfig {

    // TODO: WebClient.Builder — default headers, base URL z properties
}
