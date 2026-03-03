package com.checkfood.checkfoodservice.security.module.jwt.handler;

import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * Handler pro zpracování chyb autentizace (HTTP 401 Unauthorized).
 * Využívá dedikovaný JwtLogger pro záznam incidentu.
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final SecurityErrorResponseWriter errorResponseWriter;
    private final JwtLogger jwtLogger;

    @Override
    public void commence(
            HttpServletRequest request,
            HttpServletResponse response,
            AuthenticationException authException
    ) throws IOException {

        jwtLogger.logUnauthorizedAccess(request.getRequestURI(), authException.getMessage());

        errorResponseWriter.writeErrorResponse(
                request,
                response,
                HttpServletResponse.SC_UNAUTHORIZED,
                "Unauthorized",
                "Pro přístup k tomuto zdroji je nutná platná autentizace."
        );
    }
}