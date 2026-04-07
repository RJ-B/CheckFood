package com.checkfood.checkfoodservice.module.restaurant.dto.common;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro přenos dat adresy mezi klientem a serverem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AddressDto {
    @NotBlank(message = "Ulice je povinná")
    private String street;
    private String streetNumber;
    @NotBlank(message = "Město je povinné")
    private String city;
    private String postalCode;
    private String country;
    private Double latitude;
    private Double longitude;
    private String googlePlaceId;
}