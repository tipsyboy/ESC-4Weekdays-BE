package com.fourweekdays.fourweekdays.global.util;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum CodeType {
    VENDOR("V"),
    PRODUCT("P"),
    PURCHASE_ORDER("PO"),
    ASN("ASN"),
    INBOUND("INB"),
    FRANCHISE("FRA"),
    ORDER("ORD"),
    OUTBOUND("OB");

    private final String prefix;
}
