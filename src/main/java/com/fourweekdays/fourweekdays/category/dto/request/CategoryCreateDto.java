package com.fourweekdays.fourweekdays.category.dto.request;

import com.fourweekdays.fourweekdays.category.model.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryCreateDto {

    private String name;        // 카테고리명
    private String code;        // 카테고리 코드
    private String description; // 설명
    private Long parentId;      // 상위 카테고리 ID
    private boolean active;   // 활성화 여부

    // Entity 변환
    public Category toEntity(Category parent) {
        return Category.builder()
                .name(this.name)
                .code(this.code)
                .description(this.description)
                .parent(parent)
                .active(this.active)
                .build();
    }
}
