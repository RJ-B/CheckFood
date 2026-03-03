package com.checkfood.checkfoodservice.security.module.jwt.filter;

import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * JWT autentizační filtr (JDK 21).
 * Validuje Bearer tokeny a nastavuje SecurityContext.
 * * Změny:
 * - Využití 'var'.
 * - Odstraněno explicitní logování chyb (v tichém catch bloku).
 * - Logování pouze úspěšné autentizace přes JwtLogger.
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserService userService;
    private final JwtLogger jwtLogger;

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

        var authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            var token = authHeader.substring(7);
            var userEmail = jwtService.extractEmail(token);

            if (userEmail != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                var user = userService.findWithRolesByEmail(userEmail);

                if (jwtService.isTokenValid(token, user)) {
                    var authToken = new UsernamePasswordAuthenticationToken(
                            user,
                            null,
                            user.getAuthorities()
                    );

                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authToken);

                    // Happy path logování
                    jwtLogger.logTokenValidated(userEmail);
                }
            }
        } catch (Exception e) {
            // Filter musí pokračovat i při chybě (permitAll endpointy).
            // Logujeme na WARN úrovni pro viditelnost bezpečnostních incidentů.
            jwtLogger.logTokenValidationFailed(request.getRequestURI(), e.getMessage());
        }

        filterChain.doFilter(request, response);
    }
}