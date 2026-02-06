package com.checkfood.checkfoodservice.application.repository.reservation;

import com.checkfood.checkfoodservice.application.entity.reservation.Reservation;
import com.checkfood.checkfoodservice.application.entity.reservation.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k doménové entitě {@link Reservation}. <br><br>
 *
 * Repository zajišťuje perzistenční operace nad rezervacemi
 * a podporuje scénáře související s blokací kapacity restaurace
 * v konkrétním časovém úseku. <br><br>
 *
 * Repository je navrženo s důrazem na:
 * - práci s časem a intervaly <br>
 * - rychlé validační dotazy <br>
 * - minimální počet joinů <br><br>
 *
 * Veškerá rozhodovací logika (kolize rezervací, výběr stolů,
 * potvrzení nebo zamítnutí rezervace) je řešena výhradně
 * v aplikační servisní vrstvě. <br><br>
 *
 * ROZŠIŘITELNOST A PŘIPRAVENOST NA BUDOUCÍ SCÉNÁŘE <br><br>
 *
 * 1) KOLIZE A ČASOVÉ KONFLIKTY <br>
 * - kontrola překryvu rezervací v čase <br>
 * - blokace kapacity restaurace nebo skupiny stolů <br><br>
 *
 * Repository poskytuje pouze základní dotazy.
 * Vyhodnocení konfliktů probíhá v servisní vrstvě. <br><br>
 *
 * 2) SKUPINY STOLŮ <br>
 * - rezervace nad více stoly <br>
 * - logické spojení stolů při potvrzení rezervace <br><br>
 *
 * Vazba na konkrétní stoly nebo skupiny stolů
 * je řešena nepřímo pomocí identifikátorů
 * a specializovaných doménových entit. <br><br>
 *
 * 3) AUTOMATICKÁ EXPIRACE <br>
 * - zrušení nevyužitých rezervací <br>
 * - periodické čištění databáze <br><br>
 *
 * Tyto scénáře jsou realizovány pomocí plánovaných úloh
 * a aplikačních služeb, nikoliv v repository vrstvě. <br><br>
 *
 * DESIGNOVÉ ROZHODNUTÍ <br>
 * Repository slouží výhradně jako persistence boundary.
 * Neobsahuje business pravidla ani rozhodovací logiku.
 */
public interface ReservationRepository extends JpaRepository<Reservation, UUID> {

    /**
     * Vrátí všechny rezervace dané restaurace
     * v zadaném časovém intervalu. <br><br>
     *
     * Používá se zejména pro:
     * - kontrolu kolizí rezervací <br>
     * - zobrazení obsazenosti restaurace <br><br>
     *
     * @param restaurantId identifikátor restaurace
     * @param from počátek časového intervalu
     * @param to konec časového intervalu
     * @return seznam rezervací v daném intervalu
     */
    List<Reservation> findByRestaurantIdAndReservationTimeBetween(
            UUID restaurantId,
            OffsetDateTime from,
            OffsetDateTime to
    );

    /**
     * Vrátí rezervace daného uživatele. <br><br>
     *
     * Používá se pro:
     * - přehled rezervací uživatele <br>
     * - správu a rušení rezervací <br><br>
     *
     * @param userId identifikátor uživatele
     * @return seznam rezervací uživatele
     */
    List<Reservation> findByUserId(UUID userId);

    /**
     * Vrátí rezervaci podle identifikátoru
     * a příslušnosti k restauraci. <br><br>
     *
     * Používá se pro validační účely,
     * aby bylo zajištěno, že rezervace
     * patří do dané restaurace. <br><br>
     *
     * @param id identifikátor rezervace
     * @param restaurantId identifikátor restaurace
     * @return rezervace, pokud existuje a patří restauraci
     */
    Optional<Reservation> findByIdAndRestaurantId(UUID id, UUID restaurantId);

    /**
     * Vrátí rezervace podle stavu. <br><br>
     *
     * Používá se zejména pro:
     * - administrativní přehled <br>
     * - automatickou expiraci rezervací <br><br>
     *
     * @param status stav rezervace
     * @return seznam rezervací v daném stavu
     */
    List<Reservation> findByStatus(ReservationStatus status);
}
