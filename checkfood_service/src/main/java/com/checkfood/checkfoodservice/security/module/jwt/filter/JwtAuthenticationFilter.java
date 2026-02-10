package com.checkfood.checkfoodservice.security.module.jwt.filter;

import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
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
 * JWT autentizační filtr pro validaci Bearer tokenů v každém HTTP požadavku.
 * Extrahuje JWT token z Authorization hlavičky, validuje ho a v případě úspěchu
 * nastaví autentizaci do Security kontextu. Filtr se vykonává právě jednou pro každý request.
 *
 * @see JwtService
 * @see UserService
 * @see JwtLogger
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserService userService;
    private final JwtLogger jwtLogger;

    /**
     * Zpracuje každý HTTP požadavek a provede JWT autentizaci pokud je přítomen Bearer token.
     * Kroky zpracování:
     * 1. Kontrola přítomnosti Authorization hlavičky s Bearer tokenem
     * 2. Extrakce emailu z tokenu
     * 3. Načtení uživatele včetně rolí z databáze
     * 4. Validace tokenu vůči uživateli
     * 5. Nastavení autentizace do Security kontextu
     *
     * @param request HTTP požadavek
     * @param response HTTP odpověď
     * @param filterChain řetěz filtrů
     * @throws ServletException při chybě zpracování servletu
     * @throws IOException při chybě I/O operace
     */
    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            final String token = authHeader.substring(7);
            final String userEmail = jwtService.extractEmail(token);

            if (userEmail != null && SecurityContextHolder.getContext().getAuthentication() == null) {

                UserEntity user = userService.findWithRolesByEmail(userEmail);

                if (jwtService.isTokenValid(token, user)) {
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            user,
                            null,
                            user.getAuthorities()
                    );

                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authToken);

                    jwtLogger.logSuccessfulAuthentication(userEmail);
                }
            }
        } catch (Exception e) {
            jwtLogger.logAuthenticationError(e.getMessage());
        }

        filterChain.doFilter(request, response);
    }
}