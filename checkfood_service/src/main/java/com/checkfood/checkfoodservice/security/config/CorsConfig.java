package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

/**
 * Centralizovaná konfigurace Cross-Origin Resource Sharing (CORS) pravidel pro zabezpečení
 * komunikace mezi frontend aplikacemi a REST API backend službami.
 *
 * CORS je bezpečnostní mechanismus implementovaný webovými prohlížeči, který kontroluje
 * cross-origin HTTP požadavky. Bez správné CORS konfigurace by moderní SPA aplikace
 * nemohly komunikovat s API servery běžícími na jiných doménách/portech.
 *
 * Bezpečnostní aspekty:
 * - Origin whitelisting místo "*" wildcard pro eliminaci CORS bypass útoků
 * - Explicitní seznam povolených HTTP metod a headers
 * - Credentials handling s allowCredentials=true pro JWT authentication
 * - Performance optimalizace přes MaxAge caching
 *
 * Development vs Production:
 * Tato konfigurace obsahuje localhost origins pro development. V production prostředí
 * musí být nahrazeny skutečnými production doménami s HTTPS protokolem.
 *
 * @author Senior Security Team
 * @version 1.0
 * @see CorsConfiguration
 * @see CorsConfigurationSource
 */
@Configuration
public class CorsConfig {

    /**
     * Povolené CORS origins konfigurované z application.properties.
     * Výchozí hodnoty pro development, v produkci MUSÍ být přepsány HTTPS doménami.
     */
    @org.springframework.beans.factory.annotation.Value("${cors.allowed-origins:http://localhost:3000,http://127.0.0.1:3000,http://192.168.1.199:8081,http://192.168.1.199}")
    private String allowedOrigins;

    /**
     * Definuje primární CORS konfigurační bean pro celou aplikaci.
     * Bean je automaticky integrován do Spring Security filter chain a aplikován
     * před ostatními security filtery. Používá URL-based mapping approach pro
     * flexibilní konfiguraci různých endpointů.
     * Konfigurace implementuje "least privilege principle" - pouze explicitně
     * povolené origins, metody a headers jsou akceptovány.
     *
     * @return plně nakonfigurovaný CorsConfigurationSource bean
     */
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        /*
         * Origins načtené z konfigurace (application.properties / env proměnné).
         * Bezpečnostní přístup - žádný wildcard "*" pro eliminaci CORS bypass útoků.
         * PRODUCTION: Nastavte cors.allowed-origins na skutečné HTTPS domény!
         */
        config.setAllowedOrigins(List.of(allowedOrigins.split(",")));

        /*
         * Povolené HTTP metody pro RESTful API design.
         * OPTIONS je mandatory pro browser preflight requests.
         * Žádné TRACE nebo CONNECT metody pro redukci attack surface.
         */
        config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"));

        /*
         * Whitelist approach pro request headers místo wildcard "*".
         * Authorization - JWT tokens, Bearer auth pro authentication
         * Content-Type - MIME type specification (application/json, multipart/form-data)
         * X-Requested-With - Ajax/XHR identification header
         * Accept - Client preferred response content types
         * Origin - Browser-set header (automatic)
         */
        config.setAllowedHeaders(Arrays.asList(
                "Authorization",
                "Content-Type",
                "X-Requested-With",
                "Accept",
                "Origin"
        ));

        /**
         * Headers expozované client-side JavaScriptu v response.
         * Authorization header exposure umožňuje token refresh workflows
         * kde server vrací nový token v response header.
         */
        config.setExposedHeaders(List.of("Authorization"));

        /*
         * Povoluje cookies a authentication credentials v cross-origin požadavcích.
         * KRITICKÉ: allowCredentials=true vyžaduje:
         * - Explicitní origin whitelist (ne "*")
         * - Explicitní header whitelist (ne "*")
         * - Dodatečnou CSRF protection
         * Umožňuje JWT authentication přes Authorization header a session cookies.
         */
        config.setAllowCredentials(true);

        /*
         * Cache time pro CORS preflight responses (1 hodina).
         * Balance mezi performance a flexibility při deployment změn.
         * Browser může cachovat OPTIONS responses aby redukoval network calls.
         */
        config.setMaxAge(3600L);

        /*
          URL-based configuration source pro pattern-specific CORS rules.
          "/**" aplikuje tuto konfiguraci na všechny application endpointy.
          Můžeme přidat specifické rules pro různé API paths podle potřeby.
         */
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);

        return source;
    }
}