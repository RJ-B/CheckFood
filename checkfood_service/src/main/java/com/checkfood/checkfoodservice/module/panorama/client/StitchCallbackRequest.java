package com.checkfood.checkfoodservice.module.panorama.client;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StitchCallbackRequest {

    @JsonProperty("session_id")
    private String sessionId;

    private String status; // COMPLETED | FAILED

    @JsonProperty("result_path")
    private String resultPath;

    @JsonProperty("error_message")
    private String errorMessage;
}
