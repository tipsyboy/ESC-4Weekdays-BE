package com.fourweekdays.fourweekdays.search;


import com.fourweekdays.fourweekdays.product.model.entity.Product;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;




@NoArgsConstructor @Getter
@AllArgsConstructor @Builder
@Document(indexName = "products")
public class ProductDocument {

    @Id
    private String id; // Elasticsearch는 String ID 사용

    @Field(type = FieldType.Text)
    private String name;

    @Field(type = FieldType.Keyword)
    private String productCode;

    @Field(type = FieldType.Keyword)
    private String unit;

    @Field(type = FieldType.Long)
    private Long unitPrice;

    @Field(type = FieldType.Text)
    private String description;

    @Field(type = FieldType.Keyword)
    private String status; // ACTIVE, INACTIVE, DISCONTINUED

    @Field(type = FieldType.Keyword)
    private String vendorName; // Vendor 이름만 저장

    @Field(type = FieldType.Long)
    private Long vendorId;

    // Product Entity -> ProductDocument 변환
    public static ProductDocument from(Product product) {
        return ProductDocument.builder()
                .id(String.valueOf(product.getId()))
                .name(product.getName())
                .productCode(product.getProductCode())
                .unit(product.getUnit())
                .unitPrice(product.getUnitPrice())
                .description(product.getDescription())
                .status(product.getStatus().name())
                .vendorName(product.getVendor() != null ? product.getVendor().getName() : null)
                .vendorId(product.getVendor() != null ? product.getVendor().getId() : null)
                .build();
    }
}
