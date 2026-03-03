package com.checkfood.checkfoodservice.module.restaurant.entity.common;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.PrecisionModel;

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
     * PostGIS Geometry sloupec.
     * SRID 4326 je standard pro GPS souřadnice (WGS 84).
     * @JsonIgnore zajistí, že se tento složitý objekt nebude posílat na frontend.
     */
    @JsonIgnore
    @Column(columnDefinition = "geometry(Point,4326)")
    private Point location;

    @Column(name = "google_place_id", length = 255)
    private String googlePlaceId;

    // --- Pomocné metody pro kompatibilitu s frontendem (JSON) ---

    /**
     * Virtuální getter pro Latitude (pro JSON).
     * Bere data přímo z Point objektu.
     */
    public Double getLatitude() {
        if (this.location != null) {
            return this.location.getY();
        }
        return null;
    }

    /**
     * Virtuální getter pro Longitude (pro JSON).
     * Bere data přímo z Point objektu.
     */
    public Double getLongitude() {
        if (this.location != null) {
            return this.location.getX();
        }
        return null;
    }

    /**
     * Setter, který při přijetí dat z JSONu (nebo DTO) vytvoří JTS Point.
     * Toto je nutné volat, pokud nastavuješ souřadnice ručně.
     */
    public void setCoordinates(double latitude, double longitude) {
        GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);
        // Pozor: JTS bere pořadí (X, Y) -> (Longitude, Latitude)
        this.location = geometryFactory.createPoint(new Coordinate(longitude, latitude));
    }
}