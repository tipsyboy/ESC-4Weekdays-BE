package com.fourweekdays.fourweekdays.asn.dto;

import lombok.Builder;

@Builder
public record AsnReceiveResponse(String asnCode, String message) {
}
