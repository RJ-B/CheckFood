package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantPhotoResponse;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

/**
 * Služba pro správu mediálního obsahu restaurace — logo, cover, panorama a galerie fotek.
 * Všechny operace vyžadují roli MANAGER nebo OWNER s permission {@code EDIT_RESTAURANT_INFO}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface RestaurantMediaService {

    /**
     * Nahraje (nebo nahradí) logo restaurace. Stará verze (pokud existovala) je smazána.
     *
     * @return nová URL loga
     */
    String uploadLogo(String userEmail, UUID restaurantId, MultipartFile file);

    /**
     * Nahraje (nebo nahradí) cover obrázek restaurace.
     *
     * @return nová URL coveru
     */
    String uploadCover(String userEmail, UUID restaurantId, MultipartFile file);

    /**
     * Smaže logo restaurace.
     */
    void deleteLogo(String userEmail, UUID restaurantId);

    /**
     * Smaže cover obrázek restaurace.
     */
    void deleteCover(String userEmail, UUID restaurantId);

    /**
     * Přidá fotku do galerie restaurace.
     */
    RestaurantPhotoResponse addGalleryPhoto(String userEmail, UUID restaurantId, MultipartFile file);

    /**
     * Vrátí seznam fotek v galerii restaurace.
     */
    List<RestaurantPhotoResponse> listGalleryPhotos(UUID restaurantId);

    /**
     * Smaže fotku z galerie podle ID. Také odstraní soubor z úložiště.
     */
    void deleteGalleryPhoto(String userEmail, UUID restaurantId, UUID photoId);
}
