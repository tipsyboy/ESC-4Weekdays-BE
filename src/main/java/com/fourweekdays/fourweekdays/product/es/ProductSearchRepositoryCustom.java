package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;

import java.util.List;

public interface ProductSearchRepositoryCustom {

    List<ProductDocument> search(ProductSearchRequest request);
}
