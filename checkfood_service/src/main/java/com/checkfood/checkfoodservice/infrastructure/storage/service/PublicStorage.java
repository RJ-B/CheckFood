package com.checkfood.checkfoodservice.infrastructure.storage.service;

import org.springframework.beans.factory.annotation.Qualifier;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Qualifier marker pro {@link StorageService} bean ukládající <b>veřejný</b> obsah
 * (loga restaurací, cover obrázky, galerie, panorama, fotky položek menu).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Qualifier("publicStorage")
@Target({ElementType.FIELD, ElementType.PARAMETER, ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface PublicStorage {
}
