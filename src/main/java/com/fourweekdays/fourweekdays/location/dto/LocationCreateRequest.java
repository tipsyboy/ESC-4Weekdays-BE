package com.fourweekdays.fourweekdays.location.dto;

public record LocationCreateRequest(String zone, String section, Long vendorId, Integer capacity, String description) {
}
