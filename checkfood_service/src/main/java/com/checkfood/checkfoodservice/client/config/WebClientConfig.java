package com.checkfood.checkfoodservice.client.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace reaktivního WebClienta pro externí volání.
 *
 * Používá se tam, kde:
 * - je potřeba non-blocking komunikace
 * - očekává se vyšší latence externí služby
 *
 * Business logika sem nikdy nepatří.
 */
@Configuration
public class WebClientConfig {

    // TODO:
    // - WebClient.Builder
    // - default headers
    // - base URL z properties
}
