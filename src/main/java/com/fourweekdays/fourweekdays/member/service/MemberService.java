package com.fourweekdays.fourweekdays.member.service;

import com.fourweekdays.fourweekdays.member.model.UserAuth;
import com.fourweekdays.fourweekdays.member.model.dto.MemberResponseDto;
import com.fourweekdays.fourweekdays.member.model.dto.MemberSignUpDto;
import com.fourweekdays.fourweekdays.member.model.dto.MemberUpdateDto;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.product.dto.request.ProductUpdateDto;
import com.fourweekdays.fourweekdays.product.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.model.Product;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorUpdateDto;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@RequiredArgsConstructor
@Service
public class MemberService implements UserDetailsService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    // 회원등록
    public void register(MemberSignUpDto dto) {
        String encodedPassword = passwordEncoder.encode(dto.getPassword());
        Member member = dto.toEntity(encodedPassword);
        memberRepository.save(member);
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
                .orElse(null);
    }

    //직원 정보 수정
    @Transactional
    public Long update(Long id, MemberUpdateDto dto) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("회원을 찾을 수 없습니다."));

        member.update(dto.getName(), dto.getPhoneNumber(), dto.getPassword(),
                dto.getRole(), dto.getStatus());

        return member.getId();
    }

    //회원 조회
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("존재하지 않는 이메일입니다. : " + email));

        return UserAuth.builder()
                .id(member.getId())
                .email(member.getEmail())
                .password(member.getPassword())
                .name(member.getName())
                .role(member.getRole())
                .build();
    }
}