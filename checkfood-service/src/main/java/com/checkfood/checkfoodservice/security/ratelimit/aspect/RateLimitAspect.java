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
 * AOP aspekt pro rate limiting.
 */
@Aspect
@Component
@RequiredArgsConstructor
public class RateLimitAspect {

    private final RateLimitService rateLimitService;


    @Around("@annotation(rateLimited)")
    public Object applyRateLimit(
            ProceedingJoinPoint joinPoint,
            RateLimited rateLimited
    ) throws Throwable {

        String key =
                buildKey(rateLimited);

        long windowMillis =
                TimeUnit.MILLISECONDS.convert(
                        rateLimited.duration(),
                        rateLimited.unit()
                );

        boolean allowed =
                rateLimitService.tryAcquire(
                        key,
                        rateLimited.limit(),
                        windowMillis
                );

        if (!allowed) {

            throw new RateLimitExceededException(
                    "Too many requests"
            );
        }

        return joinPoint.proceed();
    }


    // =====================================================
    // KEY BUILDING
    // =====================================================

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

            Authentication auth =
                    SecurityContextHolder
                            .getContext()
                            .getAuthentication();

            if (auth != null &&
                    auth.isAuthenticated() &&
                    auth.getPrincipal() != null) {

                sb.append(":user=")
                        .append(auth.getName());
            }
        }

        return sb.toString();
    }


    private String getClientIp() {

        ServletRequestAttributes attrs =
                (ServletRequestAttributes)
                        RequestContextHolder
                                .getRequestAttributes();

        if (attrs == null) {
            return null;
        }

        HttpServletRequest request =
                attrs.getRequest();

        String forwarded =
                request.getHeader("X-Forwarded-For");

        if (forwarded != null && !forwarded.isEmpty()) {

            return forwarded.split(",")[0].trim();
        }

        return request.getRemoteAddr();
    }

}
