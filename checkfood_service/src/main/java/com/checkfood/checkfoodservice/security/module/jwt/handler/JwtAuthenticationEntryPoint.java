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
 * Vyvolá se, když požadavek přistupuje k chráněnému zdroji bez platné autentizace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final SecurityErrorResponseWriter errorResponseWriter;
    private final JwtLogger jwtLogger;

    /**
     * Zapíše HTTP 401 odpověď při pokusu o přístup bez autentizace.
     *
     * @param request       HTTP požadavek
     * @param response      HTTP odpověď pro zápis chybové odpovědi
     * @param authException výjimka popisující důvod selhání autentizace
     * @throws IOException při chybě zápisu odpovědi
     */
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