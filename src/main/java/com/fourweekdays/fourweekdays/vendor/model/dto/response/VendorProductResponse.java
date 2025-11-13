package com.fourweekdays.fourweekdays.vendor.model.dto.response;

import com.fourweekdays.fourweekdays.product.model.dto.response.ProductResponse;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class VendorProductResponse {
    private VendorResponse vendor;
    private List<ProductResponse> products;

    public static VendorProductResponse from(Vendor vendor, List<Product> products) {
        return VendorProductResponse.builder()
                .vendor(VendorResponse.from(vendor))
                .products(products.stream()
                        .map(ProductResponse::from)
                        .toList())
                .build();
    }
}
