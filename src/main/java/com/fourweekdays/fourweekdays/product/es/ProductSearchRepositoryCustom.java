package com.fourweekdays.fourweekdays.product.es;

import java.util.List;

public interface ProductSearchRepositoryCustom {

    List<ProductDocument> searchByName(String keyword);
}
