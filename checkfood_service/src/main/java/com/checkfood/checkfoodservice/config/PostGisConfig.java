package com.checkfood.checkfoodservice.config;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Inicializuje rozšíření PostGIS v databázi při startu aplikace.
 * Není aktivní v testovacím profilu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@RequiredArgsConstructor
@Profile("!test")
public class PostGisConfig {

    private final JdbcTemplate jdbcTemplate;

    /**
     * Zajistí existenci PostGIS rozšíření v databázi.
     */
    @PostConstruct
    public void initPostGis() {
        jdbcTemplate.execute("CREATE EXTENSION IF NOT EXISTS postgis");
    }
}