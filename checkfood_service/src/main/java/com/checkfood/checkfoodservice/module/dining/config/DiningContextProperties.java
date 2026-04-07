package com.checkfood.checkfoodservice.module.dining.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * Konfigurační properties pro dining context — definuje časová okna grace periody před a po rezervaci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "dining.context")
public class DiningContextProperties {

    private int graceBeforeMinutes = 30;
    private int graceAfterMinutes = 30;
}
