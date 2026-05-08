package com.fourweekdays.fourweekdays.location.dto;

import com.fourweekdays.fourweekdays.location.domain.Location;
import com.fourweekdays.fourweekdays.location.domain.LocationStatus;
import com.fourweekdays.fourweekdays.location.domain.LocationZoneType;

public record LocationResponse(
        Long id,
        String zone,
        String section,
        String locationCode,
        Long vendorId,
        Integer capacity,
        Integer currentUsage,
        Integer remainingCapacity,
        LocationStatus status,
        String description,
        String warehouseCode,
        String zoneCode,
        String rackCode,
        String levelCode,
        String displayName,
        LocationZoneType zoneType,
        Boolean usable
) {
    public static LocationResponse from(Location location) {
        return new LocationResponse(
                location.getId(),
                location.getZone(),
                location.getSection(),
                location.getLocationCode(),
                location.getVendorId(),
                location.getCapacity(),
                location.getUsedCapacity(),
                location.freeCapacity(),
                location.getStatus(),
                location.getDescription(),
                location.getWarehouseCode(),
                location.getZoneCode(),
                location.getRackCode(),
                location.getLevelCode(),
                location.getDisplayName(),
                location.getZoneType(),
                location.isUsable()
        );
    }
}
