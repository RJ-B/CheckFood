package com.checkfood.checkfoodservice.module.order.dining.controller;

import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningContextResponse;
import com.checkfood.checkfoodservice.module.order.dining.service.DiningContextService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * REST kontroler pro získání aktivního kontextu stravování přihlášeného uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequiredArgsConstructor
public class DiningContextController {

    private final DiningContextService diningContextService;

    /**
     * Vrátí aktivní dining kontext přihlášeného uživatele — restauraci, stůl, rezervaci a sezení.
     *
     * @param authentication aktuální autentizace
     * @return aktivní dining kontext
     */
    @GetMapping("/api/v1/dining-context/me")
    public ResponseEntity<DiningContextResponse> getMyDiningContext(Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(diningContextService.getActiveDiningContext(userId));
    }

    private Long extractUserId(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getId();
    }
}
