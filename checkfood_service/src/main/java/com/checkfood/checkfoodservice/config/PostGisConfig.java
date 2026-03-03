package com.checkfood.checkfoodservice.config;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.core.JdbcTemplate;

@Configuration
@RequiredArgsConstructor
@Profile("!test")
public class PostGisConfig {

    private final JdbcTemplate jdbcTemplate;

    @PostConstruct
    public void initPostGis() {
        // Tento příkaz se spustí hned po startu aplikace
        jdbcTemplate.execute("CREATE EXTENSION IF NOT EXISTS postgis");
    }
}