package com.checkfood.checkfoodservice.module.storage.dto;

import lombok.Builder;

@Builder
public record UploadResponse(String url, String filename) {
}
