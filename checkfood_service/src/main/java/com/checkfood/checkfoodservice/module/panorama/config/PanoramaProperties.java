package com.checkfood.checkfoodservice.module.panorama.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Data
@ConfigurationProperties(prefix = "panorama.stitcher")
public class PanoramaProperties {
    private String url = "http://localhost:8090";
    private String callbackUrl = "http://localhost:8081/api/v1/internal/panorama/callback";

    @Configuration
    @EnableConfigurationProperties(PanoramaProperties.class)
    public static class PanoramaConfig {
        @Bean
        public RestTemplate stitcherRestTemplate() {
            return new RestTemplate();
        }
    }
}
