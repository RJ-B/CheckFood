package com.checkfood.checkfoodservice.logging.aspect;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/**
 * AOP aspekt pro logování servisní vrstvy.
 *
 * Slouží k:
 * - jednotnému logování vstupu / výstupu service metod
 * - měření doby trvání
 * - zachycení výjimek
 *
 *   Neobsahuje business logiku
 *   Nerozhoduje o chování aplikace
 */
@Aspect
@Component
public class ServiceLoggingAspect {

    // TODO:
    // - @Around pro application.service
    // - log entry/exit
    // - měření execution time
}
