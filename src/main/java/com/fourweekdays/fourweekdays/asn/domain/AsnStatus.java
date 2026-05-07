package com.fourweekdays.fourweekdays.asn.domain;

public enum AsnStatus {
    // 발주 이후 아직 ASN 회신을 기다리는 상태
    WAITING,
    // 공급업체 회신이 접수되어 내부 확인이 필요한 상태
    RECEIVED,
    // 공급업체가 발주 대응이 불가하다고 회신한 상태
    REJECTED,
    // 입고예정 생성까지 완료된 상태
    SCHEDULED,
    // 기존 데이터 호환용 상태. 응답에서는 SCHEDULED로 취급한다.
    ACCEPTED
}
