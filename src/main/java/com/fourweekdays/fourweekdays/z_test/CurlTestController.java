package com.fourweekdays.fourweekdays.z_test;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/blue-green/test")
public class CurlTestController {

    @GetMapping
    public String newVersionTest() {
        return "blue";
    }
}
