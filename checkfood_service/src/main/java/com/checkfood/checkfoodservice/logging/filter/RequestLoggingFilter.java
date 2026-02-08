package com.checkfood.checkfoodservice.logging.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

import java.io.IOException;

/**
 * Servlet filter pro logování HTTP requestů.
 *
 * - inicializuje MDC kontext
 * - loguje základní metadata requestu
 *
 *   Neobsahuje business logiku
 */
public class RequestLoggingFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException {

        try {
            // TODO:
            // - inicializace MDC (traceId, requestId)
            // - log vstupu requestu

            chain.doFilter(request, response);

        } finally {
            // TODO:
            // - vyčištění MDC
        }
    }
}
