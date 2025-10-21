package com.fourweekdays.fourweekdays.franchise.model.dto.request;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.franchise.exception.FranchiseException;
import com.fourweekdays.fourweekdays.franchise.model.entity.FranchiseStatus;
import lombok.Builder;
import lombok.Getter;

import static com.fourweekdays.fourweekdays.franchise.exception.FranchiseExceptionType.FRANCHISE_INVALID_STATUS;

@Getter
@Builder
public class FranchiseUpdateDto {
    private String name;
    private String phoneNumber;
    private String email;
    private String description;
    private Address address;
    private String status;

    public FranchiseStatus validate() {
        try {
            return FranchiseStatus.valueOf(status.toUpperCase());
        } catch (Exception e) {
            throw new FranchiseException(FRANCHISE_INVALID_STATUS);
        }
    }
}
