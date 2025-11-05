//package com.fourweekdays.fourweekdays.category.service;
//
//import com.fourweekdays.fourweekdays.category.dto.request.CategoryCreateDto;
//import com.fourweekdays.fourweekdays.category.dto.response.CategoryReadDto;
//import com.fourweekdays.fourweekdays.category.model.Category;
//import com.fourweekdays.fourweekdays.category.repository.CategoryRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.util.List;
//import java.util.stream.Collectors;
//
//@Service
//@RequiredArgsConstructor
//public class CategoryService {
//
//    private final CategoryRepository categoryRepository;
//
//    // 카테고리 등록
//    @Transactional
//    public Long register(CategoryCreateDto dto) {
//        Category parent = null;
//
//        // 상위 카테고리가 있을 경우 조회
//        if (dto.getParentId() != null) {
//            parent = categoryRepository.findById(dto.getParentId())
//                    .orElseThrow(() -> new IllegalArgumentException("상위 카테고리를 찾을 수 없습니다."));
//        }
//
//        Category category = dto.toEntity(parent);
//        Category result = categoryRepository.save(category);
//
//        return result.getId();
//    }
//
//    // 카테고리 전체 조회
//    @Transactional(readOnly = true)
//    public List<CategoryReadDto> getCategoryList() {
//        return categoryRepository.findAll().stream()
//                .map(CategoryReadDto::from)
//                .collect(Collectors.toList());
//    }
//}