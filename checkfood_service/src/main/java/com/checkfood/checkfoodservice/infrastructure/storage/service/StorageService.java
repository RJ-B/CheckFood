package com.checkfood.checkfoodservice.infrastructure.storage.service;

import java.time.Duration;

/**
 * Interface pro abstrakci souborového úložiště — ukládání, mazání,
 * generování veřejných URL i signed URL pro privátní obsah.
 *
 * <p>Existují dva logické buckety:
 * <ul>
 *   <li><b>publicStorage</b> — pro veřejně dostupný obsah (loga restaurací,
 *       cover obrázky, galerie, panorama, fotky položek menu).
 *       {@link #getDownloadUrl(String)} vrací přímou veřejnou URL.</li>
 *   <li><b>privateStorage</b> — pro citlivý obsah (avatary uživatelů, KYC).
 *       {@link #getDownloadUrl(String)} vrací V4 signed URL s defaultní platností 1 hodina.</li>
 * </ul>
 *
 * @author Rostislav Jirák
 * @version 2.0.0
 */
public interface StorageService {

    /** Defaultní platnost signed URL pro privátní obsah. */
    Duration DEFAULT_SIGNED_URL_TTL = Duration.ofHours(1);

    /**
     * Uloží soubor do zadaného adresáře úložiště.
     *
     * @param directory   název adresáře v úložišti (bez vedoucího lomítka)
     * @param filename    název ukládaného souboru
     * @param data        binární obsah souboru
     * @param contentType MIME typ souboru
     * @return relativní cesta k uloženému souboru (object path)
     */
    String store(String directory, String filename, byte[] data, String contentType);

    /**
     * Smaže soubor na zadané cestě z úložiště. Idempotentní — pokud
     * soubor neexistuje, operace mlčky uspěje.
     *
     * @param path object path získaná z {@link #store(String, String, byte[], String)}
     */
    void delete(String path);

    /**
     * Vrátí URL pro stažení souboru. Pro public bucket vrací přímou veřejnou URL,
     * pro privátní bucket vrací V4 signed URL s defaultní platností {@link #DEFAULT_SIGNED_URL_TTL}.
     *
     * @param path object path souboru v úložišti
     * @return URL ke stažení (veřejná nebo signed podle typu bucketu)
     */
    String getDownloadUrl(String path);

    /**
     * Vrátí URL pro stažení souboru s explicitní platností. Pro public bucket
     * je TTL ignorováno (vrátí přímou veřejnou URL).
     *
     * @param path object path souboru v úložišti
     * @param ttl  platnost signed URL (jen pro privátní bucket)
     * @return URL ke stažení
     */
    String getDownloadUrl(String path, Duration ttl);
}
