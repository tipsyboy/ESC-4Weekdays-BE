package com.fourweekdays.fourweekdays.category.dto.response;

import com.fourweekdays.fourweekdays.category.model.Category;
import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryReadDto {

    private Long id;
    private String name;        // 카테고리명
    private String code;        // 카테고리 코드
    private String description; // 설명
    private Long parentId;      // 상위 카테고리 ID
    private boolean isActive;   // 활성화 여부

    public static CategoryReadDto from(Category category) {
        return CategoryReadDto.builder()
                .id(category.getId())
                .name(category.getName())
                .code(category.getCode())
                .description(category.getDescription())
                .parentId(category.getParent() != null ? category.getParent().getId() : null)
                .isActive(category.isActive())
                .build();
    }
}
