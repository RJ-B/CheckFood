package com.checkfood.checkfoodservice.client.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace REST klientů používaných pro komunikaci
 * s externími systémy (např. platební brány, e-mailové služby).
 *
 * Tato konfigurace:
 * - definuje společné technické nastavení REST komunikace
 * - NEOBSAHUJE žádnou aplikační ani business logiku
 *
 * Používá se výhradně v client vrstvě.
 */
@Configuration
public class RestClientConfig {

    // TODO:
    // - konfigurace RestTemplate nebo HttpClient
    // - timeouty
    // - connection pooling
}
