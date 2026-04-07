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
 * Vyvolá se, když je uživatel autentizován, ale postrádá potřebná oprávnění.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    private final SecurityErrorResponseWriter errorResponseWriter;
    private final JwtLogger jwtLogger;

    /**
     * Zapíše HTTP 403 odpověď při pokusu o přístup k nepovoleném zdroji.
     *
     * @param request              HTTP požadavek
     * @param response             HTTP odpověď pro zápis chybové odpovědi
     * @param accessDeniedException výjimka popisující důvod odepření přístupu
     * @throws IOException při chybě zápisu odpovědi
     */
    @Override
    public void handle(
            HttpServletRequest request,
            HttpServletResponse response,
            AccessDeniedException accessDeniedException
    ) throws IOException {

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