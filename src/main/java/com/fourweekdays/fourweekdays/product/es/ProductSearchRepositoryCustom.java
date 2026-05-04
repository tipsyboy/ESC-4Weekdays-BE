package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import org.springframework.data.elasticsearch.core.SearchHits;

import java.util.List;

public interface ProductSearchRepositoryCustom {

    List<ProductDocument> search(ProductSearchRequest request, int page, int size);

    SearchHits<ProductDocument> searchHits(ProductSearchRequest request, int page, int size);
}
