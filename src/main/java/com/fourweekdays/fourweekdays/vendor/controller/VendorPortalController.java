package com.fourweekdays.fourweekdays.vendor.controller;

import com.fourweekdays.fourweekdays.asn.dto.AsnCreateRequest;
import com.fourweekdays.fourweekdays.asn.dto.AsnDetailResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnListResponse;
import com.fourweekdays.fourweekdays.asn.service.AsnService;
import com.fourweekdays.fourweekdays.auth.service.AuthAccessService;
import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.global.response.PageResponse;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderDetailResponse;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import com.fourweekdays.fourweekdays.vendor.dto.VendorPurchaseOrderPageResponse;
import com.fourweekdays.fourweekdays.vendor.service.VendorService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/vendor-portal")
@RequiredArgsConstructor
public class VendorPortalController {

    private final VendorService vendorService;
    private final PurchaseOrderService purchaseOrderService;
    private final AsnService asnService;
    private final AuthAccessService authAccessService;

    @GetMapping("/purchase-orders")
    public BaseResponse<VendorPurchaseOrderPageResponse> readPurchaseOrders(
            @RequestParam(required = false) Long vendorId,
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10") Integer size
    ) {
        Long targetVendorId = resolveVendorId(vendorId);
        return BaseResponse.success(vendorService.readVendorPortalPurchaseOrders(targetVendorId, page, size));
    }

    @GetMapping("/purchase-orders/{id}")
    public BaseResponse<PurchaseOrderDetailResponse> readPurchaseOrder(@PathVariable Long id) {
        return BaseResponse.success(purchaseOrderService.read(id));
    }

    @GetMapping("/purchase-orders/{purchaseOrderId}/asn")
    public BaseResponse<AsnDetailResponse> readAsnByPurchaseOrderId(@PathVariable Long purchaseOrderId) {
        return BaseResponse.success(asnService.readOptionalByPurchaseOrderId(purchaseOrderId));
    }

    @GetMapping("/asns")
    public BaseResponse<PageResponse<AsnListResponse>> readAsns(
            @RequestParam(required = false) Long vendorId,
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10") Integer size
    ) {
        Long targetVendorId = resolveVendorId(vendorId);
        return BaseResponse.success(PageResponse.from(vendorService.readAsns(targetVendorId, page, size)));
    }

    @PostMapping("/asns")
    @ResponseStatus(HttpStatus.CREATED)
    public BaseResponse<AsnDetailResponse> createAsn(@Valid @RequestBody AsnCreateRequest request) {
        return BaseResponse.success(asnService.create(request));
    }

    private Long resolveVendorId(Long requestedVendorId) {
        Long currentVendorId = authAccessService.currentVendorIdForVendorManagerOrNull();
        if (currentVendorId != null) {
            if (requestedVendorId != null && !currentVendorId.equals(requestedVendorId)) {
                throw new AccessDeniedException("해당 업체 데이터에 접근할 수 없습니다.");
            }
            return currentVendorId;
        }

        if (requestedVendorId == null) {
            throw new AccessDeniedException("조회할 공급업체를 선택하세요.");
        }

        return requestedVendorId;
    }
}
