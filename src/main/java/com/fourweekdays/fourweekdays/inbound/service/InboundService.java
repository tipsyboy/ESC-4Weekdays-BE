package com.fourweekdays.fourweekdays.inbound.service;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import com.fourweekdays.fourweekdays.asn.exception.AsnException;
import com.fourweekdays.fourweekdays.asn.repository.AsnRepository;
import com.fourweekdays.fourweekdays.global.response.PageResponse;
import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.inbound.exception.InboundException;
import com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType;
import com.fourweekdays.fourweekdays.inbound.dto.*;
import com.fourweekdays.fourweekdays.inbound.dto.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import com.fourweekdays.fourweekdays.inbound.domain.InboundProduct;
import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.inventory.service.InventoryService;
import com.fourweekdays.fourweekdays.location.exception.LocationException;
import com.fourweekdays.fourweekdays.location.model.entity.Location;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.tasks.factory.InboundTaskFactory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import static com.fourweekdays.fourweekdays.asn.exception.AsnExceptionType.ASN_NOT_FOUND;
import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_INVALID_STATUS_FOR_INSPECTION;
import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_INVALID_REQUEST;
import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_NOT_FOUND;
import static com.fourweekdays.fourweekdays.location.exception.LocationExceptionType.LOCATION_NOT_FOUND;
import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class InboundService {

    private final MemberRepository memberRepository;
    private final InboundRepository inboundRepository;
    private final AsnRepository asnRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final ProductRepository productRepository;
    private final LocationRepository locationRepository;
    private final InventoryService inventoryService;
    private final CodeGenerator codeGenerator;
    private final InboundTaskFactory inboundTaskFactory;

    @Transactional
    public InboundDetailResponse create(InboundCreateRequest request) {
        Asn asn = asnRepository.findById(request.asnId())
                .orElseThrow(() -> new AsnException(ASN_NOT_FOUND));

        Inbound inbound = createExpectedFromAsn(asn, request.dock(), request.inboundMemo());

        if (asn.getStatus() == AsnStatus.RECEIVED) {
            asn.markScheduled();
        }

        return InboundDetailResponse.from(inbound);
    }

    @Transactional
    public Inbound createExpectedFromAsn(Asn asn) {
        return createExpectedFromAsn(asn, null, asn.getNote());
    }

    @Transactional
    public Inbound createExpectedFromAsn(Asn asn, String dock, String inboundMemo) {
        if (inboundRepository.existsByAsnId(asn.getId())) {
            return inboundRepository.findByAsnId(asn.getId())
                    .orElseThrow(() -> new InboundException(INBOUND_INVALID_REQUEST));
        }

        if (asn.getStatus() != AsnStatus.RECEIVED && asn.getStatus() != AsnStatus.SCHEDULED) {
            throw new InboundException(INBOUND_INVALID_REQUEST);
        }

        Inbound inbound = Inbound.builder()
                .inboundCode(codeGenerator.generate(CodeType.INBOUND))
                .purchaseOrder(asn.getPurchaseOrder())
                .asn(asn)
                .vendor(asn.getVendor())
                .expectedInboundAt(asn.getExpectedArrivalAt())
                .scheduledDate(asn.getExpectedArrivalAt())
                .status(InboundStatus.PLANNED)
                .manager(asn.getPurchaseOrder().getManager())
                .dock(dock)
                .inboundMemo(inboundMemo)
                .description(inboundMemo)
                .build();

        asn.getItems().forEach(asnItem -> inbound.addItem(InboundProduct.builder()
                .product(asnItem.getProduct())
                .expectedQuantity(asnItem.getAnnouncedQuantity())
                .receivedQuantity(0)
                .defectQuantity(0)
                .description("")
                .memo("")
                .build()));

        return inboundRepository.save(inbound);
    }

    public InboundPageResponse readAll(int page, int size) {
        List<InboundListResponse> allInbounds = inboundRepository.findAllByOrderByIdDesc().stream()
                .map(InboundListResponse::from)
                .toList();

        PageResponse<InboundListResponse> pageResponse = PageResponse.from(
                inboundRepository.findAll(PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id")))
                        .map(InboundListResponse::from)
        );

        return InboundPageResponse.from(pageResponse, InboundSummaryResponse.from(allInbounds));
    }

    public InboundDetailResponse read(Long id) {
        return InboundDetailResponse.from(getInbound(id));
    }

    public InboundDetailResponse readByAsnId(Long asnId) {
        return inboundRepository.findByAsnId(asnId)
                .map(InboundDetailResponse::from)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
    }

    @Transactional
    public InboundDetailResponse updateReceipt(Long id, InboundReceiptUpdateRequest request) {
        Inbound inbound = getInbound(id);
        validateReceiptStatusTransition(inbound.getStatus(), request.status());

        Map<Long, InboundProduct> inboundProductMap = inbound.getItems().stream()
                .collect(java.util.stream.Collectors.toMap(item -> item.getProduct().getId(), Function.identity()));

        for (InboundReceiptItemRequest itemRequest : request.items()) {
            InboundProduct inboundProduct = inboundProductMap.get(itemRequest.productId());

            if (inboundProduct == null) {
                throw new InboundException(InboundExceptionType.INBOUND_PRODUCT_NOT_FOUND);
            }

            validateReceiptQuantity(
                    inboundProduct.getProduct(),
                    inboundProduct.getExpectedQuantity(),
                    itemRequest.receivedQuantity(),
                    itemRequest.defectQuantity()
            );

            Location location = resolveInboundItemLocation(request.status(), itemRequest.locationId());
            inboundProduct.updateReceipt(
                    location,
                    itemRequest.receivedQuantity(),
                    itemRequest.defectQuantity(),
                    itemRequest.memo()
            );
        }

        LocalDateTime receivedAt = request.receivedAt() != null ? request.receivedAt() : LocalDateTime.now();
        inbound.updateProcessing(receivedAt, request.status(), request.inspectionMemo());

        if (request.status() == InboundStatus.COMPLETED) {
            inventoryService.reflectInbound(inbound, receivedAt);
            PurchaseOrder purchaseOrder = inbound.getPurchaseOrder();
            if (purchaseOrder != null) {
                purchaseOrder.completeDelivery();
            }
        }

        return InboundDetailResponse.from(inbound);
    }

    public Long createByPurchaseOrder(PurchaseOrder purchaseOrder) {

        /**
         * -> 발주 트리거에 의해 트랜잭션 전파 Transactional 어노테이션 없음.
         * 1. member 연결하고 담당자 배정해야함. -> O
         * 2. ASN 구현시 발주 승인 트리거가 아닌 ASN 수신 트리거에 의해 생성 로직이 실행되어야함.
         * TODO: 3. ASN 수신시 입고 예정일을 받아서 Inbound의 입고 예정일 상태를 변경해야함.
         * TODO: 4. 하나의 발주서로 여러 Inbound가 생성되지 않게 만드는 방어 로직 필요.
         */

        Member manager = purchaseOrder.getManager(); // 발주 담당자 -> 입고 담당자

        Inbound inbound = Inbound.builder()
                .inboundCode(codeGenerator.generate(CodeType.INBOUND))
                .purchaseOrder(purchaseOrder)
                .status(InboundStatus.SCHEDULED)
                .manager(manager)
                .description(purchaseOrder.getDescription())
                .scheduledDate(purchaseOrder.getExpectedDate())
                .build();

        purchaseOrder.getProducts().forEach(purchaseOrderProduct -> {
            log.info("purchaseOrderProduct.getOrderedQuantity()={}", purchaseOrderProduct.getOrderedQuantity());
            InboundProduct.builder()
                    .inbound(inbound)
                    .product(purchaseOrderProduct.getProduct())
                    .purchaseOrderProduct(purchaseOrderProduct)
                    .receivedQuantity(purchaseOrderProduct.getOrderedQuantity())
                    .description(purchaseOrderProduct.getDescription())
                    .build();
        });

        return inboundRepository.save(inbound).getId();
    }

    public Page<InboundReadDto> searchInbounds(int page, int size, InboundSearchRequest request) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Inbound> inboundPage = inboundRepository.searchInboundWithProduct(
                pageable,
                request.inboundCode(),
                request.productName(),
                request.managerName(),
                request.vendorIds()
        );

        return inboundPage.map(InboundReadDto::from);
    }

    public InboundReadDto findById(Long id) {
        Inbound inbound = getInbound(id);
        return InboundReadDto.from(inbound);
    }

    @Transactional
    public void updateInboundStatus(Long inboundId, InboundStatusUpdateRequest requestDto) {
        Inbound inbound = inboundRepository.findById(inboundId)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
        log.info("inbound={}", inbound.getProducts());
        inbound.updateStatus(requestDto.status());
    }

    @Transactional
    public void updateInspection(Long inboundId, List<InboundInspectionUpdateRequest> requestList) {
        Inbound inbound = inboundRepository.findById(inboundId)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));

        if (inbound.getStatus() != InboundStatus.INSPECTING) {
            throw new InboundException(INBOUND_INVALID_STATUS_FOR_INSPECTION);
        }

        for (InboundInspectionUpdateRequest request : requestList) {
            InboundProduct product = inbound.findProductById(request.inboundProductId())
                    .orElseThrow(() -> new InboundException(InboundExceptionType.INBOUND_PRODUCT_NOT_FOUND));
            product.updateInspectionResult(request.receivedQuantity());
        }

        // 검수 완료 시 적치 작업으로 변경
        inbound.updateStatus(InboundStatus.PUTAWAY);
    }

    @Transactional
    public void cancel(Long id) {
        Inbound inbound = inboundRepository.findById(id)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));

        if (inbound.getStatus() != InboundStatus.CREATED && inbound.getStatus() != InboundStatus.SCHEDULED) {
            throw new InboundException(InboundExceptionType.INBOUND_CANNOT_CANCEL);
        }
        inbound.cancelInbound();
    }

    @Transactional
    public void arriveDelivery(Long inboundId) {
        Inbound inbound = inboundRepository.findById(inboundId)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
        inbound.updateStatus(InboundStatus.ARRIVED);

        PurchaseOrder purchaseOrder = inbound.getPurchaseOrder();
        purchaseOrder.completeDelivery();

        inboundTaskFactory.createInspectionTask(inboundId);
    }

    // TODO: 삭제? 발주서가 없는 입고는 어떻게 처리할까
    @Transactional
    public Long create(InboundCreateRequestDto requestDto) {
        requestDto.validate();

        // 1. Inbound Entity
        Inbound inbound = createBaseInbound(requestDto);

        // 2. 발주서를 통한 입고 상품 생성
        addItemsFromPurchaseOrder(requestDto, inbound);

        // 3. 상품을 통한 입고 상품 생성
        addDirectItems(requestDto, inbound);

        return inboundRepository.save(inbound).getId();
    }

    // TODO: 삭제?
