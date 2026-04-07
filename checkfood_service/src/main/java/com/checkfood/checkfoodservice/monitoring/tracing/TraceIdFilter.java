package com.checkfood.checkfoodservice.monitoring.tracing;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

import java.io.IOException;

/**
 * Servlet filter, který generuje nebo propaguje traceId a ukládá ho do MDC.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class TraceIdFilter implements Filter {

    /**
     * Generuje nebo přečte traceId, uloží ho do MDC a předá zpracování dál.
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
            // TODO: generace nebo čtení traceId
            chain.doFilter(request, response);
        } finally {
            // TODO: cleanup MDC
        }
    }
}
