package com.checkfood.checkfoodservice.security.oauth.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.UserResponse;

import com.checkfood.checkfoodservice.security.jwt.JwtService;

import com.checkfood.checkfoodservice.security.oauth.dto.request.OAuthLoginRequest;
import com.checkfood.checkfoodservice.security.oauth.exception.OAuthEmailMissingException;

import com.checkfood.checkfoodservice.security.oauth.mapper.OAuthUserMapper;

import com.checkfood.checkfoodservice.security.oauth.provider.*;

import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;

import com.checkfood.checkfoodservice.security.user.mapper.UserMapper;
import com.checkfood.checkfoodservice.security.user.service.RoleService;
import com.checkfood.checkfoodservice.security.user.service.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.context.ApplicationEventPublisher;

import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletRequest;

import java.util.UUID;

/**
 * Implementace OAuth autentizace (Google / Apple).
 */
@Service
@RequiredArgsConstructor
@Transactional
public class OAuthServiceImpl implements OAuthService {

    private final OAuthClientFactory clientFactory;

    private final UserService userService;
    private final RoleService roleService;

    private final JwtService jwtService;

    private final PasswordEncoder passwordEncoder;

    private final OAuthUserMapper userMapper;
    private final UserMapper userMapperInternal;

    // Audit
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;


    // =====================================================
    // LOGIN
    // =====================================================

    @Override
    public AuthResponse login(OAuthLoginRequest requestDto) {

        OAuthClient client =
                clientFactory.getClient(
                        requestDto.getProviderType()
                );

        OAuthUserInfo userInfo;

        try {

            userInfo =
                    client.verifyAndExtractUserInfo(
                            requestDto.getIdToken()
                    );

        } catch (Exception ex) {

            publishAudit(
                    null,
                    AuditStatus.FAILED
            );

            throw ex;
        }

        if (userInfo.getEmail() == null ||
                userInfo.getEmail().isBlank()) {

            publishAudit(
                    null,
                    AuditStatus.FAILED
            );

            throw new OAuthEmailMissingException(
                    "OAuth provider did not return email"
            );
        }

        boolean isNewUser = false;

        UserEntity user;

        if (userService.existsByEmail(userInfo.getEmail())) {

            user =
                    userService.findByEmail(
                            userInfo.getEmail()
                    );

        } else {

            user =
                    createNewUser(userInfo);

            isNewUser = true;
        }

        publishAudit(
                user.getId(),
                AuditStatus.SUCCESS
        );

        if (isNewUser) {

            publishAuditRegister(user);
        }

        return buildAuthResponse(user);
    }


    // =====================================================
    // HELPERS
    // =====================================================

    private UserEntity createNewUser(OAuthUserInfo userInfo) {

        UserEntity user =
                userMapper.toNewUser(userInfo);

        String randomPassword =
                UUID.randomUUID().toString().replace("-", "") +
                        UUID.randomUUID().toString().replace("-", "");

        user.setPassword(
                passwordEncoder.encode(randomPassword)
        );

        RoleEntity userRole =
                roleService.findByName("USER");

        user.getRoles().add(userRole);

        return userService.save(user);
    }


    private AuthResponse buildAuthResponse(UserEntity user) {
        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = jwtService.generateRefreshToken(user);
        Long expiresIn = jwtService.getAccessTokenExpirationSeconds();

        UserResponse userResponse = userMapperInternal.toAuth(user);

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .expiresIn(expiresIn)
                .user(userResponse)
                .build(); // tokenType se doplní automaticky jako "Bearer"
    }


    private void publishAudit(
            Long userId,
            AuditStatus status
    ) {

        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        userId,
                        AuditAction.OAUTH_LOGIN,
                        status,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }


    private void publishAuditRegister(UserEntity user) {

        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        user.getId(),
                        AuditAction.REGISTER,
                        AuditStatus.SUCCESS,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }

}
