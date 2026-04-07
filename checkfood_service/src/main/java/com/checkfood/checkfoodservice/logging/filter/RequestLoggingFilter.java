package com.checkfood.checkfoodservice.logging.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

import java.io.IOException;

/**
 * Servlet filter pro logování HTTP requestů.
 * Inicializuje MDC kontext a loguje základní metadata příchozího požadavku.
 * Neobsahuje business logiku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class RequestLoggingFilter implements Filter {

    /**
     * Inicializuje MDC kontext, zaloguje request a předá zpracování dál v řetězci filtrů.
     *
     * @param request  příchozí HTTP požadavek
     * @param response HTTP odpověď
     * @param chain    řetězec filtrů
     * @throws IOException      při I/O chybě
     * @throws ServletException při chybě servlet kontejneru
     */
    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException {

        try {
            // TODO: inicializace MDC (traceId, requestId), log vstupu requestu
            chain.doFilter(request, response);
        } finally {
            // TODO: vyčištění MDC
        }
    }
}
