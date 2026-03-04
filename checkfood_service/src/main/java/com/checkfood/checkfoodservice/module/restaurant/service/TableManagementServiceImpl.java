package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.TableGroup;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.logging.RestaurantLogger;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantTableMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.TableGroupRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class TableManagementServiceImpl implements TableManagementService {

    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository tableRepository;
    private final TableGroupRepository groupRepository;
    private final RestaurantTableMapper tableMapper;
    private final RestaurantLogger restaurantLogger;

    @Override
    public RestaurantTableResponse addTable(UUID restaurantId, RestaurantTableRequest request, UUID ownerId) {
        validateRestaurantOwnership(restaurantId, ownerId);

        var table = tableMapper.toEntity(request);
        table.setRestaurantId(restaurantId);
        table.setActive(true);

        var saved = tableRepository.save(table);
        restaurantLogger.logTableAdded(restaurantId, saved.getLabel());

        return tableMapper.toResponse(saved);
    }

    @Override
    public RestaurantTableResponse updateTable(UUID tableId, RestaurantTableRequest request, UUID ownerId) {
        var table = tableRepository.findById(tableId)
                .orElseThrow(() -> RestaurantException.tableNotFound(tableId));

        validateRestaurantOwnership(table.getRestaurantId(), ownerId);

        table.setLabel(request.getLabel());
        table.setCapacity(request.getCapacity());
        table.setActive(request.isActive());
        table.setYaw(request.getYaw());
        table.setPitch(request.getPitch());

        return tableMapper.toResponse(tableRepository.save(table));
    }

    @Override
    public UUID createTableGroup(UUID restaurantId, List<UUID> tableIds, String label) {
        List<RestaurantTable> tables = tableRepository.findAllById(tableIds);

        if (tables.size() != tableIds.size()) {
            throw RestaurantException.systemError("Některé stoly nebyly v systému nalezeny.");
        }

        checkTablesAvailability(tableIds, restaurantId);

        var group = TableGroup.builder()
                .restaurantId(restaurantId)
                .label(label)
                .active(true)
                .build();

        tableIds.forEach(group::addTable);
        var savedGroup = groupRepository.save(group);

        restaurantLogger.logTableGroupCreated(restaurantId, savedGroup.getId());

        return savedGroup.getId();
    }

    @Override
    public void closeTableGroup(UUID groupId) {
        var group = groupRepository.findById(groupId)
                .orElseThrow(() -> RestaurantException.systemError("Pokus o ukončení neexistujícího sezení."));

        group.setActive(false);
        group.setClosedAt(OffsetDateTime.now());
        groupRepository.save(group);
    }

    // --- Privátní pomocné metody ---

    private void validateRestaurantOwnership(UUID restaurantId, UUID ownerId) {
        if (!restaurantRepository.existsByIdAndOwnerId(restaurantId, ownerId)) {
            throw RestaurantException.accessDenied();
        }
    }

    private void checkTablesAvailability(List<UUID> tableIds, UUID restaurantId) {
        var activeGroups = groupRepository.findAllByRestaurantIdAndActiveTrue(restaurantId);

        boolean isAnyTableOccupied = activeGroups.stream()
                .flatMap(g -> g.getItems().stream())
                .anyMatch(item -> tableIds.contains(item.getTableId()));

        if (isAnyTableOccupied) {
            // Použijeme specifickou výjimku bez generického textu
            throw RestaurantException.tableOccupied("Jeden nebo více vybraných stolů je již obsazeno.");
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<RestaurantTableResponse> getTablesByRestaurant(UUID restaurantId) {
        return tableRepository.findAllByRestaurantId(restaurantId).stream()
                .map(tableMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteTable(UUID tableId, UUID ownerId) {
        var table = tableRepository.findById(tableId)
                .orElseThrow(() -> RestaurantException.tableNotFound(tableId));

        validateRestaurantOwnership(table.getRestaurantId(), ownerId);

        table.setActive(false);
        tableRepository.save(table);
    }
}