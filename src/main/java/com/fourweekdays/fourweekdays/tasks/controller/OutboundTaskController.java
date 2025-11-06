package com.fourweekdays.fourweekdays.tasks.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskPickingCompleteRequest;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskPickingWorderAssignRequest;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskShipmentAssignShipperRequest;
import com.fourweekdays.fourweekdays.tasks.service.OutboundTaskService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/outbound-task")
@RequiredArgsConstructor
public class OutboundTaskController {

    private final OutboundTaskService outboundTaskService;

//    @PostMapping("/picking/{taskId}/assign-worker")
//    public ResponseEntity<BaseResponse<String>> assignWorker(@PathVariable Long taskId, @Valid @RequestBody TaskPickingWorderAssignRequest request) {
//        outboundTaskService.assignWorker(taskId, request);
//        return ResponseEntity.ok(BaseResponse.success("작업자 할당 완료"));
//    }

    @PostMapping("/picking/{taskId}/complete")
    public ResponseEntity<BaseResponse<String>> completePicking(@PathVariable Long taskId, @Valid @RequestBody TaskPickingCompleteRequest request) {
        outboundTaskService.completePicking(taskId, request);
        return ResponseEntity.ok(BaseResponse.success("피킹 완료"));
    }

    @PostMapping("/packing/{taskId}/complete")
    public ResponseEntity<BaseResponse<String>> completePacking(@PathVariable Long taskId, @Valid @RequestBody TaskPackingCompleteRequest request) {
        outboundTaskService.completePacking(taskId, request);
        return ResponseEntity.ok(BaseResponse.success("패킹 완료"));
    }

    @PostMapping("/shipment/{taskId}/assign-shipper")
    public ResponseEntity<BaseResponse<String>> assignShipper(@PathVariable Long taskId, @Valid @RequestBody TaskShipmentAssignShipperRequest request) {
        outboundTaskService.assignShipper(taskId, request);
        return ResponseEntity.ok(BaseResponse.success("출하 송하인 배정완료"));
    }

}
