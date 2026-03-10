package com.checkfood.checkfoodservice.module.storage.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.client.RestTemplate;

@Configuration
@Profile("prod")
public class SupabaseStorageConfig {

    @Value("${supabase.service-role-key}")
    private String serviceRoleKey;

    @Bean("supabaseRestTemplate")
    public RestTemplate supabaseRestTemplate() {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().set("Authorization", "Bearer " + serviceRoleKey);
            request.getHeaders().set("apikey", serviceRoleKey);
            return execution.execute(request, body);
        });
        return restTemplate;
    }
}
