package com.checkfood.checkfoodservice.module.panorama.repository;

import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaPhoto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PanoramaPhotoRepository extends JpaRepository<PanoramaPhoto, UUID> {
    List<PanoramaPhoto> findAllBySessionIdOrderByAngleIndexAsc(UUID sessionId);
    int countBySessionId(UUID sessionId);
}
