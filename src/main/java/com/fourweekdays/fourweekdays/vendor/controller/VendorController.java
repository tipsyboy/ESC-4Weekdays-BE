package com.fourweekdays.fourweekdays.vendor.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.response.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.service.VendorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/vendor")
@RequiredArgsConstructor
public class VendorController {
    private final VendorService vendorService;

    @GetMapping
    public ResponseEntity<BaseResponse<Long>> createVendor(VendorCreateDto dto) {
        Long result = vendorService.create(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<VendorReadDto>> readVendor(@PathVariable Long id) {
        VendorReadDto result = vendorService.read(id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping("/list")
    public ResponseEntity<BaseResponse<List<VendorReadDto>>> readAllVendors(Integer page, Integer size) {
        List<VendorReadDto> result = vendorService.readAll(page, size);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping("/update")
    public ResponseEntity<BaseResponse<Long>> updateVendor(VendorUpdateDto dto) {
        Long result = vendorService.update(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping("/delete")
    public ResponseEntity<BaseResponse<String>> deleteVendor(Long id) {
        vendorService.delete(id);
        return ResponseEntity.ok(BaseResponse.success("Deleted"));
    }
}
