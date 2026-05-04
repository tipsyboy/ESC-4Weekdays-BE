package com.fourweekdays.fourweekdays.member.service;

import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.exception.MemberExceptionType;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import com.fourweekdays.fourweekdays.member.dto.MemberResponseDto;
import com.fourweekdays.fourweekdays.member.dto.MemberSearchDto;
import com.fourweekdays.fourweekdays.member.dto.MemberSignUpDto;
import com.fourweekdays.fourweekdays.member.dto.MemberUpdateDto;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.regex.Pattern;

@RequiredArgsConstructor
@Service
public class MemberService {

    private static final Pattern EMAIL_STYLE_LOGIN_ID_PATTERN =
            Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final VendorRepository vendorRepository;

    // 회원등록
    public MemberResponseDto register(MemberSignUpDto dto) {
        validateDuplicate(dto);
        String loginId = resolveLoginId(dto.getLoginId(), dto.getEmail());
        validateRoleAndVendor(dto.getRole(), loginId, dto.getVendorId());

        String encodedPassword = passwordEncoder.encode(dto.getPassword());
        String memberCode = resolveMemberCode(dto.getMemberCode());
        Vendor vendor = resolveVendor(dto.getVendorId());

        Member member = Member.builder()
                .memberCode(memberCode)
                .loginId(loginId)
                .email(dto.getEmail())
                .password(encodedPassword)
                .name(dto.getName())
                .department(resolveDepartment(dto.getDepartment()))
                .phoneNumber(dto.getPhoneNumber())
                .role(dto.getRole())
                .status(dto.getStatus())
                .note(dto.getNote())
                .vendor(vendor)
                .joinAt(java.time.LocalDateTime.now())
                .build();

        memberRepository.save(member);
        return MemberResponseDto.from(member);
    }

    // 회원 전체 조회
    public List<MemberResponseDto> getMemberList() {
        return memberRepository.findAll().stream()
                .map(MemberResponseDto::from)
                .collect(Collectors.toList());
    }

    // 직원 상세 조회
    public MemberResponseDto getMemberDetails(Long id) {
        return memberRepository.findById(id)
                .map(MemberResponseDto::from)
                .orElseThrow(() -> new MemberException(MemberExceptionType.MEMBER_NOT_FOUND));
    }

    //직원 정보 수정
    @Transactional
    public Long update(Long id, MemberUpdateDto dto) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new MemberException(MemberExceptionType.MEMBER_NOT_FOUND));

        validateUpdateDuplicate(member, dto);
        validateRoleAndVendor(member.getRole(), member.getLoginId(), dto.getVendorId());

        String encodedPassword = null;
        if (dto.getPassword() != null && !dto.getPassword().isBlank()) {
            encodedPassword = passwordEncoder.encode(dto.getPassword());
        }

        member.update(
                dto.getName(),
                dto.getDepartment(),
                dto.getEmail(),
                dto.getPhoneNumber(),
                encodedPassword,
                dto.getRole(),
                dto.getStatus(),
                dto.getNote(),
                resolveVendor(dto.getVendorId())
        );

        return member.getId();
    }

    //페이징 처리 조회
    public Page<MemberResponseDto> readAll(Integer page, Integer size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Member> result = memberRepository.findAllWithPaging(pageable);
        return result.map(MemberResponseDto::from);
    }

    public void checkEmailDuplicate(String email) {
        if (memberRepository.existsByEmail(email)) {
            throw new MemberException(MemberExceptionType.DUPLICATE_EMAIL);
        }
    }

    private void validateDuplicate(MemberSignUpDto dto) {
        if (memberRepository.existsByEmail(dto.getEmail())) {
            throw new MemberException(MemberExceptionType.DUPLICATE_EMAIL);
        }

        String loginId = resolveLoginId(dto.getLoginId(), dto.getEmail());
        if (memberRepository.existsByLoginId(loginId)) {
            throw new MemberException(MemberExceptionType.DUPLICATE_LOGIN_ID);
        }

        if (dto.getMemberCode() != null && !dto.getMemberCode().isBlank()
                && memberRepository.existsByMemberCode(dto.getMemberCode().trim())) {
            throw new MemberException(MemberExceptionType.DUPLICATE_MEMBER_CODE);
        }
    }

    private void validateUpdateDuplicate(Member member, MemberUpdateDto dto) {
        if (!member.getEmail().equals(dto.getEmail()) && memberRepository.existsByEmail(dto.getEmail())) {
            throw new MemberException(MemberExceptionType.DUPLICATE_EMAIL);
        }
    }

    public Page<MemberResponseDto> searchMembers(MemberSearchDto dto ,Pageable pageable) {
        Page<Member> members = memberRepository.searchMembers(
                dto.getName(),
                dto.getMemberCode(),
                dto.getDepartment(),
                dto.getLoginId(),
                dto.getStatus(),
                dto.getRole(),
                dto.getFromDate(),
                dto.getToDate(),
                pageable
        );

        return members.map(MemberResponseDto::from);
    }

    @Transactional
    public MemberResponseDto updateStatus(Long id, MemberStatus status) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new MemberException(MemberExceptionType.MEMBER_NOT_FOUND));

        member.update(
                null,
                null,
                null,
                null,
                null,
                null,
                status,
                null,
                member.getVendor()
        );

        return MemberResponseDto.from(member);
    }

    private Vendor resolveVendor(Long vendorId) {
        if (vendorId == null) {
            return null;
        }

        return vendorRepository.findById(vendorId)
                .orElseThrow(() -> new MemberException(MemberExceptionType.VENDOR_NOT_FOUND));
    }

    private String resolveLoginId(String loginId, String email) {
        return (loginId == null || loginId.isBlank()) ? email : loginId.trim();
    }

    private String resolveMemberCode(String memberCode) {
        if (memberCode != null && !memberCode.isBlank()) {
            return memberCode.trim();
        }

        return "MBR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    private String resolveDepartment(String department) {
        return (department == null || department.isBlank()) ? "미분류" : department.trim();
    }

    private void validateRoleAndVendor(MemberRole role,
                                       String loginId,
                                       Long vendorId) {
        boolean vendorManager = role == MemberRole.VENDOR_MANAGER;
        boolean emailStyleLoginId = EMAIL_STYLE_LOGIN_ID_PATTERN.matcher(loginId).matches();

        if (vendorManager && !emailStyleLoginId) {
            throw new MemberException(MemberExceptionType.INVALID_LOGIN_ID_FORMAT);
        }

        if (!vendorManager && emailStyleLoginId) {
            throw new MemberException(MemberExceptionType.INVALID_LOGIN_ID_FORMAT);
        }

        if (vendorManager && vendorId == null) {
            throw new MemberException(MemberExceptionType.INVALID_VENDOR_MAPPING);
        }

        if (!vendorManager && vendorId != null) {
            throw new MemberException(MemberExceptionType.INVALID_VENDOR_MAPPING);
        }
    }
}
