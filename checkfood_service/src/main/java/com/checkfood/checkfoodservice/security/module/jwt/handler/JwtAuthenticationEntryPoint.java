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
 * Handler pro zpracování chyb autentizace (HTTP 401 Unauthorized) na úrovni Spring Security filtrů.
 * Aktivuje se když uživatel není autentizován nebo má neplatný/expirovaný JWT token.
 * Vrací JSON odpověď s výzvou k přihlášení.
 *
 * @see SecurityErrorResponseWriter
 * @see JwtLogger
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final SecurityErrorResponseWriter errorResponseWriter;
    private final JwtLogger jwtLogger;

    /**
     * Zpracuje situaci, kdy požadavek nemá platnou JWT autentizaci.
     * Loguje pokus o neautorizovaný přístup a vrací standardizovanou JSON odpověď s HTTP 401.
     *
     * @param request HTTP požadavek
     * @param response HTTP odpověď
     * @param authException výjimka autentizace
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