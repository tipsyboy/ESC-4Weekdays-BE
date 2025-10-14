package com.fourweekdays.fourweekdays.vendor.service;

import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.response.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class VendorService {
    private final VendorRepository vendorRepository;

    public Long create(VendorCreateDto dto) {
        Vendor result = vendorRepository.save(dto.toEntity());
        return result.getId();
    }

    public VendorReadDto read(Long id) {
        Vendor entity = vendorRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("vendor를 찾을 수 없습니다."));
        return VendorReadDto.from(entity);
    }

    public List<VendorReadDto> readAll(Integer page, Integer size) {
        Page<Vendor> result = vendorRepository.findAll(PageRequest.of(page, size));
        return result.stream().map(VendorReadDto::from).toList();
    }

    public Long update(VendorUpdateDto dto) {
        Vendor result = vendorRepository.save(dto.toEntity());
        return result.getId();
    }

    public void delete(Long id) {
        vendorRepository.deleteById(id);
    }
}
