package com.checkfood.checkfoodservice.security.user.specification;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;

import org.springframework.data.jpa.domain.Specification;

/**
 * Dynamické filtry pro uživatele.
 */
public class UserSpecification {

    public static Specification<UserEntity> hasEmail(String email) {

        return (root, query, cb) ->
                email == null ? null :
                        cb.like(
                                cb.lower(root.get("email")),
                                "%" + email.toLowerCase() + "%"
                        );
    }


    public static Specification<UserEntity> isEnabled(Boolean enabled) {

        return (root, query, cb) ->
                enabled == null ? null :
                        cb.equal(root.get("enabled"), enabled);
    }


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
