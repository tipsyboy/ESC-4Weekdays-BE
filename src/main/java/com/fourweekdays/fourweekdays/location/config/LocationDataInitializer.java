package com.fourweekdays.fourweekdays.location.config;

import com.fourweekdays.fourweekdays.location.domain.Location;
import com.fourweekdays.fourweekdays.location.domain.LocationZoneType;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class LocationDataInitializer implements CommandLineRunner {

    private static final String DEFAULT_WAREHOUSE_CODE = "ICN_CENTER";
    private static final List<String> STORAGE_ZONES = List.of("A", "B", "C", "D", "E", "F", "G", "H");
    private static final List<String> WORK_ZONES = List.of("QA", "PACK");
    private static final int STORAGE_RACK_COUNT = 12;
    private static final int STORAGE_LEVEL_COUNT = 2;
    private static final int WORK_RACK_COUNT = 6;

    private final LocationRepository locationRepository;

    @Override
    public void run(String... args) {
        if (locationRepository.count() > 0) {
            return;
        }

        List<Location> locations = new ArrayList<>();

        for (String zoneCode : STORAGE_ZONES) {
            for (int rack = 1; rack <= STORAGE_RACK_COUNT; rack++) {
                for (int level = 1; level <= STORAGE_LEVEL_COUNT; level++) {
                    locations.add(build(zoneCode, rack, level, LocationZoneType.STORAGE, true));
                }
            }
        }

        for (String zoneCode : WORK_ZONES) {
            for (int rack = 1; rack <= WORK_RACK_COUNT; rack++) {
                locations.add(build(zoneCode, rack, 1, LocationZoneType.WORK, false));
            }
        }

        locationRepository.saveAll(locations);
    }

    private Location build(String zoneCode, int rack, int level, LocationZoneType zoneType, boolean usable) {
        String rackCode = pad(rack);
        String levelCode = pad(level);
        String locationCode = zoneCode + "-" + rackCode + "-" + levelCode;

        return Location.builder()
                .warehouseCode(DEFAULT_WAREHOUSE_CODE)
                .zoneCode(zoneCode)
                .rackCode(rackCode)
                .levelCode(levelCode)
                .locationCode(locationCode)
                .displayName(zoneCode + " Zone Rack " + rackCode + " Level " + levelCode)
                .zoneType(zoneType)
                .usable(usable)
                .build();
    }

    private String pad(int value) {
        return String.format("%02d", value);
    }
}
