package com.fourweekdays.fourweekdays.member.dto;

import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberStatusUpdateDto {

    @NotNull(message = "상태를 선택해주세요")
    private MemberStatus status;
}
