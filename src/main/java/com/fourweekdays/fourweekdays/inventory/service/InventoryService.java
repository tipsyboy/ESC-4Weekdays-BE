package com.fourweekdays.fourweekdays.inventory.service;

import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import com.fourweekdays.fourweekdays.inbound.domain.InboundProduct;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.inventory.domain.Inventory;
import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;
import com.fourweekdays.fourweekdays.inventory.dto.InventoryDetailResponse;
import com.fourweekdays.fourweekdays.inventory.dto.InventoryListResponse;
import com.fourweekdays.fourweekdays.inventory.dto.InventoryMapLocationResponse;
import com.fourweekdays.fourweekdays.inventory.dto.InventorySearchCondition;
import com.fourweekdays.fourweekdays.inventory.exception.InventoryException;
import com.fourweekdays.fourweekdays.inventory.repository.InventoryRepository;
import com.fourweekdays.fourweekdays.location.domain.Location;
import com.fourweekdays.fourweekdays.location.exception.LocationException;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.inventory.exception.InventoryExceptionType.INVENTORY_NOT_FOUND;
import static com.fourweekdays.fourweekdays.location.exception.LocationExceptionType.LOCATION_NOT_FOUND;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class InventoryService {

    private static final String DEFAULT_LOT_NUMBER = "DEFAULT";

    private final InventoryRepository inventoryRepository;
    private final ProductRepository productRepository;
    private final LocationRepository locationRepository;
    private final InboundRepository inboundRepository;

    public List<InventoryListResponse> readAll(InventorySearchCondition condition) {
        return inventoryRepository.findAllByOrderByIdDesc()
                .stream()
                .filter(inventory -> matchesInventoryCondition(inventory, condition))
                .collect(Collectors.groupingBy(Inventory::getProduct))
                .entrySet()
                .stream()
                .map(entry -> InventoryListResponse.from(entry.getKey(), entry.getValue()))
                .filter(response -> matchesStatusCondition(response.status(), condition == null ? null : condition.status()))
                .sorted(Comparator.comparing(InventoryListResponse::productId).reversed())
                .toList();
    }

    public List<InventoryMapLocationResponse> readMap() {
        return inventoryRepository.findAllByOrderByIdDesc()
                .stream()
                .filter(inventory -> inventory.getQuantity() != null && inventory.getQuantity() > 0)
                .collect(Collectors.groupingBy(inventory -> inventory.getLocation().getLocationCode()))
                .values()
                .stream()
                .map(InventoryMapLocationResponse::from)
                .sorted(Comparator.comparing(InventoryMapLocationResponse::locationCode))
                .toList();
    }

    public InventoryDetailResponse read(Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        List<Inventory> inventories = inventoryRepository.findAllByProductIdOrderByIdDesc(productId);

        if (inventories.isEmpty()) {
            throw new InventoryException(INVENTORY_NOT_FOUND);
        }

        return InventoryDetailResponse.from(product, inventories);
    }

    @Transactional
    public void reflectInbound(Inbound inbound, LocalDateTime inboundAt) {
        for (InboundProduct item : inbound.getProducts()) {
            if (item.getReceivedQuantity() == null || item.getReceivedQuantity() <= 0) {
                continue;
            }
            reflectInboundProduct(inbound, item, inboundAt);
        }
    }

    @Transactional
    public void decreaseInventory(Long productId, Long locationId, String lotNumber, Integer quantity) {
        Inventory inventory = inventoryRepository.findByProductAndLocationAndLotWithLock(productId, locationId, normalizeLotNumber(lotNumber))
                .orElseThrow(() -> new InventoryException(INVENTORY_NOT_FOUND));

        inventory.decreaseQuantity(quantity);

        if (inventory.getQuantity() == 0) {
            inventoryRepository.delete(inventory);
        }
    }

    @Transactional
    public void createInventoryFromInbound(Long inboundId, String locationCode) {
        Inbound inbound = inboundRepository.findById(inboundId)
                .orElseThrow(() -> new InventoryException(INVENTORY_NOT_FOUND));

        Location location = locationRepository.findByLocationCodeWithLock(locationCode)
                .orElseThrow(() -> new LocationException(LOCATION_NOT_FOUND));

        for (InboundProduct item : inbound.getProducts()) {
            if (item.getReceivedQuantity() == null || item.getReceivedQuantity() <= 0) {
                continue;
            }

            String lotNumber = normalizeLotNumber(item.getLotNumber());
            Inventory inventory = inventoryRepository.findByProductAndLocationAndLotNumber(item.getProduct(), location, lotNumber)
                    .orElseGet(() -> Inventory.builder()
                            .product(item.getProduct())
                            .location(location)
                            .lotNumber(lotNumber)
                            .quantity(0)
                            .availableQuantity(0)
                            .holdQuantity(0)
                            .build());

            inventory.increase(item.getReceivedQuantity(), item.getDefectQuantity(), inbound, LocalDateTime.now());
            inventoryRepository.save(inventory);
        }
    }

    public int getTotalQuantityByProduct(Long productId) {
        return inventoryRepository.findByProductId(productId)
                .stream()
                .mapToInt(Inventory::getQuantity)
                .sum();
    }

    public int getTotalQuantityByLocation(Long locationId) {
        return inventoryRepository.findByLocationId(locationId)
                .stream()
                .mapToInt(Inventory::getQuantity)
                .sum();
    }

    private void reflectInboundProduct(Inbound inbound, InboundProduct item, LocalDateTime inboundAt) {
        Product product = item.getProduct();
        Location location = item.getLocation();

        if (location == null) {
            throw new LocationException(LOCATION_NOT_FOUND);
        }

        String lotNumber = normalizeLotNumber(item.getLotNumber());
        Inventory inventory = inventoryRepository.findByProductAndLocationAndLotNumber(product, location, lotNumber)
                .orElseGet(() -> Inventory.builder()
                        .product(product)
                        .location(location)
                        .lotNumber(lotNumber)
                        .quantity(0)
                        .availableQuantity(0)
                        .holdQuantity(0)
                        .build());

        inventory.increase(item.getReceivedQuantity(), item.getDefectQuantity(), inbound, inboundAt);
        inventoryRepository.save(inventory);
    }

    private boolean matchesInventoryCondition(Inventory inventory, InventorySearchCondition condition) {
        if (condition == null) {
            return true;
        }

        Product product = inventory.getProduct();
        boolean productCodeMatched = contains(product.getProductCode(), condition.productCode());
        boolean productNameMatched = contains(product.getName(), condition.productName());
        boolean locationMatched = contains(inventory.getLocation().getLocationCode(), condition.locationCode());
        boolean zoneMatched = contains(inventory.getLocation().getZoneCode(), condition.zoneCode());

        return productCodeMatched && productNameMatched && locationMatched && zoneMatched;
    }

    private boolean matchesStatusCondition(InventoryStatus actual, InventoryStatus expected) {
        return expected == null || actual == expected;
    }

    private boolean contains(String source, String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return true;
        }
        return String.valueOf(source).toLowerCase().contains(keyword.trim().toLowerCase());
    }

    private String normalizeLotNumber(String lotNumber) {
        return lotNumber == null || lotNumber.isBlank() ? DEFAULT_LOT_NUMBER : lotNumber;
    }
}
