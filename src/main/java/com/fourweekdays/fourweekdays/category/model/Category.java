package com.fourweekdays.fourweekdays.category.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;
    private String name;            // 카테고리명 (예: 식품, 음료, 냉동식품 등)
    private String code;            // 카테고리 코드 (예: F001, F001-1)
    private String description;     // 카테고리 설명
    private boolean isActive;       // 활성화 여부

    // 상위 카테고리
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Category parent;

    // 하위 카테고리 목록
    @OneToMany(mappedBy = "parent")
    private List<Category> children = new ArrayList<>();

}
