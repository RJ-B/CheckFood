package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.MembershipStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.BaseAuthIntegrationTest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;

import java.util.EnumSet;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Integration tests for MyRestaurantController — full matrix for CRUD, employee management,
 * authorization, validation, 404, and conflict scenarios.
 */
@Transactional
class MyRestaurantControllerIntegrationTest extends BaseAuthIntegrationTest {

    private static final String OWNER_EMAIL   = "myrest-owner@checkfood.test";
    private static final String MANAGER_EMAIL = "myrest-manager@checkfood.test";
    private static final String STAFF_EMAIL   = "myrest-staff@checkfood.test";
    private static final String USER_EMAIL    = "myrest-user@checkfood.test";

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private RestaurantEmployeeRepository employeeRepository;

    @BeforeEach
    void ensureRoles() {
        ensureRole("OWNER");
        ensureRole("MANAGER");
        ensureRole("STAFF");
    }

    // =========================================================================
    // GET /api/my-restaurant
    // =========================================================================

    @Nested
    @DisplayName("GET /api/my-restaurant")
    class GetMyRestaurant {

        @Test
        @DisplayName("OWNER with assigned restaurant gets 200 with body")
        void should_return200_when_ownerHasRestaurant() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "My Bistro");

            mockMvc.perform(get("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value("My Bistro"));
        }

        @Test
        @DisplayName("404 when owner has no restaurant assigned")
        void should_return404_when_noRestaurantAssigned() throws Exception {
            String token = getTokenWithRole(OWNER_EMAIL, "OWNER", "device-owner-norestaur");

            mockMvc.perform(get("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("401 when unauthenticated")
        void should_return401_when_anonymous() throws Exception {
            mockMvc.perform(get("/api/my-restaurant"))
                    .andExpect(status().isUnauthorized());
        }

        @Test
        @DisplayName("403 when regular USER role")
        void should_return403_when_regularUser() throws Exception {
            String token = getAccessToken(USER_EMAIL, TEST_PASSWORD, "device-user-get");

            mockMvc.perform(get("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // GET /api/my-restaurant/list
    // =========================================================================

    @Nested
    @DisplayName("GET /api/my-restaurant/list")
    class GetMyRestaurantList {

        @Test
        @DisplayName("OWNER gets list of their restaurants")
        void should_returnList_when_ownerAuthenticated() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "List Bistro");

            mockMvc.perform(get("/api/my-restaurant/list")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$[0].name").value("List Bistro"));
        }
    }

    // =========================================================================
    // PUT /api/my-restaurant
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/my-restaurant")
    class UpdateMyRestaurant {

        @Test
        @DisplayName("happy path — OWNER with EDIT_RESTAURANT_INFO can update")
        void should_return200_when_ownerUpdates() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Original Name");

            String updateJson = """
                    {"name":"Updated Name","address":{"street":"New Street","city":"Brno"}}
                    """;

            mockMvc.perform(put("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(updateJson))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.name").value("Updated Name"));
        }

        @Test
        @DisplayName("400 when name is blank")
        void should_return400_when_nameIsBlank() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Blank Test");

            mockMvc.perform(put("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when email field is invalid format")
        void should_return400_when_emailInvalid() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Email Test");

            String json = """
                    {"name":"Valid Name","email":"not-an-email"}
                    """;

            mockMvc.perform(put("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when defaultReservationDurationMinutes below 15")
        void should_return400_when_reservationDurationTooShort() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Duration Test");

            String json = """
                    {"name":"Valid Name","defaultReservationDurationMinutes":14}
                    """;

            mockMvc.perform(put("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when minAdvanceMinutes is negative")
        void should_return400_when_minAdvanceMinutesNegative() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "MinAdv Test");

            String json = """
                    {"name":"Valid Name","minAdvanceMinutes":-1}
                    """;

            mockMvc.perform(put("/api/my-restaurant")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("STAFF role cannot update (403) — lacks EDIT_RESTAURANT_INFO permission")
        void should_return403_when_staffTriesUpdate() throws Exception {
            String ownerToken = buildOwnerWithRestaurant(OWNER_EMAIL, "Staff Test");
            // Staff member only has VIEW_RESTAURANT_INFO by default
            String staffToken = buildStaffForOwner(STAFF_EMAIL, OWNER_EMAIL);

            mockMvc.perform(put("/api/my-restaurant")
                            .header("Authorization", "Bearer " + staffToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"name\":\"Hijacked\"}"))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // POST /api/my-restaurant/employees
    // =========================================================================

    @Nested
    @DisplayName("POST /api/my-restaurant/employees")
    class AddEmployee {

        @Test
        @DisplayName("OWNER can add employee, gets 201")
        void should_return201_when_ownerAddsEmployee() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Employee Test");
            // Create the user to be added
            createVerifiedUser(USER_EMAIL, TEST_PASSWORD, "Emp", "User");

            String json = """
                    {"email":"%s","role":"MANAGER"}
                    """.formatted(USER_EMAIL);

            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.role").value("MANAGER"));
        }

        @Test
        @DisplayName("400 when email is blank")
        void should_return400_when_emailIsBlank() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Employee Val Test");

            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"\",\"role\":\"MANAGER\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when email has invalid format")
        void should_return400_when_emailInvalid() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Employee Email Val");

            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"notanemail\",\"role\":\"MANAGER\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when role is null")
        void should_return400_when_roleIsNull() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Employee Role Val");

            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"emp@test.com\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("400 when trying to add OWNER role (forbidden)")
        void should_return400_when_addingOwnerRole() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Owner Role Test");
            createVerifiedUser(USER_EMAIL, TEST_PASSWORD, "Emp", "User");

            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"" + USER_EMAIL + "\",\"role\":\"OWNER\"}"))
                    .andExpect(status().isBadRequest());
        }

        @Test
        @DisplayName("409 conflict when employee already exists")
        void should_return409_when_employeeAlreadyExists() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Duplicate Emp Test");
            createVerifiedUser(USER_EMAIL, TEST_PASSWORD, "Emp", "User");

            String json = """
                    {"email":"%s","role":"MANAGER"}
                    """.formatted(USER_EMAIL);

            // Add once
            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isCreated());

            // Add again — must be 409
            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isConflict());
        }

        @Test
        @DisplayName("403 when MANAGER tries to add employee (only OWNER can)")
        void should_return403_when_managerAddsEmployee() throws Exception {
            String ownerToken = buildOwnerWithRestaurant(OWNER_EMAIL, "Manager Add Test");
            String managerToken = buildManagerForOwner(MANAGER_EMAIL, OWNER_EMAIL);

            mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + managerToken)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"new@user.com\",\"role\":\"STAFF\"}"))
                    .andExpect(status().isForbidden());
        }
    }

    // =========================================================================
    // DELETE /api/my-restaurant/employees/{id}
    // =========================================================================

    @Nested
    @DisplayName("DELETE /api/my-restaurant/employees/{id}")
    class RemoveEmployee {

        @Test
        @DisplayName("OWNER can remove employee")
        void should_return204_when_ownerRemovesEmployee() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Remove Test");
            createVerifiedUser(USER_EMAIL, TEST_PASSWORD, "Emp", "User");

            // Add employee
            MvcResult addResult = mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"" + USER_EMAIL + "\",\"role\":\"STAFF\"}"))
                    .andExpect(status().isCreated())
                    .andReturn();

            JsonNode body = objectMapper.readTree(addResult.getResponse().getContentAsString());
            long employeeId = body.get("id").asLong();

            mockMvc.perform(delete("/api/my-restaurant/employees/" + employeeId)
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNoContent());
        }

        @Test
        @DisplayName("404 when employee does not exist")
        void should_return404_when_employeeNotFound() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Remove 404 Test");

            mockMvc.perform(delete("/api/my-restaurant/employees/99999999")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isNotFound());
        }

        @Test
        @DisplayName("400 when trying to remove the OWNER (self-removal protection)")
        void should_return400_when_removingOwner() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Self Remove Test");
            // Find owner's employee record
            var user = userRepository.findByEmail(OWNER_EMAIL).orElseThrow();
            var ownerMembership = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER).orElseThrow();

            mockMvc.perform(delete("/api/my-restaurant/employees/" + ownerMembership.getId())
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isBadRequest());
        }
    }

    // =========================================================================
    // PUT /api/my-restaurant/employees/{id}
    // =========================================================================

    @Nested
    @DisplayName("PUT /api/my-restaurant/employees/{id}")
    class UpdateEmployeeRole {

        @Test
        @DisplayName("OWNER can update employee role")
        void should_return200_when_ownerUpdatesRole() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Role Update Test");
            createVerifiedUser(USER_EMAIL, TEST_PASSWORD, "Emp", "User");

            MvcResult addResult = mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"" + USER_EMAIL + "\",\"role\":\"STAFF\"}"))
                    .andExpect(status().isCreated())
                    .andReturn();

            long empId = objectMapper.readTree(addResult.getResponse().getContentAsString()).get("id").asLong();

            mockMvc.perform(put("/api/my-restaurant/employees/" + empId)
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"role\":\"MANAGER\"}"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.role").value("MANAGER"));
        }

        @Test
        @DisplayName("400 when trying to assign OWNER role to employee")
        void should_return400_when_assigningOwnerRole() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Owner Role Assign Test");
            createVerifiedUser(USER_EMAIL, TEST_PASSWORD, "Emp", "User");

            MvcResult addResult = mockMvc.perform(post("/api/my-restaurant/employees")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"email\":\"" + USER_EMAIL + "\",\"role\":\"STAFF\"}"))
                    .andExpect(status().isCreated())
                    .andReturn();

            long empId = objectMapper.readTree(addResult.getResponse().getContentAsString()).get("id").asLong();

            mockMvc.perform(put("/api/my-restaurant/employees/" + empId)
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{\"role\":\"OWNER\"}"))
                    .andExpect(status().isBadRequest());
        }
    }

    // =========================================================================
    // GET + PUT /api/my-restaurant/special-days
    // =========================================================================

    @Nested
    @DisplayName("GET + PUT /api/my-restaurant/special-days")
    class SpecialDays {

        @Test
        @DisplayName("OWNER can retrieve empty special days list")
        void should_returnEmptyList_when_noSpecialDays() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Special Days Test");

            mockMvc.perform(get("/api/my-restaurant/special-days")
                            .header("Authorization", "Bearer " + token))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$").isArray());
        }

        @Test
        @DisplayName("OWNER can set special days")
        void should_return200_when_specialDaysUpdated() throws Exception {
            String token = buildOwnerWithRestaurant(OWNER_EMAIL, "Special Days Update Test");

            String json = """
                    [{"date":"2025-12-24","closed":true,"note":"Christmas Eve"}]
                    """;

            mockMvc.perform(put("/api/my-restaurant/special-days")
                            .header("Authorization", "Bearer " + token)
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(json))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$").isArray())
                    .andExpect(jsonPath("$[0].closed").value(true));
        }
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    /**
     * Creates a verified owner user, assigns OWNER role, persists a restaurant,
     * and creates the employee membership. Returns the owner's JWT token.
     */
    private String buildOwnerWithRestaurant(String email, String restaurantName) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName("OWNER").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);

        Restaurant restaurant = restaurantRepository.save(Restaurant.builder()
                .name(restaurantName)
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Testovací")
                        .streetNumber("1")
                        .city("Praha")
                        .postalCode("11000")
                        .country("CZ")
                        .build())
                .build());

        RestaurantEmployee ownership = RestaurantEmployee.builder()
                .user(user)
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EmployeePermission.defaultsForRole(RestaurantEmployeeRole.OWNER))
                .build();
        employeeRepository.save(ownership);

        return loginAndGetToken(email, "device-" + email.hashCode());
    }

    /**
     * Creates a MANAGER user and attaches them to the owner's restaurant.
     */
    private String buildManagerForOwner(String managerEmail, String ownerEmail) throws Exception {
        createVerifiedUser(managerEmail, TEST_PASSWORD, "Manager", "User");
        var manager = userRepository.findByEmail(managerEmail).orElseThrow();
        var managerRole = roleRepository.findByName("MANAGER").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(manager.getRoles());
        roles.add(managerRole);
        manager.setRoles(roles);
        userRepository.saveAndFlush(manager);

        var owner = userRepository.findByEmail(ownerEmail).orElseThrow();
        var ownerMembership = employeeRepository.findFirstByUserIdAndRole(owner.getId(), RestaurantEmployeeRole.OWNER).orElseThrow();

        RestaurantEmployee emp = RestaurantEmployee.builder()
                .user(manager)
                .restaurant(ownerMembership.getRestaurant())
                .role(RestaurantEmployeeRole.MANAGER)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EmployeePermission.defaultsForRole(RestaurantEmployeeRole.MANAGER))
                .build();
        employeeRepository.save(emp);

        return loginAndGetToken(managerEmail, "device-mgr-" + managerEmail.hashCode());
    }

    /**
     * Creates a STAFF user and attaches them to the owner's restaurant.
     */
    private String buildStaffForOwner(String staffEmail, String ownerEmail) throws Exception {
        createVerifiedUser(staffEmail, TEST_PASSWORD, "Staff", "User");
        var staff = userRepository.findByEmail(staffEmail).orElseThrow();
        var staffRole = roleRepository.findByName("STAFF").orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(staff.getRoles());
        roles.add(staffRole);
        staff.setRoles(roles);
        userRepository.saveAndFlush(staff);

        var owner = userRepository.findByEmail(ownerEmail).orElseThrow();
        var ownerMembership = employeeRepository.findFirstByUserIdAndRole(owner.getId(), RestaurantEmployeeRole.OWNER).orElseThrow();

        RestaurantEmployee emp = RestaurantEmployee.builder()
                .user(staff)
                .restaurant(ownerMembership.getRestaurant())
                .role(RestaurantEmployeeRole.STAFF)
                .membershipStatus(MembershipStatus.ACTIVE)
                .permissions(EmployeePermission.defaultsForRole(RestaurantEmployeeRole.STAFF))
                .build();
        employeeRepository.save(emp);

        return loginAndGetToken(staffEmail, "device-staff-" + staffEmail.hashCode());
    }

    private String loginAndGetToken(String email, String deviceId) throws Exception {
        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(
                                LoginRequest.builder()
                                        .email(email)
                                        .password(TEST_PASSWORD)
                                        .deviceIdentifier(deviceId)
                                        .deviceName(TEST_DEVICE_NAME)
                                        .deviceType(TEST_DEVICE_TYPE)
                                        .build())))
                .andExpect(status().isOk())
                .andReturn();

        JsonNode body = objectMapper.readTree(loginResult.getResponse().getContentAsString());
        return body.get("accessToken").asText();
    }

    private String getTokenWithRole(String email, String roleName, String deviceId) throws Exception {
        createVerifiedUser(email, TEST_PASSWORD, TEST_FIRST_NAME, TEST_LAST_NAME);
        var user = userRepository.findByEmail(email).orElseThrow();
        var role = roleRepository.findByName(roleName).orElseThrow();
        Set<RoleEntity> roles = new HashSet<>(user.getRoles());
        roles.add(role);
        user.setRoles(roles);
        userRepository.saveAndFlush(user);
        return loginAndGetToken(email, deviceId);
    }

    private void ensureRole(String roleName) {
        roleRepository.findByName(roleName).orElseGet(() -> {
            RoleEntity r = new RoleEntity();
            r.setName(roleName);
            return roleRepository.save(r);
        });
    }
}
