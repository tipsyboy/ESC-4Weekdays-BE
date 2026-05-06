package com.fourweekdays.fourweekdays.vendor.service;

import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnResponse;
import com.fourweekdays.fourweekdays.asn.repository.AsnRepository;
import com.fourweekdays.fourweekdays.inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.product.dto.ProductListResponse;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.dto.VendorCreateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorSearchCondition;
import com.fourweekdays.fourweekdays.vendor.dto.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.dto.VendorReadDto;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
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

    @Transactional
    public VendorReadDto create(VendorCreateDto dto) {
        Vendor result = vendorRepository.save(dto.toEntity(codeGenerator.generate(CodeType.VENDOR)));

        return VendorReadDto.from(result);
    }

    public VendorReadDto read(Long id) {
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
        validateExists(id);
        return productRepository.findByVendorId(id).stream()
                .map(ProductListResponse::from)
                .toList();
    }

    public List<PurchaseOrderReadDto> readPurchaseOrders(Long id) {
        validateExists(id);
        return purchaseOrderRepository.findByVendorId(id).stream()
                .map(PurchaseOrderReadDto::toDto)
                .toList();
    }

    public Page<AsnResponse> readAsns(Long id, Integer page, Integer size) {
        validateExists(id);
        return asnRepository.findByVendorId(id, PageRequest.of(page, size))
                .map(AsnResponse::toDto);
    }

    public Page<InboundReadDto> readInbounds(Long id, Integer page, Integer size) {
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
