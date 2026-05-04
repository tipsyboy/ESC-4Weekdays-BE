package com.fourweekdays.fourweekdays.member.controller;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.member.dto.MemberEmailCheckDto;
import com.fourweekdays.fourweekdays.member.dto.MemberResponseDto;
import com.fourweekdays.fourweekdays.member.dto.MemberSearchDto;
import com.fourweekdays.fourweekdays.member.dto.MemberSignUpDto;
import com.fourweekdays.fourweekdays.member.dto.MemberStatusUpdateDto;
import com.fourweekdays.fourweekdays.member.dto.MemberUpdateDto;
import com.fourweekdays.fourweekdays.member.service.MemberService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping({"/api/member", "/api/members"})
public class MemberController {
    private final MemberService memberService;

    // 회원 등록
    @PostMapping({"", "/signup"})
    public ResponseEntity<BaseResponse<MemberResponseDto>> register(@Valid @RequestBody MemberSignUpDto dto) {
        return ResponseEntity.ok(BaseResponse.success(memberService.register(dto)));
    }

    //직원 페이징 처리 조회
    @GetMapping({"", "/list"})
    public ResponseEntity<BaseResponse<Page<MemberResponseDto>>> memberReads(@RequestParam(defaultValue = "0") Integer page,
                                                                             @RequestParam(defaultValue = "10") Integer size) {
        Page<MemberResponseDto> result = memberService.readAll(page, size);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    //직원 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<MemberResponseDto>> getByMemberId(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(memberService.getMemberDetails(id)));
    }

    //직원 정보 수정
    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<MemberResponseDto>> updateMember(@PathVariable Long id,
                                                           @RequestBody MemberUpdateDto requestDto) {
        memberService.update(id, requestDto);
        return ResponseEntity.ok(BaseResponse.success(memberService.getMemberDetails(id)));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<BaseResponse<MemberResponseDto>> updateMemberStatus(
            @PathVariable Long id,
            @Valid @RequestBody MemberStatusUpdateDto requestDto
    ) {
        return ResponseEntity.ok(BaseResponse.success(memberService.updateStatus(id, requestDto.getStatus())));
    }

    //이메일 중복체크 기능
    @PostMapping("/check-email")
    public  ResponseEntity<BaseResponse<String>> checkEmail(@RequestBody MemberEmailCheckDto dto) {
        memberService.checkEmailDuplicate(dto.getEmail());
        return ResponseEntity.ok(BaseResponse.success("사용 가능한 이메일입니다."));
    }

    //검색 기능
    @GetMapping("/search")
    public ResponseEntity<BaseResponse<Page<MemberResponseDto>>> searchMember(
            MemberSearchDto dto,
            Pageable pageable
    ) {
        Page<MemberResponseDto> result = memberService.searchMembers(dto, pageable);
        return ResponseEntity.ok(BaseResponse.success(result));
    }
}