//    @Transactional
//    public Long update(InboundStatusUpdateRequest requestDto, Long id) {
//        Member manager = memberRepository.findById(requestDto.getMemberId())
//                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));
//
//        Inbound inbound = inboundRepository.findById(id)
//                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
//
//        inbound.updateData(manager.getName(), requestDto.getScheduledDate(), requestDto.getDescription());
//
//        if (requestDto.getItems() != null && !requestDto.getItems().isEmpty()) {
//            List<InboundProduct> items = requestDto.getItems().stream()
//                    .map(itemDto -> convertToEntity(itemDto, inbound))
//                    .toList();
//            inbound.updateItems(items);
//        }
//
//        return inbound.getId();
//    }


    private Inbound createBaseInbound(InboundCreateRequestDto requestDto) {
        Member manager = memberRepository.findById(requestDto.getMemberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        return Inbound.builder()
                .inboundCode(codeGenerator.generate(CodeType.INBOUND))
                .status(InboundStatus.SCHEDULED)
                .manager(manager)
                .scheduledDate(requestDto.getScheduledDate())
                .description(requestDto.getDescription())
                .build();
    }

    private void addItemsFromPurchaseOrder(InboundCreateRequestDto requestDto, Inbound inbound) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(requestDto.getPurchaseOrderId())
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        purchaseOrder.getProducts().forEach(poItem -> {
            InboundProduct inboundItem = InboundProduct.builder()
                    .product(poItem.getProduct())
                    .purchaseOrderProduct(poItem)
                    .receivedQuantity(0)
                    .description(poItem.getDescription())
                    .build();

            inboundItem.assignInbound(inbound);
        });
    }

    private void addDirectItems(InboundCreateRequestDto requestDto, Inbound inbound) {
        if (requestDto.getItems() == null || requestDto.getItems().isEmpty()) {
            return;
        }

        requestDto.getItems().forEach(itemDto -> {
            Product product = productRepository.findById(itemDto.getProductId())
                    .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

            InboundProduct inboundItem = InboundProduct.builder()
                    .product(product)
                    .inbound(inbound)
                    .purchaseOrderProduct(null)
                    .receivedQuantity(itemDto.getQuantity())
                    .description(itemDto.getDescription())
                    .build();
        });
    }

    private InboundProduct convertToEntity(InboundProductDto dto, Inbound inbound) {
        Product product = productRepository.findById(dto.getProductId())
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        return InboundProduct.builder()
                .inbound(inbound)
                .product(product)
                .receivedQuantity(dto.getQuantity())
                .description(dto.getDescription())
                .build();
    }

    private Inbound getInbound(Long id) {
        return inboundRepository.findById(id)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
    }

    private void validateReceiptQuantity(Product product, Integer expectedQuantity, Integer receivedQuantity, Integer defectQuantity) {
        int received = receivedQuantity != null ? receivedQuantity : 0;
        int defect = defectQuantity != null ? defectQuantity : 0;

        if (received + defect > expectedQuantity) {
            throw new InboundException(INBOUND_INVALID_REQUEST);
        }
    }

    private Location resolveInboundItemLocation(InboundStatus status, Long locationId) {
        if (locationId == null) {
            if (status == InboundStatus.COMPLETED) {
                throw new InboundException(INBOUND_INVALID_REQUEST);
            }
            return null;
        }

        Location location = locationRepository.findById(locationId)
                .orElseThrow(() -> new LocationException(LOCATION_NOT_FOUND));

        if (!location.isAvailable()) {
            throw new InboundException(INBOUND_INVALID_REQUEST);
        }

        return location;
    }

    private void validateReceiptStatusTransition(InboundStatus currentStatus, InboundStatus nextStatus) {
        boolean valid = switch (currentStatus) {
            case PLANNED -> nextStatus == InboundStatus.RECEIVING
                    || nextStatus == InboundStatus.PARTIAL
                    || nextStatus == InboundStatus.COMPLETED;
            case RECEIVING -> nextStatus == InboundStatus.PARTIAL
                    || nextStatus == InboundStatus.COMPLETED;
            case PARTIAL -> nextStatus == InboundStatus.RECEIVING
                    || nextStatus == InboundStatus.COMPLETED;
            case COMPLETED -> false;
            default -> currentStatus.canTransitionTo(nextStatus);
        };

        if (!valid) {
            throw new InboundException(InboundExceptionType.INBOUND_STATUS_TRANSITION_NOT_ALLOWED);
        }
    }
}
