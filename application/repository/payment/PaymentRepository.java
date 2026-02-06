package com.checkfood.checkfoodservice.application.repository.payment;

import com.checkfood.checkfoodservice.application.entity.payment.Payment;
import com.checkfood.checkfoodservice.application.entity.payment.PaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k doménové entitě {@link Payment}. <br><br>
 *
 * Repository slouží výhradně k perzistenci a čtení
 * platebních záznamů. <br><br>
 *
 * Neobsahuje žádnou business logiku, neprovádí
 * autorizaci plateb ani nevyhodnocuje platební scénáře.
 * Slouží pouze jako technická brána k databázi. <br><br>
 *
 * Poskytuje minimální množinu dotazů odpovídajících
 * aktuálním aplikačním potřebám:
 * - načtení plateb k objednávce
 * - kontrola existence úspěšné platby
 * - práce s idempotencí
 * - administrativní a auditní přehled
 *
 * <br>
 * <br>
 * ROZŠIŘITELNOST A PŘIPRAVENOST NA BUDOUCÍ SCÉNÁŘE <br><br>
 *
 * 1) TYP PLATBY (ODVOZENÝ KONCEPT) <br>
 * Koncept typu platby (např. QR platba, hotově u obsluhy,
 * karta u terminálu, online takeaway) není v databázi
 * ukládán explicitně. <br>
 * Je odvozen kombinací:
 * - způsobu platby (PaymentMethod) <br>
 * - kanálu platby (PaymentChannel) <br><br>
 *
 * Tento přístup zabraňuje duplicitě dat a zajišťuje
 * konzistenci doménového modelu. <br><br>
 *
 * 2) EXTERNÍ PLATEBNÍ SLUŽBY <br>
 * Integrace s externími poskytovateli (např. Stripe,
 * platební brány bank) je realizována mimo repository. <br>
 * Repository pouze uchovává:
 * - externí identifikátor platby <br>
 * - výsledek platebního procesu <br><br>
 *
 * Veškerá komunikace s externími systémy
 * probíhá v servisní vrstvě nebo v client modulech. <br><br>
 *
 * 3) IDEMPOTENCE A BEZPEČNOST <br>
 * Repository podporuje práci s idempotency klíčem,
 * který chrání systém před duplicitními platbami
 * způsobenými opakovanými požadavky. <br><br>
 *
 * 4) CACHE A VÝKON <br>
 * Platební data nejsou primárně určena k častému
 * listování. <br>
 * Pokud bude potřeba optimalizovat výkon
 * (např. pro reporting), bude použit:
 * - read model <br>
 * - nebo dedikovaná projekce <br><br>
 *
 * Repository zůstává beze změny.
 */
public interface PaymentRepository extends JpaRepository<Payment, UUID> {

    /**
     * Načte všechny platby vztahující se ke konkrétní objednávce. <br><br>
     *
     * Používá se:
     * - při zobrazení detailu objednávky <br>
     * - při vyhodnocování platebního stavu objednávky <br>
     *
     * @param orderId identifikátor objednávky
     * @return seznam platebních pokusů
     */
    List<Payment> findByOrderId(UUID orderId);

    /**
     * Načte platbu podle idempotency klíče. <br><br>
     *
     * Slouží k ochraně proti duplicitním platbám
     * při opakovaném volání platebního endpointu.
     *
     * @param idempotencyKey unikátní idempotency klíč
     * @return nalezená platba nebo prázdný výsledek
     */
    Optional<Payment> findByIdempotencyKey(String idempotencyKey);

    /**
     * Ověří, zda již existuje úspěšná platba
     * pro konkrétní objednávku. <br><br>
     *
     * Používá se:
     * - před vytvořením nové platby <br>
     * - při validaci platebního stavu objednávky <br>
     *
     * @param orderId identifikátor objednávky
     * @param status stav platby (typicky SUCCESS)
     * @return true pokud platba existuje
     */
    boolean existsByOrderIdAndStatus(UUID orderId, PaymentStatus status);

    Optional<Payment> findByExternalPaymentId(String externalPaymentId);

}
