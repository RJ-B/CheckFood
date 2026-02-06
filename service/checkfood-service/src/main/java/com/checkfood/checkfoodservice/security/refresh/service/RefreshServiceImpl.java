package com.checkfood.checkfoodservice.security.refresh.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.UserResponse;

import com.checkfood.checkfoodservice.security.auth.mapper.AuthMapper;
import com.checkfood.checkfoodservice.security.jwt.JwtService;

import com.checkfood.checkfoodservice.security.refresh.exception.InvalidRefreshTokenException;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.user.service.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.context.ApplicationEventPublisher;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.security.oauth2.jwt.*;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Implementace obnovy JWT tokenů.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class RefreshServiceImpl implements RefreshService {

    private static final String CLAIM_TYPE = "type";
    private static final String TYPE_REFRESH = "REFRESH";


    private final JwtService jwtService;
    private final JwtDecoder jwtDecoder;

    private final UserService userService;
    private final UserMapper userMapper;

    private final AuthMapper authMapper;

    // Audit
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;


    // =====================================================
    // REFRESH
    // =====================================================

    @Override
    public AuthResponse refresh(String refreshToken) {

        Jwt jwt;

        try {

            jwt = decodeRefreshToken(refreshToken);

        } catch (InvalidRefreshTokenException ex) {

            publishAudit(null, AuditStatus.FAILED);

            throw ex;
        }

        validateRefreshToken(jwt);

        String email =
                jwt.getSubject();

        UserEntity user =
                userService.findByEmail(email);

        if (user == null || !user.isEnabled()) {

            publishAudit(null, AuditStatus.BLOCKED);

            throw new InvalidRefreshTokenException(
                    "User not found or disabled"
            );
        }

        publishAudit(user.getId(), AuditStatus.SUCCESS);

        return buildAuthResponse(user);
    }


    // =====================================================
    // HELPERS
    // =====================================================

    private Jwt decodeRefreshToken(String token) {

        try {
            return jwtDecoder.decode(token);

        } catch (JwtException ex) {

            throw new InvalidRefreshTokenException(
                    "Invalid refresh token"
            );
        }
    }


    private void validateRefreshToken(Jwt jwt) {

        String type =
                jwt.getClaimAsString(CLAIM_TYPE);

        if (!TYPE_REFRESH.equals(type)) {

            throw new InvalidRefreshTokenException(
                    "Token is not a refresh token"
            );
        }
    }

    private AuthResponse buildAuthResponse(UserEntity user) {
        String newAccessToken = jwtService.generateAccessToken(user);
        String newRefreshToken = jwtService.generateRefreshToken(user);
        Long expiresIn = jwtService.getAccessTokenExpirationSeconds();

        // Použijeme mapper, který se postará o správné sestavení DTO včetně jmen a rolí
        return authMapper.toAuthResponse(
                user,
                newAccessToken,
                newRefreshToken,
                expiresIn
        );
    }


    // =====================================================
    // AUDIT
    // =====================================================

    private void publishAudit(
            Long userId,
            AuditStatus status
    ) {

        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        userId,
                        AuditAction.REFRESH_TOKEN,
                        status,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }

}
