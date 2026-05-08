package com.fourweekdays.fourweekdays.vendor.service;

import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.global.response.PageResponse;
import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.auth.service.AuthAccessService;
import com.fourweekdays.fourweekdays.asn.dto.AsnListResponse;
import com.fourweekdays.fourweekdays.asn.repository.AsnRepository;
import com.fourweekdays.fourweekdays.inbound.dto.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.product.dto.ProductListResponse;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderListResponse;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.dto.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorSearchCondition;
import com.fourweekdays.fourweekdays.vendor.dto.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorPurchaseOrderListResponse;
import com.fourweekdays.fourweekdays.vendor.dto.VendorPurchaseOrderPageResponse;
import com.fourweekdays.fourweekdays.vendor.dto.VendorPurchaseOrderSummaryResponse;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class VendorService {

    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final AsnRepository asnRepository;
    private final InboundRepository inboundRepository;
    private final CodeGenerator codeGenerator;
    private final AuthAccessService authAccessService;

    @Transactional
    public VendorReadDto create(VendorCreateDto dto) {
        Vendor result = vendorRepository.save(dto.toEntity(codeGenerator.generate(CodeType.VENDOR)));

        return VendorReadDto.from(result);
    }

    public VendorReadDto read(Long id) {
        authAccessService.assertVendorScope(id);
        Vendor entity = vendorRepository.findById(id)
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));
        return VendorReadDto.from(entity);
    }

    public Page<VendorReadDto> readAll(VendorSearchCondition condition) {
        Sort.Direction direction = "asc".equalsIgnoreCase(condition.sortDirectionOrDefault()) ? Sort.Direction.ASC : Sort.Direction.DESC;
        Pageable pageable = PageRequest.of(
                condition.pageOrDefault(),
                condition.sizeOrDefault(),
                Sort.by(direction, condition.sortByOrDefault())
        );
        Page<Vendor> vendors = vendorRepository.search(pageable, condition);
        return vendors.map(VendorReadDto::from);
    }

    // 내용 수정
    @Transactional
    public VendorReadDto update(Long id, VendorUpdateDto dto) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        vendor.update(dto.getName(), dto.getManagerName(), dto.getPhoneNumber(), dto.getEmail(),
                dto.getDescription(), dto.getAddress());
        return VendorReadDto.from(vendor);
    }

    // 상태 변경
    @Transactional
    public VendorReadDto updateStatus(Long id, VendorStatus status) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        vendor.changeStatus(status);
        return VendorReadDto.from(vendor);
    }

    // 거래 중단
    @Transactional
    public void suspend(Long id) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));
        vendor.changeStatus(VendorStatus.STOPPED);
    }

    public List<ProductListResponse> readProducts(Long id) {
        authAccessService.assertVendorScope(id);
        validateExists(id);
        return productRepository.findByVendorId(id).stream()
                .map(ProductListResponse::from)
                .toList();
    }

    public Page<PurchaseOrderListResponse> readPurchaseOrders(Long id, Integer page, Integer size) {
        authAccessService.assertVendorScope(id);
        validateExists(id);
        return purchaseOrderRepository.findByVendorId(id, PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id")))
                .map(PurchaseOrderListResponse::from);
    }

    public VendorPurchaseOrderPageResponse readVendorPortalPurchaseOrders(Long id, Integer page, Integer size) {
        authAccessService.assertVendorScope(id);
        validateExists(id);

        List<Asn> asns = asnRepository.findAllByPurchaseOrderVendorIdOrderByIdDesc(id);
        Map<Long, Asn> asnMap = asns.stream()
                .collect(Collectors.toMap(asn -> asn.getPurchaseOrder().getId(), Function.identity(), (left, right) -> left));

        List<VendorPurchaseOrderListResponse> responses = purchaseOrderRepository.findByVendorId(id).stream()
                .filter(purchaseOrder -> purchaseOrder.getStatus() == PurchaseOrderStatus.ORDERED)
                .sorted((left, right) -> right.getId().compareTo(left.getId()))
                .map(purchaseOrder -> VendorPurchaseOrderListResponse.from(purchaseOrder, asnMap.get(purchaseOrder.getId())))
                .toList();

        Pageable pageable = PageRequest.of(page, size);
        int start = (int) pageable.getOffset();
        int end = Math.min(start + pageable.getPageSize(), responses.size());
        List<VendorPurchaseOrderListResponse> content = start >= responses.size()
                ? List.of()
                : responses.subList(start, end);

        PageResponse<VendorPurchaseOrderListResponse> pageResponse = PageResponse.from(
                new PageImpl<>(content, pageable, responses.size())
        );

        return VendorPurchaseOrderPageResponse.from(
                pageResponse,
                VendorPurchaseOrderSummaryResponse.from(responses)
        );
    }

    public Page<AsnListResponse> readAsns(Long id, Integer page, Integer size) {
        authAccessService.assertVendorScope(id);
        validateExists(id);
        return asnRepository.findAllByPurchaseOrderVendorIdOrderByIdDesc(id, PageRequest.of(page, size))
                .map(AsnListResponse::from);
    }

    public Page<InboundReadDto> readInbounds(Long id, Integer page, Integer size) {
        authAccessService.assertVendorScope(id);
        validateExists(id);
        return inboundRepository.findByPurchaseOrderVendorId(id, PageRequest.of(page, size))
                .map(InboundReadDto::from);
    }

    private void validateExists(Long id) {
        if (!vendorRepository.existsById(id)) {
            throw new VendorException(VENDOR_NOT_FOUND);
        }
    }
}
