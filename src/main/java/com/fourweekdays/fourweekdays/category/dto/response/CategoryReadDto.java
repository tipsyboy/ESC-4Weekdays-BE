package com.fourweekdays.fourweekdays.category.dto.response;

import com.fourweekdays.fourweekdays.category.model.Category;
import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CategoryReadDto {

    private Long id;
    private String name;
    private boolean active;
    private Long parentId;

    public static CategoryReadDto from(Category category) {
        return CategoryReadDto.builder()
                .id(category.getId())
                .name(category.getName())
                .active(category.isActive()) //
                .parentId(category.getParent() != null ? category.getParent().getId() : null)
                .build();
    }
}
