package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.module.order.entity.PaymentStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

/**
 * Klient pro platební bránu Moone (ZnPay).
 * Zajišťuje autentizaci s 5minutovým tokenem, iniciování transakcí a dotazování na jejich stav.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@Slf4j
public class MoonePaymentService {

    private static final String BASE_URL = "https://api.znpay.tech";
    private static final long TOKEN_TTL_MS = 5 * 60 * 1000L;

    @Value("${moone.login}")
    private String login;

    @Value("${moone.password}")
    private String password;

    @Value("${moone.pay-point-id}")
    private String payPointPublicId;

    @Value("${app.backend.url:http://localhost:8081}")
    private String backendUrl;

    private final RestTemplate restTemplate;

    private String cachedToken;
    private long tokenExpiry = 0;

    /**
     * Vytvoří instanci s injektovaným RestTemplate.
     *
     * @param restTemplate HTTP klient pro volání Moone API
     */
    public MoonePaymentService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    /**
     * Vrátí platný Bearer token. Provede re-autentizaci, pokud token expiroval nebo chybí.
     *
     * @return platný Bearer token
     */
    public String getToken() {
        if (cachedToken != null && System.currentTimeMillis() < tokenExpiry) {
            return cachedToken;
        }
        return authenticate();
    }

    private String authenticate() {
        String url = BASE_URL + "/payment/api/auth/sign-in";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> body = Map.of(
                "login", login,
                "password", password
        );

        HttpEntity<Map<String, String>> request = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
            Map<?, ?> responseBody = response.getBody();

            if (responseBody == null || !responseBody.containsKey("token")) {
                throw new IllegalStateException("Moone auth response neobsahuje token");
            }

            cachedToken = (String) responseBody.get("token");
            tokenExpiry = System.currentTimeMillis() + TOKEN_TTL_MS;

            log.debug("Moone: autentizace proběhla úspěšně, token platí 5 minut");
            return cachedToken;

        } catch (HttpClientErrorException e) {
            log.error("Moone autentizace selhala: {} {}", e.getStatusCode(), e.getResponseBodyAsString());
            throw new IllegalStateException("Nelze se autentizovat u Moone: " + e.getMessage(), e);
        }
    }

    /**
     * Iniciuje platební transakci u Moone.
     *
     * @param amountMinor  částka v haléřích
     * @param currencyCode kód měny (např. "CZK")
     * @return výsledek s publicID transakce a redirectUrl
     */
    public MooneTransactionResult initiateTransaction(int amountMinor, String currencyCode) {
        String url = BASE_URL + "/payment/api/transactions/initiate";
        String callbackUrl = backendUrl + "/api/v1/payments/callback";
        double amount = amountMinor / 100.0;

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(getToken());

        Map<String, Object> body = Map.of(
                "payPointPublicID", payPointPublicId,
                "callbackUrl", callbackUrl,
                "amount", amount,
                "currencyCode", currencyCode
        );

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
            Map<?, ?> responseBody = response.getBody();

            if (responseBody == null) {
                throw new IllegalStateException("Moone initiate vrátil prázdnou odpověď");
            }

            String transactionId = (String) responseBody.get("publicID");
            String redirectUrl = (String) responseBody.get("redirectUrl");

            log.info("Moone: transakce iniciována, publicID={}, redirectUrl={}", transactionId, redirectUrl);
            return new MooneTransactionResult(transactionId, redirectUrl);

        } catch (HttpClientErrorException e) {
            log.error("Moone initiate selhalo: {} {}", e.getStatusCode(), e.getResponseBodyAsString());
            throw new IllegalStateException("Nelze iniciovat platbu u Moone: " + e.getMessage(), e);
        }
    }

    /**
     * Dotáže se na stav transakce a přemapuje výsledek na interní PaymentStatus.
     *
     * @param transactionId publicID transakce z Moone
     * @return interní stav platby
     */
    public PaymentStatus getTransactionStatus(String transactionId) {
        String url = BASE_URL + "/payment/api/transactions/" + transactionId + "/status";

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(getToken());

        HttpEntity<Void> request = new HttpEntity<>(headers);

        try {
            ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, request, Map.class);
            Map<?, ?> responseBody = response.getBody();

            if (responseBody == null) {
                log.warn("Moone status pro {} vrátil prázdnou odpověď", transactionId);
                return PaymentStatus.PROCESSING;
            }

            String status = responseBody.containsKey("status")
                    ? String.valueOf(responseBody.get("status")).toUpperCase()
                    : "";

            log.debug("Moone status pro {}: {}", transactionId, status);

            return switch (status) {
                case "PAID", "COMPLETED", "SUCCESS" -> PaymentStatus.PAID;
                case "FAILED", "DECLINED", "ERROR"  -> PaymentStatus.FAILED;
                case "CANCELLED"                    -> PaymentStatus.CANCELLED;
                case "INITIATED"                    -> PaymentStatus.INITIATED;
                default                             -> PaymentStatus.PROCESSING;
            };

        } catch (HttpClientErrorException e) {
            log.error("Moone status dotaz selhal pro {}: {} {}",
                    transactionId, e.getStatusCode(), e.getResponseBodyAsString());
            return PaymentStatus.PROCESSING;
        }
    }

    /**
     * Výsledek inicializace platební transakce obsahující ID transakce a URL pro přesměrování.
     */
    public record MooneTransactionResult(String transactionId, String redirectUrl) {}
}
