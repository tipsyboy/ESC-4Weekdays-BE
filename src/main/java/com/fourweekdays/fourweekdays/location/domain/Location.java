package com.fourweekdays.fourweekdays.location.domain;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.location.exception.LocationException;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static com.fourweekdays.fourweekdays.location.exception.LocationExceptionType.*;


@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Location extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 10)
    private String zone; // 01, 02, 03...

    @Column(nullable = false, length = 10)
    private String section; // A, B, C...

    @Column(nullable = false, unique = true, length = 20)
    private String locationCode; // 01-A, 01-B, 02-A...

    @Column(length = 50)
    private String warehouseCode;

    @Column(length = 50)
    private String zoneCode;

    @Column(length = 50)
    private String rackCode;

    @Column(length = 50)
    private String levelCode;

    @Column(length = 100)
    private String displayName;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private LocationZoneType zoneType;

    private Boolean usable;

    private Long vendorId;

    @Column(nullable = false)
    private Integer capacity;

    @Column(nullable = false)
    private Integer usedCapacity;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private LocationStatus status; // AVAILABLE, CLOSED

    @Column(length = 500)
    private String description; // 비고

    @Builder
    public Location(
            String zone,
            String section,
            String warehouseCode,
            String zoneCode,
            String rackCode,
            String levelCode,
            String locationCode,
            String displayName,
            LocationZoneType zoneType,
            Boolean usable,
            Long vendorId,
            Integer capacity,
            LocationStatus status,
            String description
    ) {
        this.zoneCode = zoneCode != null ? zoneCode : zone;
        this.rackCode = rackCode != null ? rackCode : section;
        this.levelCode = levelCode != null ? levelCode : "01";
        this.zone = zone != null ? zone : this.zoneCode;
        this.section = section != null ? section : this.rackCode;
        this.locationCode = locationCode != null ? locationCode : this.zone + "-" + this.section;
        this.warehouseCode = warehouseCode != null ? warehouseCode : "MAIN";
        this.displayName = displayName != null ? displayName : this.locationCode;
        this.zoneType = zoneType != null ? zoneType : LocationZoneType.STORAGE;
        this.usable = usable != null ? usable : status == null || status == LocationStatus.AVAILABLE;
        this.vendorId = vendorId;
        this.capacity = capacity != null ? capacity : 15000;
        this.usedCapacity = 0;
        this.status = status != null ? status : LocationStatus.AVAILABLE;
        this.description = description;
    }

    // ===== 비즈니스 로직 ===== //
    public boolean canLoad(int quantity) {
        return this.usedCapacity + quantity <= this.capacity;
    }

    public void increaseUsedCapacity(int quantity) {
        if (!canLoad(quantity)) {
            throw new LocationException(CAPACITY_EXCEEDED);
        }
        this.usedCapacity += quantity;
    }

    public void decreaseUsedCapacity(int quantity) {
        if (this.usedCapacity < quantity) {
            throw new LocationException(USED_CAPACITY_NEGATIVE);
        }
        this.usedCapacity -= quantity;
    }

    public boolean isAvailable() {
        return this.status == LocationStatus.AVAILABLE;
    }

    public boolean isUsable() {
        return Boolean.TRUE.equals(usable) && isAvailable();
    }

    public String getWarehouseCode() {
        return warehouseCode != null ? warehouseCode : "MAIN";
    }

    public String getZoneCode() {
        return zoneCode != null ? zoneCode : zone;
    }

    public String getRackCode() {
        return rackCode != null ? rackCode : section;
    }

    public String getLevelCode() {
        return levelCode != null ? levelCode : "01";
    }

    public String getDisplayName() {
        return displayName != null ? displayName : locationCode;
    }

    public LocationZoneType getZoneType() {
        return zoneType != null ? zoneType : LocationZoneType.STORAGE;
    }

    public int freeCapacity() {
        return this.capacity - this.usedCapacity;
    }

    public boolean isAssignedToVendor(Long vendorId) {
        return this.vendorId == null || this.vendorId.equals(vendorId);
    }

    public void validateForPutaway(Long vendorId, int quantity) {
//        if (!isAvailable()) {
//            throw new LocationException(LOCATION_NOT_AVAILABLE);
//        }
//        if (!isAssignedToVendor(vendorId)) {
//            throw new LocationException(LOCATION_VENDOR_MISMATCH);
//        }
//        if (!canLoad(quantity)) {
//            throw new LocationException(CAPACITY_EXCEEDED);
//        }
    }
}
