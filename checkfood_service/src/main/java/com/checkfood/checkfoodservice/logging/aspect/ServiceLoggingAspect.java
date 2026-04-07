package com.checkfood.checkfoodservice.logging.aspect;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

/**
 * AOP aspekt pro jednotné logování vstupu, výstupu a doby trvání metod servisní vrstvy.
 * Neobsahuje business logiku ani rozhodování o chování aplikace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Aspect
@Component
public class ServiceLoggingAspect {

    // TODO: @Around pro application.service — log entry/exit, měření execution time
}
