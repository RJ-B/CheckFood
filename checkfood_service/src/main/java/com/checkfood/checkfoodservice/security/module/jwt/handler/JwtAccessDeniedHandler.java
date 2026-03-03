package com.checkfood.checkfoodservice.security.module.jwt.handler;

import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * Handler pro zpracování výjimek odepření přístupu (HTTP 403 Forbidden).
 * Vyvolá se, když je uživatel autentizován, ale postrádá potřebná oprávnění (Role/Authority).
 */
@Component
@RequiredArgsConstructor
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    private final SecurityErrorResponseWriter errorResponseWriter;
    private final JwtLogger jwtLogger;

    @Override
    public void handle(
            HttpServletRequest request,
            HttpServletResponse response,
            AccessDeniedException accessDeniedException
    ) throws IOException {

        // Logování incidentu do bezpečnostního auditu
        jwtLogger.logAccessDenied(request.getRequestURI(), accessDeniedException.getMessage());

        errorResponseWriter.writeErrorResponse(
                request,
                response,
                HttpServletResponse.SC_FORBIDDEN,
                "Forbidden",
                "Nemáte dostatečná oprávnění pro přístup k tomuto zdroji."
        );
    }
}