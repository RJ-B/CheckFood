package com.checkfood.checkfoodservice.security.ratelimit.aspect;

import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import com.checkfood.checkfoodservice.security.ratelimit.exception.RateLimitExceededException;
import com.checkfood.checkfoodservice.security.ratelimit.service.RateLimitService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.concurrent.TimeUnit;

/**
 * AOP aspekt implementující rate limiting funcionalitu pro @RateLimited annotované metody.
 *
 * Využívá Spring AOP pro transparentní interceptování method calls a aplikování
 * rate limit policies. Podporuje flexibilní key construction kombinující IP adresy,
 * user identity a logical keys pro různé rate limiting strategies.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see RateLimited
 * @see RateLimitService
 */
@Aspect
@Component
@RequiredArgsConstructor
public class RateLimitAspect {

    private final RateLimitService rateLimitService;

    /**
     * Around advice interceptující @RateLimited annotované metody.
     * Provádí rate limit check před method execution a throwuje exception při exceed.
     *
     * @param joinPoint method execution context s parameters a metadata
     * @param rateLimited annotation instance s rate limit configuration
     * @return method execution result pokud rate limit není exceeded
     * @throws Throwable původní method exceptions nebo RateLimitExceededException
     */
    @Around("@annotation(rateLimited)")
    public Object applyRateLimit(ProceedingJoinPoint joinPoint, RateLimited rateLimited) throws Throwable {

        String key = buildKey(rateLimited);
        long windowMillis = TimeUnit.MILLISECONDS.convert(rateLimited.duration(), rateLimited.unit());
        boolean allowed = rateLimitService.tryAcquire(key, rateLimited.limit(), windowMillis);

        if (!allowed) {
            throw new RateLimitExceededException("Too many requests");
        }

        return joinPoint.proceed();
    }

    /**
     * Sestavuje unique rate limit key kombinující logical key s optional IP/user identifiers.
     * Dynamic construction umožňuje granular rate limiting strategies.
     *
     * @param config RateLimited annotation configuration
     * @return composed rate limit key pro service lookup
     */
    private String buildKey(RateLimited config) {
        StringBuilder sb = new StringBuilder();
        sb.append(config.key());

        if (config.perIp()) {
            String ip = getClientIp();
            if (ip != null) {
                sb.append(":ip=").append(ip);
            }
        }

        if (config.perUser()) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.isAuthenticated() && auth.getPrincipal() != null) {
                sb.append(":user=").append(auth.getName());
            }
        }

        return sb.toString();
    }

    /**
     * Extrahuje client IP adresu.
     * X-Forwarded-For se NEPOUŽÍVÁ (snadno spoofovatelný bez trusted reverse proxy).
     * Používá se výhradně remoteAddr, což je IP skutečného TCP spojení.
     *
     * @return client IP address nebo null pokud není dostupná
     */
    private String getClientIp() {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        if (attrs == null) {
            return null;
        }

        HttpServletRequest request = attrs.getRequest();
        return request.getRemoteAddr();
    }
}