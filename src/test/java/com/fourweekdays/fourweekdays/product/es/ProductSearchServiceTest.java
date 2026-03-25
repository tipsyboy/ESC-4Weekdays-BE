package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.es.dto.ProductSearchResponse;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;

@ExtendWith(MockitoExtension.class)
class ProductSearchServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private ProductSearchRepository productSearchRepository;

    @InjectMocks
    private ProductSearchService productSearchService;

    @Test
    void 검색_조건이_없으면_빈_결과를_반환한다() {
        // given
        ProductSearchRequest request = new ProductSearchRequest(
                null, null, null, null, null, null, null, null
        );

        // when
        List<ProductSearchResponse> results = productSearchService.searchProducts(request);

        // then
        assertTrue(results.isEmpty());
        verifyNoInteractions(productSearchRepository);
    }

    @Test
    void 상품명_조건이_있으면_검색_결과를_응답_DTO로_변환한다() {
        // given
        ProductSearchRequest request = new ProductSearchRequest(
                null, "청소기", null, null, null, null, null, null
        );

        ProductDocument document = ProductDocument.builder()
                .id("2001")
                .productId(2001L)
                .productCode("PS-101-001")
                .name("삼성 무선 청소기")
                .unitPrice(329000L)
                .status(ProductStatus.ACTIVE)
                .vendorId(101L)
                .vendorName("삼성전자")
                .build();

        given(productSearchRepository.search(request)).willReturn(List.of(document));

        // when
        List<ProductSearchResponse> results = productSearchService.searchProducts(request);

        // then
        assertEquals(1, results.size());
        assertEquals(2001L, results.get(0).productId());
        assertEquals("PS-101-001", results.get(0).productCode());
        assertEquals("삼성 무선 청소기", results.get(0).name());
        verify(productSearchRepository).search(request);
    }

    @Test
    void 상태_조건만_있어도_검색을_수행한다() {
        // given
        ProductSearchRequest request = new ProductSearchRequest(
                null, null, ProductStatus.ACTIVE, null, null, null, null, null
        );

        given(productSearchRepository.search(request)).willReturn(List.of());

        // when
        List<ProductSearchResponse> results = productSearchService.searchProducts(request);

        // then
        assertTrue(results.isEmpty());
        verify(productSearchRepository).search(request);
    }

    @Test
    void 가격_범위_조건만_있어도_검색을_수행한다() {
        // given
        ProductSearchRequest request = new ProductSearchRequest(
                null, null, null, null, 100000L, 500000L, null, null
        );

        given(productSearchRepository.search(request)).willReturn(List.of());

        // when
        List<ProductSearchResponse> results = productSearchService.searchProducts(request);

        // then
        assertTrue(results.isEmpty());
        verify(productSearchRepository).search(request);
    }

    @Test
    void 공급업체명_조건만_있어도_검색을_수행한다() {
        // given
        ProductSearchRequest request = new ProductSearchRequest(
                null, null, null, "삼성전자", null, null, null, null
        );

        given(productSearchRepository.search(request)).willReturn(List.of());

        // when
        List<ProductSearchResponse> results = productSearchService.searchProducts(request);

        // then
        assertTrue(results.isEmpty());
        verify(productSearchRepository).search(request);
    }

    @Test
    void 상품코드와_상태_조건을_함께_전달해도_검색을_수행한다() {
        // given
        ProductSearchRequest request = new ProductSearchRequest(
                "PS-101-001", null, ProductStatus.ACTIVE, null, null, null, null, null
        );

        ProductDocument document = ProductDocument.builder()
                .id("2001")
                .productId(2001L)
                .productCode("PS-101-001")
                .name("삼성 무선 청소기")
                .unitPrice(329000L)
                .status(ProductStatus.ACTIVE)
                .vendorId(101L)
                .vendorName("삼성전자")
                .build();

        given(productSearchRepository.search(request)).willReturn(List.of(document));

        // when
        List<ProductSearchResponse> results = productSearchService.searchProducts(request);

        // then
        assertEquals(1, results.size());
        assertEquals(ProductStatus.ACTIVE, results.get(0).status());
        assertEquals("PS-101-001", results.get(0).productCode());
        verify(productSearchRepository).search(request);
    }
}
