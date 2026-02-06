package com.checkfood.checkfoodservice.security.audit.controller;

import com.checkfood.checkfoodservice.security.audit.dto.AuditLogResponse;
import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;
import com.checkfood.checkfoodservice.security.audit.service.AuditService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;

import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;

import org.springframework.web.bind.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * Controller pro správu auditních záznamů (ADMIN).
 */
@RestController
@RequestMapping("/api/admin/audit")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AuditController {

    private final AuditService auditService;


    // =====================================================
    // ALL LOGS
    // =====================================================

    /**
     * Vrátí všechny auditní záznamy (stránkované).
     */
    @RateLimited(
            key = "audit:all",
            limit = 30,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perUser = true
    )
    @GetMapping
    public ResponseEntity<Page<AuditLogResponse>> getAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size
    ) {

        Pageable pageable =
                PageRequest.of(page, size);

        Page<AuditLogResponse> result =
                auditService
                        .findAll(pageable)
                        .map(this::toResponse);

        return ResponseEntity.ok(result);
    }


    // =====================================================
    // USER LOGS
    // =====================================================

    /**
     * Vrátí auditní záznamy konkrétního uživatele.
     */
    @RateLimited(
            key = "audit:user",
            limit = 30,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perUser = true
    )
    @GetMapping("/user/{userId}")
    public ResponseEntity<Page<AuditLogResponse>> getByUser(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size
    ) {

        Pageable pageable =
                PageRequest.of(page, size);

        Page<AuditLogResponse> result =
                auditService
                        .findByUser(userId, pageable)
                        .map(this::toResponse);

        return ResponseEntity.ok(result);
    }


    // =====================================================
    // MAPPING
    // =====================================================

    /**
     * Mapování entity → DTO.
     */
    private AuditLogResponse toResponse(AuditLogEntity entity) {

        AuditLogResponse dto =
                new AuditLogResponse();

        dto.setId(entity.getId());
        dto.setUserId(entity.getUserId());
        dto.setAction(entity.getAction());
        dto.setStatus(entity.getStatus());
        dto.setIpAddress(entity.getIpAddress());
        dto.setUserAgent(entity.getUserAgent());
        dto.setCreatedAt(entity.getCreatedAt());

        return dto;
    }

}
