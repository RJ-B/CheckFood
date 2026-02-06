package com.checkfood.checkfoodservice.security.jwt.filter;

import com.checkfood.checkfoodservice.security.jwt.JwtService;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * JWT autentizační filtr zachytávající každý příchozí požadavek.
 * Provádí extrakci a validaci Bearer tokenu a následnou autorizaci v SecurityContextu.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserService userService;

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");

        // 1. Rychlá kontrola přítomnosti Bearer tokenu
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            final String token = authHeader.substring(7);

            // 2. Extrakce emailu (username) s využitím sjednoceného názvosloví
            final String userEmail = jwtService.extractEmail(token);

            // 3. Proces autentizace (pouze pokud uživatel ještě není v kontextu)
            if (userEmail != null && SecurityContextHolder.getContext().getAuthentication() == null) {

                // Zde používáme optimalizované načtení i s rolemi (EntityGraph)
                UserEntity user = userService.findWithRolesByEmail(userEmail);

                // 4. Komplexní validace tokenu vůči načtenému uživateli
                if (jwtService.isTokenValid(token, user)) {
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            user,
                            null,
                            user.getAuthorities()
                    );

                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                    // Nastavení identity do Security kontextu
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                    log.debug("Uživatel {} úspěšně autentizován přes JWT.", userEmail);
                }
            }
        } catch (Exception e) {
            log.error("Chyba při zpracování JWT autentizace: {}", e.getMessage());
            // V případě chyby kontext nenastavujeme, Spring Security request následně zamítne (401/403)
        }

        filterChain.doFilter(request, response);
    }
}