package com.fourweekdays.fourweekdays.vendor.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.model.dto.response.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.service.VendorService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/vendors")
@RequiredArgsConstructor
public class VendorController {

    private final VendorService vendorService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> createVendor(@Valid @RequestBody VendorCreateDto dto) {
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

    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<Long>> updateVendor(@PathVariable Long id,
                                                           @Valid @RequestBody VendorUpdateDto dto) {
        vendorService.update(id, dto);
        return ResponseEntity.ok(BaseResponse.success(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<String>> deleteVendor(@PathVariable Long id) {
        vendorService.delete(id);
        return ResponseEntity.ok(BaseResponse.success("Deleted"));
    }
}
