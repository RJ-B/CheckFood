package com.checkfood.checkfoodservice.module.storage.service;

/**
 * Rozhraní pro abstrakci souborového úložiště — ukládání, mazání a generování veřejných URL souborů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface StorageService {

    /**
     * Uloží soubor do zadaného adresáře úložiště.
     *
     * @param directory   název adresáře v úložišti
     * @param filename    název ukládaného souboru
     * @param data        binární obsah souboru
     * @param contentType MIME typ souboru
     * @return relativní cesta k uloženému souboru
     */
    String store(String directory, String filename, byte[] data, String contentType);

    /**
     * Smaže soubor na zadané cestě z úložiště.
     *
     * @param path relativní cesta k souboru v úložišti
     */
    void delete(String path);

    /**
     * Vrátí veřejnou URL pro přístup k souboru na zadané cestě.
     *
     * @param path relativní cesta k souboru v úložišti
     * @return veřejná URL souboru
     */
    String getPublicUrl(String path);
}
