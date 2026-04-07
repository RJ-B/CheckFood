package com.checkfood.checkfoodservice.module.panorama.repository;

import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaPhoto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Repository pro přístup k fotografiím panoramatických session v databázi.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface PanoramaPhotoRepository extends JpaRepository<PanoramaPhoto, UUID> {

    /**
     * Vrátí všechny fotografie dané session seřazené podle indexu úhlu vzestupně.
     *
     * @param sessionId identifikátor session
     * @return seznam fotografií seřazených podle úhlu
     */
    List<PanoramaPhoto> findAllBySessionIdOrderByAngleIndexAsc(UUID sessionId);

    /**
     * Vrátí počet fotografií nahraných v dané session.
     *
     * @param sessionId identifikátor session
     * @return počet fotografií
     */
    int countBySessionId(UUID sessionId);
}
