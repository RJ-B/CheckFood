package com.checkfood.checkfoodservice.module.order.dto.request;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.json.JsonTest;
import org.springframework.boot.test.json.JacksonTester;

import java.util.List;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * @JsonTest slice for {@link CreateOrderRequest}.
 *
 * <p>Pins the wire format that the Flutter client sends. The mobile side
 * previously had a bug where {@code @JsonSerializable} was missing
 * {@code explicitToJson: true}, so nested {@code items} were stringified
 * as Dart object literals (e.g. {@code "Instance of 'OrderItemRequestModel'"}),
 * which then failed Jackson deserialization here with a mysterious 400.
 *
 * <p>These tests don't cover the Flutter fix directly (that lives in the
 * client repo), but they lock in the exact shape the server accepts so any
 * future server-side DTO reshuffle (e.g. renaming {@code items} to
 * {@code lineItems}) is caught by a build break rather than by a user
 * report that their order button is broken.
 */
@JsonTest
class CreateOrderRequestJsonTest {

    @Autowired
    private JacksonTester<CreateOrderRequest> json;

    private static final UUID ITEM_ID = UUID.fromString("11111111-1111-1111-1111-111111111111");

    @Test
    @DisplayName("Deserializes a minimal valid payload with one item")
    void deserializesMinimalPayload() throws Exception {
        String payload = """
            {
              "items": [
                { "menuItemId": "%s", "quantity": 2 }
              ]
            }
            """.formatted(ITEM_ID);

        CreateOrderRequest parsed = json.parseObject(payload);

        assertThat(parsed.getItems()).hasSize(1);
        assertThat(parsed.getItems().get(0).getMenuItemId()).isEqualTo(ITEM_ID);
        assertThat(parsed.getItems().get(0).getQuantity()).isEqualTo(2);
        assertThat(parsed.getNote()).isNull();
    }

    @Test
    @DisplayName("Deserializes a payload with optional note field")
    void deserializesWithNote() throws Exception {
        String payload = """
            {
              "items": [
                { "menuItemId": "%s", "quantity": 1 }
              ],
              "note": "Bez cibule, prosím"
            }
            """.formatted(ITEM_ID);

        CreateOrderRequest parsed = json.parseObject(payload);

        assertThat(parsed.getNote()).isEqualTo("Bez cibule, prosím");
    }

    @Test
    @DisplayName("Deserializes multi-item payloads in order")
    void deserializesMultipleItems() throws Exception {
        UUID second = UUID.fromString("22222222-2222-2222-2222-222222222222");
        String payload = """
            {
              "items": [
                { "menuItemId": "%s", "quantity": 1 },
                { "menuItemId": "%s", "quantity": 3 }
              ]
            }
            """.formatted(ITEM_ID, second);

        CreateOrderRequest parsed = json.parseObject(payload);

        assertThat(parsed.getItems())
                .extracting(OrderItemRequest::getMenuItemId, OrderItemRequest::getQuantity)
                .containsExactly(
                        org.assertj.core.groups.Tuple.tuple(ITEM_ID, 1),
                        org.assertj.core.groups.Tuple.tuple(second, 3)
                );
    }

    @Test
    @DisplayName("Serializes to the exact shape the Flutter client sends")
    void serializesToExpectedShape() throws Exception {
        CreateOrderRequest request = CreateOrderRequest.builder()
                .items(List.of(
                        OrderItemRequest.builder()
                                .menuItemId(ITEM_ID)
                                .quantity(2)
                                .build()
                ))
                .note("test")
                .build();

        var written = json.write(request);

        // Nested objects must be FULL objects, not stringified — this is
        // the Flutter explicitToJson bug, asserted in reverse from the
        // server side.
        assertThat(written).hasJsonPath("$.items[0].menuItemId");
        assertThat(written).hasJsonPath("$.items[0].quantity");
        assertThat(written).extractingJsonPathStringValue("$.items[0].menuItemId")
                .isEqualTo(ITEM_ID.toString());
        assertThat(written).extractingJsonPathNumberValue("$.items[0].quantity")
                .isEqualTo(2);
        assertThat(written).extractingJsonPathStringValue("$.note").isEqualTo("test");
    }

    @Test
    @DisplayName("Unknown top-level fields are ignored (mass-assignment defence)")
    void ignoresUnknownFields() throws Exception {
        String payload = """
            {
              "items": [ { "menuItemId": "%s", "quantity": 1 } ],
              "adminBypass": true,
              "discount": 9999,
              "userId": 42
            }
            """.formatted(ITEM_ID);

        // Spring Boot's default Jackson config has FAIL_ON_UNKNOWN_PROPERTIES=false.
        // This test documents that stance: attacker extras are silently dropped,
        // so nothing gets assigned to a phantom field and the parse still succeeds.
        CreateOrderRequest parsed = json.parseObject(payload);
        assertThat(parsed.getItems()).hasSize(1);
    }
}
