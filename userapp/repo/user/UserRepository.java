package com.checkfood.checkfoodservice.application.repository.user;

import com.checkfood.checkfoodservice.application.entity.user.User;
import com.checkfood.checkfoodservice.application.entity.user.UserStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k doménové entitě {@link User}. <br><br>
 *
 * Repository zajišťuje perzistenci a čtení
 * uživatelských účtů systému. <br><br>
 *
 * Neobsahuje žádnou autentizační ani autorizační logiku.
 * Slouží výhradně jako přístupová vrstva k databázi
 * pro aplikační servisní vrstvu. <br><br>
 *
 * Repository reflektuje skutečné aplikační scénáře:
 * - přihlášení uživatele <br>
 * - registrace uživatele <br>
 * - ověřování existence účtu <br>
 * - práce se stavem uživatele <br><br>
 *
 * <br>
 * ROZŠIŘITELNOST A PŘIPRAVENOST NA BUDOUCÍ SCÉNÁŘE <br><br>
 *
 * 1) EXTERNÍ IDENTITY (OAUTH / SSO) <br>
 * Podpora externích poskytovatelů (Google, Apple,
 * Facebook, Android) je připravena na úrovni
 * aplikační vrstvy. <br>
 * Repository zůstává nezměněné,
 * protože pracuje pouze s perzistentní identitou uživatele. <br><br>
 *
 * 2) VÍCENÁSOBNÉ PŘIHLAŠOVACÍ METODY <br>
 * Uživatel se může přihlašovat:
 * - e-mailem <br>
 * - uživatelským jménem <br><br>
 *
 * Repository poskytuje odpovídající dotazy
 * bez nutnosti kombinovaných filtrů. <br><br>
 *
 * 3) BEZPEČNOST A STAV ÚČTU <br>
 * Stav účtu (aktivní, blokovaný, smazaný)
 * je řešen pomocí {@link UserStatus}. <br>
 * Repository umožňuje ověřovat stav účtu,
 * ale neřeší samotnou bezpečnostní logiku. <br><br>
 *
 * 4) CACHE A VÝKON <br>
 * Čtení uživatele dle identifikátorů
 * je vhodné pro cache. <br>
 * Cache je řešena cross-cutting vrstvou,
 * repository zůstává čisté. <br><br>
 *
 * 5) GDPR A ANONYMIZACE <br>
 * Budoucí anonymizace uživatelských dat
 * bude řešena aktualizací uložených hodnot
 * v servisní vrstvě. <br>
 * Repository poskytuje pouze technický přístup
 * k datům.
 */
public interface UserRepository extends JpaRepository<User, UUID> {

    /**
     * Načte uživatele podle e-mailové adresy. <br><br>
     *
     * Používá se:
     * - při přihlášení uživatele <br>
     * - při registraci (kontrola duplicity) <br>
     * - při obnově hesla <br>
     *
     * @param email e-mailová adresa
     * @return uživatel nebo prázdný výsledek
     */
    Optional<User> findByEmail(String email);

    /**
     * Načte uživatele podle uživatelského jména. <br><br>
     *
     * Používá se:
     * - při přihlášení uživatele <br>
     * - při validaci unikátnosti uživatelského jména <br>
     *
     * @param username uživatelské jméno
     * @return uživatel nebo prázdný výsledek
     */
    Optional<User> findByUsername(String username);

    /**
     * Ověří existenci uživatele s daným e-mailem. <br><br>
     *
     * Používá se:
     * - při registraci <br>
     * - při změně e-mailu <br>
     *
     * @param email e-mailová adresa
     * @return true pokud uživatel existuje
     */
    boolean existsByEmail(String email);

    /**
     * Ověří existenci uživatele s daným uživatelským jménem. <br><br>
     *
     * Používá se:
     * - při registraci <br>
     * - při změně uživatelského jména <br>
     *
     * @param username uživatelské jméno
     * @return true pokud uživatel existuje
     */
    boolean existsByUsername(String username);

    /**
     * Ověří existenci uživatele v konkrétním stavu. <br><br>
     *
     * Používá se:
     * - při přihlášení (blokovaný / deaktivovaný účet) <br>
     * - při bezpečnostních kontrolách <br>
     *
     * @param id identifikátor uživatele
     * @param status stav uživatele
     * @return true pokud uživatel existuje
     */
    boolean existsByIdAndStatus(UUID id, UserStatus status);
}
