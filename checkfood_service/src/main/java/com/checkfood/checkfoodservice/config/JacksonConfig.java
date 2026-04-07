package com.checkfood.checkfoodservice.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

/**
 * Globální konfigurace JSON serializace a deserializace.
 * Sjednocuje formátování datových typů napříč celým API.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class JacksonConfig {

    /**
     * Vytvoří primární ObjectMapper s podporou Java 8 Date/Time API a ISO-8601 formátováním dat.
     *
     * @param builder builder pro konfiguraci ObjectMapper
     * @return nakonfigurovaný ObjectMapper
     */
    @Bean
    @Primary
    public ObjectMapper objectMapper(Jackson2ObjectMapperBuilder builder) {
        ObjectMapper objectMapper = builder.createXmlMapper(false).build();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        return objectMapper;
    }
}