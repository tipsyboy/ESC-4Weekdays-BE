package com.fourweekdays.fourweekdays.order.contorller;

import com.fourweekdays.fourweekdays.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/order")
@RequiredArgsConstructor
public class OrderApiAdminController {

    private final OrderService orderService;
    // 조회를 먼저 구현하고 단지 @AuthenticatedFranchise를 받고 필터를 타는 조회로 만들면 될것 같음
}
