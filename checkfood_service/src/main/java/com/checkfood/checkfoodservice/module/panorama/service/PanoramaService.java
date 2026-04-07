package com.checkfood.checkfoodservice.module.panorama.service;

import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaPhotoResponse;
import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaSessionResponse;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

/**
 * Rozhraní pro správu panoramatických session — nahrávání fotografií, spuštění stitchingu a správa výsledků.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface PanoramaService {

    /**
     * Vytvoří novou panoramatickou session pro restauraci přihlášeného majitele.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @return nově vytvořená session
     */
    PanoramaSessionResponse createSession(String userEmail);

    /**
     * Nahraje jednu fotografii do panoramatické session a uloží ji do úložiště.
     *
     * @param userEmail   e-mail přihlášeného majitele
     * @param sessionId   identifikátor session
     * @param angleIndex  index úhlu snímání
     * @param actualAngle skutečný horizontální úhel fotoaparátu
     * @param actualPitch skutečný vertikální úhel fotoaparátu (volitelný)
     * @param file        soubor fotografie
     * @return detail nahrané fotografie
     */
    PanoramaPhotoResponse uploadPhoto(String userEmail, UUID sessionId, int angleIndex, double actualAngle, Double actualPitch, MultipartFile file);

    /**
     * Finalizuje session a spustí asynchronní panoramatický stitching.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param sessionId identifikátor session
     * @return aktualizovaná session ve stavu PROCESSING
     */
    PanoramaSessionResponse finalizeSession(String userEmail, UUID sessionId);

    /**
     * Vrátí aktuální stav panoramatické session.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param sessionId identifikátor session
     * @return aktuální stav session
     */
    PanoramaSessionResponse getSessionStatus(String userEmail, UUID sessionId);

    /**
     * Vrátí seznam všech panoramatických session restaurace přihlášeného majitele.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @return seznam session seřazených od nejnovější
     */
    List<PanoramaSessionResponse> listSessions(String userEmail);

    /**
     * Nastaví dokončenou session jako aktivní panorama restaurace.
     *
     * @param userEmail e-mail přihlášeného majitele
     * @param sessionId identifikátor session ve stavu COMPLETED
     */
    void setActivePanorama(String userEmail, UUID sessionId);
}
