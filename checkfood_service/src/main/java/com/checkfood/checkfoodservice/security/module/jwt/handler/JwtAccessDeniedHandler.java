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
 * Handler pro zpracování výjimek odepření přístupu (HTTP 403 Forbidden) na úrovni Spring Security filtrů.
 * Aktivuje se když je uživatel autentizován přes JWT, ale nemá dostatečná oprávnění pro přístup k zdroji.
 * Vrací JSON odpověď s detaily o zamítnutém požadavku.
 *
 * @see SecurityErrorResponseWriter
 * @see JwtLogger
 */
@Component
@RequiredArgsConstructor
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    private final SecurityErrorResponseWriter errorResponseWriter;
    private final JwtLogger jwtLogger;

    /**
     * Zpracuje situaci, kdy autentizovaný uživatel nemá dostatečná oprávnění.
     * Loguje pokus o neoprávněný přístup a vrací standardizovanou JSON odpověď s HTTP 403.
     *
     * @param request HTTP požadavek
     * @param response HTTP odpověď
     * @param accessDeniedException výjimka odepření přístupu
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