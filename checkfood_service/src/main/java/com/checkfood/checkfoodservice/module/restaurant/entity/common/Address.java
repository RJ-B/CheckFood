package com.checkfood.checkfoodservice.module.restaurant.entity.common;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.PrecisionModel;

/**
 * Embeddable value object reprezentující fyzickou adresu s volitelnými geoprostorovými souřadnicemi PostGIS.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class Address {

    @Column(name = "street", length = 255)
    private String street;

    @Column(name = "street_number", length = 50)
    private String streetNumber;

    @Column(name = "city", length = 150)
    private String city;

    @Column(name = "postal_code", length = 50)
    private String postalCode;

    @Column(name = "country", length = 100)
    private String country;

    /**
     * Sloupec geometrie PostGIS s SRID 4326 (WGS 84 / GPS souřadnice).
     * Vyloučen z JSON serializace — místo toho použijte {@link #getLatitude()} a {@link #getLongitude()}.
     */
    @JsonIgnore
    @Column(columnDefinition = "geometry(Point,4326)")
    private Point location;

    @Column(name = "google_place_id", length = 255)
    private String googlePlaceId;

    /**
     * Vrátí zeměpisnou šířku extrahovanou z PostGIS Point.
     *
     * @return zeměpisná šířka v desetinných stupních, nebo {@code null} pokud není poloha nastavena
     */
    public Double getLatitude() {
        if (this.location != null) {
            return this.location.getY();
        }
        return null;
    }

    /**
     * Vrátí zeměpisnou délku extrahovanou z PostGIS Point.
     *
     * @return zeměpisná délka v desetinných stupních, nebo {@code null} pokud není poloha nastavena
     */
    public Double getLongitude() {
        if (this.location != null) {
            return this.location.getX();
        }
        return null;
    }

    /**
     * Vytvoří a nastaví PostGIS Point ze zadaných hodnot zeměpisné šířky a délky.
     * JTS používá pořadí (X=zeměpisná délka, Y=zeměpisná šířka).
     *
     * @param latitude  zeměpisná šířka v desetinných stupních
     * @param longitude zeměpisná délka v desetinných stupních
     */
    public void setCoordinates(double latitude, double longitude) {
        GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);
        this.location = geometryFactory.createPoint(new Coordinate(longitude, latitude));
    }
}