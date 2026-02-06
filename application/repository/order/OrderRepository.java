package com.checkfood.checkfoodservice.application.repository.order;

import com.checkfood.checkfoodservice.application.entity.order.Order;
import com.checkfood.checkfoodservice.application.entity.order.OrderStatus;
import com.checkfood.checkfoodservice.application.entity.order.OrderType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k doménové entitě {@link Order}. <br><br>
 *
 * Order je samostatný agregátový kořen reprezentující
 * objednávku vytvořenou v konkrétní restauraci
 * a v konkrétním provozním kontextu
 * (QR u stolu, obsluha, takeaway). <br><br>
 *
 * Repository poskytuje pouze dotazy,
 * které odpovídají skutečným aplikačním scénářům
 * a jsou optimalizované pro výkon
 * a minimální počet joinů. <br><br>
 *
 * Repository záměrně:
 * - neobsahuje business logiku <br>
 * - neřeší stavové přechody <br>
 * - neobsahuje složité kombinované filtry <br><br>
 *
 * <br>
 * ROZŠIŘITELNOST A PŘIPRAVENOST NA BUDOUCÍ SCÉNÁŘE <br><br>
 *
 * 1) REPORTING A ANALYTIKA <br>
 * Pro složité reporty (tržby, vytíženost stolů,
 * průměrná doba objednávky) bude použit:
 * - specializovaný read model <br>
 * - nebo analytická databáze <br><br>
 *
 * Repository zůstane beze změny. <br><br>
 *
 * 2) EVENT-DRIVEN ARCHITEKTURA <br>
 * Vznik a změna objednávky může publikovat
 * doménové události (OrderCreated, OrderPaid, …). <br>
 * Repository pouze perzistuje stav,
 * události řeší servisní vrstva. <br><br>
 *
 * 3) CACHE A VÝKON <br>
 * Detail objednávky a seznam aktivních objednávek
 * jsou vhodnými kandidáty pro cache. <br>
 * Caching je řešen cross-cutting vrstvou,
 * nikoliv repository. <br><br>
 *
 * 4) EXTERNÍ SYSTÉMY <br>
 * Repository není závislé na:
 * - platebních branách <br>
 * - POS systémech <br>
 * - kuchyňských obrazovkách <br><br>
 *
 * Integrace probíhá výhradně
 * v aplikační servisní vrstvě.
 */
public interface OrderRepository extends JpaRepository<Order, UUID> {

    /**
     * Načte objednávku podle ID. <br><br>
     *
     * Používá se pro:
     * - detail objednávky <br>
     * - validaci existence objednávky <br>
     *
     * @param id identifikátor objednávky
     * @return objednávka nebo prázdný výsledek
     */
    Optional<Order> findById(UUID id);

    /**
     * Načte všechny objednávky konkrétní restaurace. <br><br>
     *
     * Používá se:
     * - v administračním přehledu restaurace <br>
     * - pro provozní monitoring <br>
     *
     * @param restaurantId identifikátor restaurace
     * @return seznam objednávek
     */
    List<Order> findByRestaurantId(UUID restaurantId);

    /**
     * Načte objednávky uživatele. <br><br>
     *
     * Používá se:
     * - v profilu uživatele <br>
     * - v historii objednávek <br>
     *
     * @param userId identifikátor uživatele
     * @return seznam objednávek
     */
    List<Order> findByUserId(UUID userId);

    /**
     * Načte objednávky podle typu objednávky. <br><br>
     *
     * Slouží především pro:
     * - provozní statistiky <br>
     * - administrativní přehledy <br>
     *
     * @param orderType typ objednávky
     * @return seznam objednávek
     */
    List<Order> findByOrderType(OrderType orderType);

    /**
     * Načte objednávky podle stavu. <br><br>
     *
     * Používá se:
     * - v kuchyni <br>
     * - v rozhraní obsluhy <br>
     *
     * @param status stav objednávky
     * @return seznam objednávek
     */
    List<Order> findByStatus(OrderStatus status);

    /**
     * Načte objednávky vytvořené v určitém časovém intervalu. <br><br>
     *
     * Používá se:
     * - pro reporting <br>
     * - pro audit <br>
     *
     * @param from začátek intervalu
     * @param to konec intervalu
     * @return seznam objednávek
     */
    List<Order> findByCreatedAtBetween(OffsetDateTime from, OffsetDateTime to);

    /**
     * Ověří existenci objednávky ve zvoleném stavu. <br><br>
     *
     * Používá se:
     * - při validaci workflow <br>
     * - při kontrolách v servisní vrstvě <br>
     *
     * @param id identifikátor objednávky
     * @param status stav objednávky
     * @return true pokud objednávka existuje
     */
    boolean existsByIdAndStatus(UUID id, OrderStatus status);
}
