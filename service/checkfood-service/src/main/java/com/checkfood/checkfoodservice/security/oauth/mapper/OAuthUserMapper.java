package com.checkfood.checkfoodservice.security.oauth.mapper;

import com.checkfood.checkfoodservice.security.oauth.provider.OAuthUserInfo;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import org.springframework.stereotype.Component;

/**
 * Mapper pro převod OAuth dat na interní UserEntity.
 * Zajišťuje správné rozdělení jména na firstName a lastName podle standardu aplikace.
 */
@Component
public class OAuthUserMapper {

    /**
     * Vytvoří nového uživatele z OAuth informací.
     */
    public UserEntity toNewUser(OAuthUserInfo userInfo) {
        if (userInfo == null) {
            return null;
        }

        UserEntity user = new UserEntity();
        user.setEmail(userInfo.getEmail());
        user.setEnabled(true);

        // Zpracování jména: OAuth poskytovatelé často vrací celé jméno v jednom poli
        String fullName = userInfo.getFullName();
        if (fullName != null && !fullName.isBlank()) {
            String[] nameParts = fullName.trim().split("\\s+", 2);

            if (nameParts.length > 0) {
                user.setFirstName(nameParts[0]);
            }

            if (nameParts.length > 1) {
                user.setLastName(nameParts[1]);
            } else {
                // Pokud má uživatel jen jedno jméno, nastavíme ho jako firstName
                // a lastName necháme prázdné nebo jako tečku/pomlčku dle politiky
                user.setLastName("");
            }
        }

        return user;
    }
}