package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.AresLookupResponse;
import com.checkfood.checkfoodservice.module.owner.dto.ClaimResultResponse;
import com.checkfood.checkfoodservice.module.owner.exception.OwnerClaimException;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.Normalizer;
import java.time.LocalDateTime;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class OwnerClaimServiceImpl implements OwnerClaimService {

    private final AresService aresService;
    private final BankIdService bankIdService;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final UserService userService;

    private final ConcurrentHashMap<String, EmailClaimCode> emailCodes = new ConcurrentHashMap<>();

    private static final int CODE_TTL_MINUTES = 15;

    @Override
    @Transactional(readOnly = true)
    public AresLookupResponse lookupAres(String ico, Long userId) {
        var aresInfo = aresService.lookupByIco(ico);

        var restaurant = restaurantRepository.findByIco(ico)
                .orElseThrow(OwnerClaimException::restaurantNotFound);

        log.info("ARES lookup success: ICO={}, company={}, restaurantId={}", ico, aresInfo.companyName(), restaurant.getId());

        return AresLookupResponse.builder()
                .ico(aresInfo.ico())
                .companyName(aresInfo.companyName())
                .restaurantId(restaurant.getId())
                .requiresIdentityVerification(true)
                .statutoryPersons(aresInfo.statutoryPersons())
                .build();
    }

    @Override
    public ClaimResultResponse verifyBankId(String ico, Long userId) {
        var aresInfo = aresService.lookupByIco(ico);
        var bankIdIdentity = bankIdService.verifyIdentity(userId);

        var restaurant = restaurantRepository.findByIco(ico)
                .orElseThrow(OwnerClaimException::restaurantNotFound);

        String bankIdNormalized = normalize(bankIdIdentity.lastName() + " " + bankIdIdentity.firstName());

        boolean matched = aresInfo.statutoryPersons().stream()
                .map(this::normalize)
                .anyMatch(person -> person.equals(bankIdNormalized));

        if (matched) {
            log.info("BankID identity MATCHED for userId={}, ICO={}", userId, ico);
            createMembership(userId, restaurant);
            return ClaimResultResponse.builder()
                    .success(true)
                    .matched(true)
                    .membershipCreated(true)
                    .build();
        }

        log.info("BankID identity MISMATCH for userId={}, ICO={}. Email fallback available.", userId, ico);
        String emailHint = maskEmail(restaurant.getContactEmail());
        return ClaimResultResponse.builder()
                .success(false)
                .matched(false)
                .emailFallbackAvailable(restaurant.getContactEmail() != null)
                .emailHint(emailHint)
                .build();
    }

    @Override
    public ClaimResultResponse startEmailClaim(String ico, Long userId) {
        var restaurant = restaurantRepository.findByIco(ico)
                .orElseThrow(OwnerClaimException::restaurantNotFound);

        String code = String.format("%06d", ThreadLocalRandom.current().nextInt(1_000_000));
        String key = ico + ":" + userId;
        emailCodes.put(key, new EmailClaimCode(code, LocalDateTime.now().plusMinutes(CODE_TTL_MINUTES)));

        // Mock email - just log it
        log.info("[MOCK EMAIL] Verification code for ICO={}, userId={}: {}", ico, userId, code);
        log.info("[MOCK EMAIL] Would send to: {}", restaurant.getContactEmail());

        String emailHint = maskEmail(restaurant.getContactEmail());
        return ClaimResultResponse.builder()
                .success(true)
                .emailFallbackAvailable(true)
                .emailHint(emailHint)
                .build();
    }

    @Override
    public ClaimResultResponse confirmEmailClaim(String ico, String code, Long userId) {
        String key = ico + ":" + userId;
        var stored = emailCodes.get(key);

        if (stored == null) {
            throw OwnerClaimException.invalidCode();
        }

        if (stored.expiresAt().isBefore(LocalDateTime.now())) {
            emailCodes.remove(key);
            throw OwnerClaimException.codeExpired();
        }

        if (!stored.code().equals(code)) {
            throw OwnerClaimException.invalidCode();
        }

        emailCodes.remove(key);

        var restaurant = restaurantRepository.findByIco(ico)
                .orElseThrow(OwnerClaimException::restaurantNotFound);

        createMembership(userId, restaurant);

        log.info("Email claim confirmed for userId={}, ICO={}", userId, ico);
        return ClaimResultResponse.builder()
                .success(true)
                .matched(true)
                .membershipCreated(true)
                .build();
    }

    // --- Private helpers ---

    private void createMembership(Long userId, Restaurant restaurant) {
        if (employeeRepository.existsByUserIdAndRestaurantId(userId, restaurant.getId())) {
            throw OwnerClaimException.alreadyClaimed();
        }

        var user = userService.findById(userId);

        var employee = RestaurantEmployee.builder()
                .user(user)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .build();

        employeeRepository.save(employee);
        log.info("Created OWNER membership: userId={}, restaurantId={}", userId, restaurant.getId());
    }

    private String normalize(String input) {
        if (input == null) return "";
        String decomposed = Normalizer.normalize(input.trim().toLowerCase(), Normalizer.Form.NFD);
        return decomposed.replaceAll("\\p{M}", "");
    }

    private String maskEmail(String email) {
        if (email == null || !email.contains("@")) return "***";
        int atIndex = email.indexOf('@');
        if (atIndex <= 2) return "***" + email.substring(atIndex);
        return email.substring(0, 2) + "***" + email.substring(atIndex);
    }

    private record EmailClaimCode(String code, LocalDateTime expiresAt) {}
}
