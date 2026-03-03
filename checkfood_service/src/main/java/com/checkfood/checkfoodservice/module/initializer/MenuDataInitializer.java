package com.checkfood.checkfoodservice.module.initializer;

import com.checkfood.checkfoodservice.module.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
@Profile("local")
public class MenuDataInitializer {

    private static final String TEST_RESTAURANT_NAME = "Testovací Restaurace Plzeň";

    private final RestaurantRepository restaurantRepository;
    private final MenuCategoryRepository menuCategoryRepository;
    private final MenuItemRepository menuItemRepository;

    @EventListener(ApplicationReadyEvent.class)
    @Order(101)
    public void seedMenu() {
        Optional<Restaurant> restaurantOpt = restaurantRepository.findAll().stream()
                .filter(r -> TEST_RESTAURANT_NAME.equals(r.getName()))
                .findFirst();

        if (restaurantOpt.isEmpty()) {
            log.info("[MenuSeed] Testovací restaurace neexistuje, přeskakuji seed menu.");
            return;
        }

        UUID restaurantId = restaurantOpt.get().getId();

        if (menuCategoryRepository.existsByRestaurantId(restaurantId)) {
            log.info("[MenuSeed] Menu pro testovací restauraci již existuje, přeskakuji.");
            return;
        }

        log.info("[MenuSeed] Vytvářím menu pro testovací restauraci...");

        // --- Předkrmy ---
        MenuCategory predkrmy = createCategory(restaurantId, "Předkrmy", 1);
        createItem(restaurantId, predkrmy.getId(), "Kulajda", "Tradiční česká bramboračka s houbami a vejcem", 8900, 1);
        createItem(restaurantId, predkrmy.getId(), "Hovězí vývar s nudlemi", "Domácí vývar s masem a nudlemi", 6500, 2);
        createItem(restaurantId, predkrmy.getId(), "Tatarák z lososa", "Čerstvý losos s avokádem a křupavým chlebem", 14900, 3);

        // --- Hlavní jídla ---
        MenuCategory hlavni = createCategory(restaurantId, "Hlavní jídla", 2);
        createItem(restaurantId, hlavni.getId(), "Svíčková na smetaně", "S houskovým knedlíkem a brusinkami", 18900, 1);
        createItem(restaurantId, hlavni.getId(), "Vepřo knedlo zelo", "Pečené vepřové s knedlíkem a zelím", 16900, 2);
        createItem(restaurantId, hlavni.getId(), "Řízek s bramborovým salátem", "Kuřecí řízek smažený v trojobalu", 17900, 3);
        createItem(restaurantId, hlavni.getId(), "Grilovaný pstruh", "Celý pstruh s bylinkovým máslem a brambory", 21900, 4);

        // --- Přílohy ---
        MenuCategory prilohy = createCategory(restaurantId, "Přílohy", 3);
        createItem(restaurantId, prilohy.getId(), "Houskový knedlík", "Klasický český knedlík", 3500, 1);
        createItem(restaurantId, prilohy.getId(), "Hranolky", "Křupavé hranolky", 4500, 2);
        createItem(restaurantId, prilohy.getId(), "Vařené brambory", "S máslem a petrželkou", 3900, 3);

        // --- Dezerty ---
        MenuCategory dezerty = createCategory(restaurantId, "Dezerty", 4);
        createItem(restaurantId, dezerty.getId(), "Palačinka s marmeládou", "Dvě palačinky s domácí marmeládou a šlehačkou", 7900, 1);
        createItem(restaurantId, dezerty.getId(), "Jablkový štrúdl", "Teplý štrúdl s vanilkovou zmrzlinou", 8500, 2);
        createItem(restaurantId, dezerty.getId(), "Zmrzlinový pohár", "Tři kopečky zmrzliny se šlehačkou", 6900, 3);

        // --- Nápoje ---
        MenuCategory napoje = createCategory(restaurantId, "Nápoje", 5);
        createItem(restaurantId, napoje.getId(), "Plzeňské pivo 0.5l", "Plzeňský Prazdroj 12°", 5500, 1);
        createItem(restaurantId, napoje.getId(), "Kofola 0.3l", "Originál Kofola z tanku", 3900, 2);
        createItem(restaurantId, napoje.getId(), "Minerální voda", "Mattoni neperlivá 0.33l", 2900, 3);
        createItem(restaurantId, napoje.getId(), "Domácí limonáda", "Citronová limonáda s mátou", 5900, 4);

        log.info("[MenuSeed] Menu vytvořeno: 5 kategorií, 17 položek.");
    }

    private MenuCategory createCategory(UUID restaurantId, String name, int sortOrder) {
        MenuCategory category = MenuCategory.builder()
                .restaurantId(restaurantId)
                .name(name)
                .sortOrder(sortOrder)
                .active(true)
                .build();
        return menuCategoryRepository.save(category);
    }

    private void createItem(UUID restaurantId, UUID categoryId, String name, String description,
                            int priceMinor, int sortOrder) {
        MenuItem item = MenuItem.builder()
                .restaurantId(restaurantId)
                .categoryId(categoryId)
                .name(name)
                .description(description)
                .priceMinor(priceMinor)
                .currency("CZK")
                .available(true)
                .sortOrder(sortOrder)
                .build();
        menuItemRepository.save(item);
    }
}
