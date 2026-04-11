package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * @JsonTest slice for {@link RestaurantResponse}.
 *
 * <p>The Apr 2026 ownerId refactor (A3) dropped {@code ownerId} from the
 * response contract. The mobile client still has a codegen'd
 * {@code restaurant_response_model.dart} that does NOT list an ownerId
 * field, so any regression that re-adds it here (e.g. someone wiring
 * up a different owner concept via the same field name) must be caught
 * at build time — a rebuild on the client side would then fail codegen.
 *
 * <p>These tests assert that:
 *   - the serialized JSON does NOT contain an {@code ownerId} key
 *   - all other fields round-trip correctly
 *   - the historical field name collision is impossible without a test
 *     failing here.
 */
@JsonTest
class RestaurantResponseJsonTest {

    @Autowired
    private JacksonTester<RestaurantResponse> json;

    private static final UUID RESTAURANT_ID =
            UUID.fromString("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");

    @Test
    @DisplayName("Serialized JSON does NOT contain legacy ownerId field")
    void doesNotExposeLegacyOwnerIdField() throws Exception {
        RestaurantResponse response = minimalResponse();

        var written = json.write(response);

        assertThat(written).doesNotHaveJsonPath("$.ownerId");
        assertThat(written).doesNotHaveJsonPath("$.owner_id");
        assertThat(written).doesNotHaveJsonPath("$.owner");
    }

    @Test
    @DisplayName("Round-trips id, name, status, rating as the client expects")
    void roundTripsCoreFields() throws Exception {
        RestaurantResponse response = minimalResponse();

        var written = json.write(response);

        assertThat(written).extractingJsonPathStringValue("$.id")
                .isEqualTo(RESTAURANT_ID.toString());
        assertThat(written).extractingJsonPathStringValue("$.name")
                .isEqualTo("Test Bistro");
        assertThat(written).extractingJsonPathStringValue("$.status")
                .isEqualTo(RestaurantStatus.ACTIVE.name());
        assertThat(written).extractingJsonPathBooleanValue("$.active").isTrue();
        assertThat(written).extractingJsonPathNumberValue("$.rating")
                .isEqualTo(4.5);
    }

    @Test
    @DisplayName("Boolean isFavourite is serialized as 'isFavourite', not 'favourite'")
    void favouriteFieldKeepsIsPrefix() throws Exception {
        // Jackson's default property namer strips the "is" prefix from
        // boolean getters on primitive booleans — but this field is
        // Boolean (nullable), so the raw property name wins. The mobile
        // client's JsonKey('isFavourite') depends on this. Asserted
        // explicitly so nobody "fixes" it back to primitive.
        RestaurantResponse response = minimalResponse();
        response.setIsFavourite(Boolean.TRUE);

        var written = json.write(response);

        assertThat(written).hasJsonPath("$.isFavourite");
        assertThat(written).extractingJsonPathBooleanValue("$.isFavourite").isTrue();
    }

    @Test
    @DisplayName("Deserializes a realistic server payload")
    void deserializesRealisticPayload() throws Exception {
        String payload = """
            {
              "id": "%s",
              "name": "Test Bistro",
              "description": "desc",
              "cuisineType": "ITALIAN",
              "status": "ACTIVE",
              "active": true,
              "rating": 4.5,
              "onboardingCompleted": true,
              "defaultReservationDurationMinutes": 90,
              "minAdvanceMinutes": 60,
              "minReservationDurationMinutes": 30,
              "maxReservationDurationMinutes": 240,
              "reservationSlotIntervalMinutes": 15,
              "gallery": [],
              "openingHours": [],
              "tags": [],
              "specialDays": []
            }
            """.formatted(RESTAURANT_ID);

        RestaurantResponse parsed = json.parseObject(payload);

        assertThat(parsed.getId()).isEqualTo(RESTAURANT_ID);
        assertThat(parsed.getCuisineType()).isEqualTo(CuisineType.ITALIAN);
        assertThat(parsed.getStatus()).isEqualTo(RestaurantStatus.ACTIVE);
        assertThat(parsed.isActive()).isTrue();
    }

    private RestaurantResponse minimalResponse() {
        return RestaurantResponse.builder()
                .id(RESTAURANT_ID)
                .name("Test Bistro")
                .description("desc")
                .cuisineType(CuisineType.ITALIAN)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .rating(new BigDecimal("4.5"))
                .gallery(List.of())
                .openingHours(List.of())
                .specialDays(List.of())
                .onboardingCompleted(true)
                .defaultReservationDurationMinutes(90)
                .minAdvanceMinutes(60)
                .minReservationDurationMinutes(30)
                .maxReservationDurationMinutes(240)
                .reservationSlotIntervalMinutes(15)
                .build();
    }
}
