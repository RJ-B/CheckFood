package com.checkfood.checkfoodservice.monitoring.tracing;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

import java.io.IOException;

/**
 * Servlet filter, který:
 * - generuje / propaguje traceId
 * - ukládá ho do MDC
 */
public class TraceIdFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain
    ) throws IOException, ServletException {

        try {
            // TODO:
            // - generace nebo čtení traceId
            chain.doFilter(request, response);
        } finally {
            // TODO:
            // - cleanup MDC
        }
    }
}
