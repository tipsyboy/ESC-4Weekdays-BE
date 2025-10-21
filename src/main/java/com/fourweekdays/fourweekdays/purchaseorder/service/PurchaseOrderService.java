package com.fourweekdays.fourweekdays.purchaseorder.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderProductRequestDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProduct;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Transactional(readOnly = true)
@RequiredArgsConstructor
@Service
public class PurchaseOrderService {

    private static final String PURCHASE_ORDER_CODE_PREFIX = "PO";

    private final PurchaseOrderRepository purchaseOrderRepository;
    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;
    private final CodeGenerator codeGenerator;

    @Transactional
    public Long create(PurchaseOrderCreateDto requestDto) {
        Vendor vendor = vendorRepository.findById(requestDto.getVendorId())
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        PurchaseOrder purchaseOrder = createPurchaseOrder(vendor, requestDto);
        createOrderProducts(requestDto.getItems(), purchaseOrder);

        return purchaseOrderRepository.save(purchaseOrder).getId();
    }

    public PurchaseOrderReadDto findByPurchaseOrderId(Long id) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(id)
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        return PurchaseOrderReadDto.toDto(purchaseOrder);
    }

    public Page<PurchaseOrderReadDto> findPurchaseOrderListByPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<PurchaseOrder> purchaseOrderList = purchaseOrderRepository.findAllWithPaging(pageable);
        return purchaseOrderList.map(PurchaseOrderReadDto::toDto);
    }


    private PurchaseOrder createPurchaseOrder(Vendor vendor, PurchaseOrderCreateDto dto) {
        return PurchaseOrder.builder()
                .vendor(vendor)
                .orderCode(codeGenerator.generate(PURCHASE_ORDER_CODE_PREFIX))
                .orderDate(LocalDateTime.now())
                .expectedDate(dto.getExpectedDate())
                .description(dto.getDescription())
                .status(PurchaseOrderStatus.REQUESTED)
                .build();
    }

    private List<PurchaseOrderProduct> createOrderProducts(List<PurchaseOrderProductRequestDto> items, PurchaseOrder purchaseOrder) {
        return items.stream()
                .map(item -> createOrderProduct(item, purchaseOrder))
                .toList();
    }

    private PurchaseOrderProduct createOrderProduct(PurchaseOrderProductRequestDto dto, PurchaseOrder purchaseOrder) {
        Product product = productRepository.findById(dto.getProductId())
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        PurchaseOrderProduct orderProduct = PurchaseOrderProduct.builder()
                .product(product)
                .orderedQuantity(dto.getOrderedQuantity())
                .description(dto.getDescription())
                .build();

        purchaseOrder.addItem(orderProduct);
        return orderProduct;
    }
}
