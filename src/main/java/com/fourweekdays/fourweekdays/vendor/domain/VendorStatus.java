package com.fourweekdays.fourweekdays.vendor.domain;

import lombok.Getter;

@Getter
public enum VendorStatus {

    TRADING("거래중", "현재 거래중인 업체입니다."),
    PENDING("거래대기", "거래 시작 전 확인이 필요한 업체입니다."),
    STOPPED("거래중지", "폐업 등의 이유로 거래가 중지된 업체입니다.");

    private final String displayName;
    private final String description;

    VendorStatus(String displayName, String description) {
        this.displayName = displayName;
        this.description = description;
    }
}
