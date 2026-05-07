package com.fourweekdays.fourweekdays.asn.repository;

import com.fourweekdays.fourweekdays.asn.dto.AsnSummaryResponse;

public interface AsnSummaryRepository {

    AsnSummaryResponse summarize(Long vendorId);
}
