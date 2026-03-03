package com.checkfood.checkfoodservice.module.storage.service;

public interface StorageService {
    String store(String directory, String filename, byte[] data, String contentType);
    void delete(String path);
    String getPublicUrl(String path);
}
