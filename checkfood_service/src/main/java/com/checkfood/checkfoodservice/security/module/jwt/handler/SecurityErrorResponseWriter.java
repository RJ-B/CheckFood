package com.checkfood.checkfoodservice.security.module.jwt.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Utility třída pro generování standardizovaných JSON chybových odpovědí na úrovni Spring Security filtrů.
 * Centralizuje logiku tvorby HTTP error response pro JWT handlery.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class SecurityErrorResponseWriter {

    private final ObjectMapper objectMapper;

    /**
     * Zapíše standardizovanou chybovou odpověď do HTTP response.
     *
     * @param request HTTP požadavek
     * @param response HTTP odpověď
     * @param status HTTP status kód
     * @param error název chyby (např. "Unauthorized", "Forbidden")
     * @param message lidsky čitelná chybová zpráva
     * @throws IOException při chybě zápisu odpovědi
     */
    public void writeErrorResponse(
            HttpServletRequest request,
            HttpServletResponse response,
            int status,
            String error,
            String message
    ) throws IOException {

        response.setStatus(status);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");

        final Map<String, Object> body = new LinkedHashMap<>();
        body.put("timestamp", Instant.now().toString());
        body.put("status", status);
        body.put("error", error);
        body.put("message", message);
        body.put("path", request.getRequestURI());

        objectMapper.writeValue(response.getWriter(), body);
    }
}