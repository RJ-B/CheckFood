package com.checkfood.checkfoodservice.application.entity.common;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class Address {

    @Column(length = 150)
    private String street;

    @Column(length = 20)
    private String streetNumber;

    @Column(length = 100)
    private String city;

    @Column(length = 20)
    private String postalCode;

    @Column(length = 100)
    private String country;

    /**
     * Zeměpisná šířka (Google Maps).
     */
    private Double latitude;

    /**
     * Zeměpisná délka (Google Maps).
     */
    private Double longitude;

    /**
     * Google Places ID – pro synchronizaci.
     */
    @Column(length = 100)
    private String googlePlaceId;
}
