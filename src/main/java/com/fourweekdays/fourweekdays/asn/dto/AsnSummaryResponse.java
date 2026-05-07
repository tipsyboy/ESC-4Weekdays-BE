package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import java.util.List;

public record AsnSummaryResponse(
        long totalCount,
        long waitingCount,
        long receivedCount,
        long scheduledCount,
        long rejectedCount
) {
    public static AsnSummaryResponse from(List<AsnListResponse> asns) {
        long totalCount = asns.size();
        long waitingCount = asns.stream().filter(asn -> asn.status() == AsnStatus.WAITING).count();
        long receivedCount = asns.stream().filter(asn -> asn.status() == AsnStatus.RECEIVED).count();
        long scheduledCount = asns.stream().filter(asn -> asn.status() == AsnStatus.SCHEDULED).count();
        long rejectedCount = asns.stream().filter(asn -> asn.status() == AsnStatus.REJECTED).count();

        return new AsnSummaryResponse(totalCount, waitingCount, receivedCount, scheduledCount, rejectedCount);
    }
}
