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
 * JWT autentizační filtr zpracovávající Bearer tokeny z Authorization headeru.
 * Při úspěšné validaci nastaví autentizaci do {@code SecurityContextHolder}.
 * Kontroluje také aktivitu zařízení přes {@code DeviceRepository}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see JwtService
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserService userService;
    private final JwtLogger jwtLogger;
    private final com.checkfood.checkfoodservice.security.module.user.repository.DeviceRepository deviceRepository;

    /**
     * Zpracuje HTTP požadavek, validuje Bearer token a nastaví SecurityContext.
     *
     * @param request     příchozí HTTP požadavek
     * @param response    HTTP odpověď
     * @param filterChain zbývající filtrový řetězec
     * @throws ServletException při chybě filtru
     * @throws IOException      při chybě I/O
     */
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
                    var deviceId = jwtService.extractDeviceIdentifier("Bearer " + token);
                    if (deviceId != null) {
                        var device = deviceRepository.findByDeviceIdentifierAndUser(deviceId, user);
                        if (device.isEmpty() || !device.get().isActive()) {
                            jwtLogger.logTokenValidationFailed(request.getRequestURI(),
                                    "Device " + deviceId + " not found or inactive");
                            filterChain.doFilter(request, response);
                            return;
                        }
                    }

                    var authToken = new UsernamePasswordAuthenticationToken(
                            user,
                            null,
                            user.getAuthorities()
                    );

                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authToken);

                    jwtLogger.logTokenValidated(userEmail);
                }
            }
        } catch (Exception e) {
            jwtLogger.logTokenValidationFailed(request.getRequestURI(), e.getMessage());
        }

        filterChain.doFilter(request, response);
    }
}