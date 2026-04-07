package com.checkfood.checkfoodservice.module.storage.dto;

import lombok.Builder;

/**
 * Odpověď po úspěšném nahrání souboru obsahující veřejnou URL a název souboru.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Builder
public record UploadResponse(String url, String filename) {
}
