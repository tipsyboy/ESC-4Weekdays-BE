package com.fourweekdays.fourweekdays.vendor.controller;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnResponse;
import com.fourweekdays.fourweekdays.inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.product.dto.ProductListResponse;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorSearchCondition;
import com.fourweekdays.fourweekdays.vendor.dto.VendorStatusUpdateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.service.VendorService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/vendors")
@RequiredArgsConstructor
public class VendorController {

    private final VendorService vendorService;

    @PostMapping
    public ResponseEntity<BaseResponse<VendorReadDto>> createVendor(@Valid @RequestBody VendorCreateDto dto) {
        VendorReadDto result = vendorService.create(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<VendorReadDto>> readVendor(@PathVariable Long id) {
        VendorReadDto result = vendorService.read(id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping
    public ResponseEntity<BaseResponse<Page<VendorReadDto>>> readVendors(@ModelAttribute VendorSearchCondition condition) {
        Page<VendorReadDto> result = vendorService.readAll(condition);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    @GetMapping("/{id}/products")
    public ResponseEntity<BaseResponse<List<ProductListResponse>>> readVendorProducts(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(vendorService.readProducts(id)));
    }

    @GetMapping("/{id}/purchase-orders")
    public ResponseEntity<BaseResponse<List<PurchaseOrderReadDto>>> readVendorPurchaseOrders(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(vendorService.readPurchaseOrders(id)));
    }

    @GetMapping("/{id}/asns")
    public ResponseEntity<BaseResponse<Page<AsnResponse>>> readVendorAsns(@PathVariable Long id,
                                                                          @RequestParam(defaultValue = "0") Integer page,
                                                                          @RequestParam(defaultValue = "10") Integer size) {
        return ResponseEntity.ok(BaseResponse.success(vendorService.readAsns(id, page, size)));
    }

    @GetMapping("/{id}/inbounds")
    public ResponseEntity<BaseResponse<Page<InboundReadDto>>> readVendorInbounds(@PathVariable Long id,
                                                                                 @RequestParam(defaultValue = "0") Integer page,
                                                                                 @RequestParam(defaultValue = "10") Integer size) {
        return ResponseEntity.ok(BaseResponse.success(vendorService.readInbounds(id, page, size)));
    }

    // 내용 수정
    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<VendorReadDto>> updateVendor(@PathVariable Long id,
                                                                    @Valid @RequestBody VendorUpdateDto dto) {
        VendorReadDto result = vendorService.update(id, dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 상태 변경
    @PatchMapping("/{id}/status")
    public ResponseEntity<BaseResponse<VendorReadDto>> updateVendorStatus(@PathVariable Long id,
                                                                          @Valid @RequestBody VendorStatusUpdateDto dto) {
        VendorReadDto result = vendorService.updateStatus(id, dto.getStatus());
        return ResponseEntity.ok(BaseResponse.success(result));
    }
}
