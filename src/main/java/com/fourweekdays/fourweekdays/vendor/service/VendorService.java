package com.fourweekdays.fourweekdays.vendor.service;

import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.response.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Service
@RequiredArgsConstructor
public class VendorService {
    private final VendorRepository vendorRepository;

    @Transactional
    public Long create(VendorCreateDto dto) {
        Vendor result = vendorRepository.save(dto.toEntity());
        // TODO: Vendor Code 자동 생성
//        generateVendorCode();

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

    @Transactional
    public void update(Long id, VendorUpdateDto dto) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        vendor.update(dto.getName(), dto.getPhoneNumber(), dto.getEmail(),
                dto.getDescription(), dto.getStatus(), dto.getAddress());
    }

    public void delete(Long id) {
        vendorRepository.deleteById(id);
    }

    private String generateVendorCode() {
        return null;
    }
}
