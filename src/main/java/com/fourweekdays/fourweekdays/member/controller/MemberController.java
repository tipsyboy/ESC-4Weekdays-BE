package com.fourweekdays.fourweekdays.member.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.member.model.dto.MemberResponseDto;
import com.fourweekdays.fourweekdays.member.model.dto.MemberSignUpDto;
import com.fourweekdays.fourweekdays.member.model.dto.MemberUpdateDto;
import com.fourweekdays.fourweekdays.member.service.MemberService;
import com.fourweekdays.fourweekdays.product.dto.request.ProductUpdateDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberController {
    private final MemberService memberService;

    // 회원 등록
    @PostMapping("/signup")
    public ResponseEntity<BaseResponse<String>> register(@RequestBody MemberSignUpDto dto) {
        memberService.register(dto);
        return ResponseEntity.ok(BaseResponse.success("등록 완료"));
    }

    // 직원 목록 조회
    @GetMapping("/list")
    public ResponseEntity<BaseResponse<List<MemberResponseDto>>> getMemberList() {
        List<MemberResponseDto> productList = memberService.getMemberList();
        return ResponseEntity.ok(BaseResponse.success(productList));
    }

    //직원 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<MemberResponseDto>> getByMemberId(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(memberService.getMemberById(id)));
    }

    //직원 정보 수정
    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<Long>> updateMember(@PathVariable Long id,
                                                            @RequestBody MemberUpdateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(memberService.update(id, requestDto)));
    }
}
