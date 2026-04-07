package com.checkfood.checkfoodservice.security.module.user.specification;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

import org.springframework.data.jpa.domain.Specification;

/**
 * Utility třída poskytující kompozitelné JPA Specification filtry pro dynamické dotazování uživatelů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserEntity
 * @see Specification
 */
public class UserSpecification {

    /**
     * Private konstruktor pro zabránění instanciaci utility třídy.
     */
    private UserSpecification() {
        throw new UnsupportedOperationException("Utility class");
    }

    /**
     * Vytvoří specification pro filtrování podle emailové adresy.
     * Provádí case-insensitive LIKE vyhledávání (obsahuje email).
     *
     * @param email emailová adresa nebo její část k vyhledání
     * @return specification nebo null pokud email není zadán
     */
    public static Specification<UserEntity> hasEmail(String email) {

        return (root, query, cb) ->
                email == null ? null :
                        cb.like(
                                cb.lower(root.get("email")),
                                "%" + email.toLowerCase() + "%"
                        );
    }

    /**
     * Vytvoří specification pro filtrování podle stavu aktivace účtu.
     * Umožňuje zobrazit pouze aktivní nebo neaktivní uživatele.
     *
     * @param enabled true pro aktivní účty, false pro neaktivní, null pro všechny
     * @return specification nebo null pokud enabled není zadán
     */
    public static Specification<UserEntity> isEnabled(Boolean enabled) {

        return (root, query, cb) ->
                enabled == null ? null :
                        cb.equal(root.get("enabled"), enabled);
    }

    /**
     * Vytvoří specification pro filtrování uživatelů podle role.
     * Provádí join na tabulku roles a filtruje podle názvu role.
     *
     * @param roleName název role (např. "ADMIN", "USER")
     * @return specification nebo null pokud roleName není zadán
     */
    public static Specification<UserEntity> hasRole(String roleName) {

        return (root, query, cb) -> {

            if (roleName == null) {
                return null;
            }

            return cb.equal(
                    root.join("roles").get("name"),
                    roleName
            );
        };
    }
}