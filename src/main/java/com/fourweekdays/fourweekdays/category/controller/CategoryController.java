package com.fourweekdays.fourweekdays.category.controller;

import com.fourweekdays.fourweekdays.category.dto.request.CategoryCreateDto;
import com.fourweekdays.fourweekdays.category.dto.response.CategoryReadDto;
import com.fourweekdays.fourweekdays.category.service.CategoryService;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/category")

public class CategoryController {

    private final CategoryService categoryService;

    // 카테고리 등록
    @PostMapping
    public ResponseEntity<BaseResponse<String>> register(@RequestBody CategoryCreateDto dto) {
        categoryService.register(dto);
        return ResponseEntity.ok(BaseResponse.success("등록 완료"));

    }

    // 카테고리 전체 조회
    @GetMapping
    public ResponseEntity<BaseResponse<List<CategoryReadDto>>> getCategoryList() {
        List<CategoryReadDto> categoryList = categoryService.getCategoryList();
        return ResponseEntity.ok(BaseResponse.success(categoryList));
    }

}
