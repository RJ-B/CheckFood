package com.checkfood.checkfoodservice.module.panorama.entity;

/**
 * Stav session panoramatického snímkování — od nahrávání fotografií až po dokončení nebo selhání.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum PanoramaSessionStatus {
    UPLOADING, PROCESSING, COMPLETED, FAILED
}
