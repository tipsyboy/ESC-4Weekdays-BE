package com.fourweekdays.fourweekdays.tasks.model.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
public class ShipmentTask {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long outboundId;

    @OneToOne
    @JoinColumn(name = "task_id")
    private Task task;

    private String shipper; // 배송에 대한 책임을 가지는 놈

    @Builder
    public ShipmentTask(Long outboundId, Task task, String shipper) {
        this.outboundId = outboundId;
        this.task = task;
        this.shipper = shipper;
    }

    public void assignShipper(String shipper) {
        this.shipper = shipper;
    }

}
