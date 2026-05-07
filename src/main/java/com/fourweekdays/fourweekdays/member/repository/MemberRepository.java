package com.fourweekdays.fourweekdays.member.repository;

import com.fourweekdays.fourweekdays.member.domain.Member;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long>, MemberRepositoryCustom {
    Optional<Member> findByEmail(String email);
    Optional<Member> findByLoginId(String loginId);
    @EntityGraph(attributePaths = {"vendor"})
    Optional<Member> findByLoginIdOrEmail(String loginId, String email);
    boolean existsByEmail(String email);
    boolean existsByLoginId(String loginId);
    boolean existsByMemberCode(String memberCode);
}
