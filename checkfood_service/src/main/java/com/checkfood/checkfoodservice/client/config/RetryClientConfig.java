package com.checkfood.checkfoodservice.client.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace retry mechanizmů pro externí systémy.
 * Service vrstva nikdy neřeší retry přímo — veškerá logika opakování volání patří sem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class RetryClientConfig {

    // TODO: Spring Retry / Resilience4j — retry policy podle typu klienta
}
