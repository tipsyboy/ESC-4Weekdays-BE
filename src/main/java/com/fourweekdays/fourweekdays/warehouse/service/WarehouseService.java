package com.fourweekdays.fourweekdays.warehouse.service;

import com.fourweekdays.fourweekdays.warehouse.model.dto.request.WarehouseCreateDto;
import com.fourweekdays.fourweekdays.warehouse.model.entity.Warehouse;
import com.fourweekdays.fourweekdays.warehouse.repository.WarehouseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class WarehouseService {

    private final WarehouseRepository warehouseRepository;

    public Long create(WarehouseCreateDto dto) {
        Warehouse result = warehouseRepository.save(dto.toEntity());
        return result.getId();
    }
}
