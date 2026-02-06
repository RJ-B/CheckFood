package com.checkfood.checkfoodservice.application.repository.restaurant;

import com.checkfood.checkfoodservice.application.entity.restaurant.table.RestaurantTable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k entitě {@link RestaurantTable}. <br><br>
 *
 * Repository slouží k práci se stoly restaurace,
 * které jsou součástí agregátu Restaurant, avšak
 * jsou často dotazovány samostatně z důvodu výkonu
 * a jednoduchosti dotazů. <br><br>
 *
 * Repository podporuje zejména scénáře:
 * - zobrazení stolů restaurace <br>
 * - validaci existence stolu <br>
 * - vazbu na rezervace a objednávky <br><br>
 *
 * Repository záměrně neobsahuje logiku dostupnosti,
 * spojování stolů ani provozní rozhodování.
 * Tyto operace jsou řešeny výhradně v aplikační servisní vrstvě. <br><br>
 *
 * ROZŠIŘITELNOST A PŘIPRAVENOST NA BUDOUCÍ SCÉNÁŘE <br><br>
 *
 * 1) REZERVACE A DOSTUPNOST <br>
 * - kontrola dostupnosti stolu v čase <br>
 * - blokace stolu v rámci rezervace <br><br>
 *
 * Tyto scénáře budou realizovány pomocí
 * {@code ReservationRepository} a aplikační logiky,
 * nikoliv přímo v tomto repository. <br><br>
 *
 * 2) SKUPINY STOLŮ <br>
 * - spojování více stolů do jednoho logického celku <br>
 * - potvrzení rezervace nad skupinou stolů <br><br>
 *
 * Skupiny stolů jsou modelovány samostatnou entitou
 * a mají vlastní repository. <br><br>
 *
 * 3) CACHE A VÝKON <br>
 * - seznam stolů restaurace je vhodný pro cache <br><br>
 *
 * Caching je řešen pomocí cross-cutting cache vrstvy
 * a není součástí repository. <br><br>
 *
 * DESIGNOVÉ ROZHODNUTÍ <br>
 * Repository slouží výhradně jako persistence boundary.
 * Neobsahuje business logiku, validační pravidla
 * ani vazby na externí systémy.
 */
public interface RestaurantTableRepository extends JpaRepository<RestaurantTable, UUID> {

    /**
     * Vrátí všechny stoly patřící k dané restauraci. <br><br>
     *
     * Používá se zejména pro:
     * - zobrazení půdorysu restaurace <br>
     * - výběr stolu při rezervaci <br>
     * - administrativní správu stolů <br><br>
     *
     * @param restaurantId identifikátor restaurace
     * @return seznam stolů restaurace
     */
    List<RestaurantTable> findByRestaurantId(UUID restaurantId);

    /**
     * Vrátí konkrétní stůl v rámci dané restaurace. <br><br>
     *
     * Používá se pro validační účely,
     * aby bylo zajištěno, že stůl skutečně
     * patří do dané restaurace. <br><br>
     *
     * @param id identifikátor stolu
     * @param restaurantId identifikátor restaurace
     * @return stůl, pokud existuje a patří restauraci
     */
    Optional<RestaurantTable> findByIdAndRestaurantId(UUID id, UUID restaurantId);

    /**
     * Ověří existenci stolu v rámci restaurace. <br><br>
     *
     * Používá se pro rychlé validační kontroly
     * při vytváření rezervací a objednávek,
     * bez nutnosti načítat celou entitu. <br><br>
     *
     * @param id identifikátor stolu
     * @param restaurantId identifikátor restaurace
     * @return true pokud stůl existuje a patří restauraci
     */
    boolean existsByIdAndRestaurantId(UUID id, UUID restaurantId);

    void deleteByRestaurantId(UUID restaurantId);
}
