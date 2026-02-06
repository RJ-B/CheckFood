package com.checkfood.checkfoodservice.application.repository.restaurant;

import com.checkfood.checkfoodservice.application.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.application.entity.restaurant.RestaurantStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k doménové entitě {@link Restaurant}. <br><br>
 *
 * Repository poskytuje pouze minimální sadu dotazů odpovídající
 * aktuálním aplikačním scénářům systému: <br>
 * - listování restaurací <br>
 * - zobrazení detailu restaurace <br>
 * - validační dotazy (existence, aktivní stav) <br>
 * - administrativní přehled <br><br>
 *
 * Záměrně neobsahuje obecné CRUD metody nad rámec
 * {@link org.springframework.data.jpa.repository.JpaRepository},
 * aby nedocházelo k nekontrolovanému růstu přístupových metod
 * a porušení aplikační architektury. <br><br>
 *
 * ROZŠIŘITELNOST A PŘIPRAVENOST NA BUDOUCÍ SCÉNÁŘE <br><br>
 *
 * 1) VYHLEDÁVÁNÍ A FILTROVÁNÍ <br>
 * - fulltextové vyhledávání podle názvu nebo popisu restaurace <br>
 * - filtrování podle lokality, typu kuchyně nebo hodnocení <br>
 * - kombinované filtry nad více kritérii <br><br>
 *
 * Tyto scénáře budou řešeny buď pomocí vlastních JPQL / Criteria dotazů,
 * specializovaných read-modelů, nebo pomocí externí vyhledávací služby
 * (např. Elasticsearch). Repository zůstává beze změny. <br><br>
 *
 * 2) EXTERNÍ ZDROJE (Google, třetí strany) <br>
 * - import restaurací z externích služeb (např. Google Places API) <br>
 * - pravidelná synchronizace základních identifikačních údajů <br><br>
 *
 * Externí identifikátory jsou ukládány přímo do entity {@link Restaurant}.
 * Samotná synchronizace a komunikace s externími službami je realizována
 * v servisní vrstvě nebo pomocí plánovaných úloh. <br><br>
 *
 * 3) CACHE A VÝKON <br>
 * - výsledky listování restaurací a detailu restaurace jsou vhodné pro cachování <br><br>
 *
 * Mechanismus cache je řešen pomocí cross-cutting vrstvy systému
 * a není součástí repository vrstvy, která zůstává čistá a nezávislá. <br><br>
 *
 * 4) EVENT-DRIVEN ARCHITEKTURA <br>
 * - změny stavu nebo dat restaurace mohou publikovat doménové události <br><br>
 *
 * Repository slouží výhradně k perzistenci dat.
 * Publikace událostí a reakce na ně jsou realizovány v aplikační servisní vrstvě. <br><br>
 *
 * DESIGNOVÉ ROZHODNUTÍ <br>
 * Repository neobsahuje business logiku, neřeší cache,
 * nekomunikuje s externími službami a neprovádí validační operace.
 * Slouží výhradně jako persistence boundary mezi doménou a databází.
 */

public interface RestaurantRepository extends JpaRepository<Restaurant, UUID> {

    /**
     * Vrátí seznam všech aktivních restaurací.
     *
     * Používá se pro veřejné listování.
     *
     * @return seznam aktivních restaurací
     */
    List<Restaurant> findByActiveTrue();

    /**
     * Vrátí detail aktivní restaurace.
     *
     * Používá se pro veřejný detail.
     *
     * @param id identifikátor restaurace
     * @return restaurace, pokud je aktivní
     */
    Optional<Restaurant> findByIdAndActiveTrue(UUID id);

    /**
     * Ověří existenci aktivní restaurace.
     *
     * Používá se pro rychlé validační kontroly
     * (objednávky, rezervace).
     *
     * @param id identifikátor restaurace
     * @return true pokud existuje a je aktivní
     */
    boolean existsByIdAndActiveTrue(UUID id);

    /**
     * Vrátí restaurace podle stavu.
     *
     * Používá se především v administraci.
     *
     * @param status stav restaurace
     * @return seznam restaurací
     */
    List<Restaurant> findByStatus(RestaurantStatus status);
}
