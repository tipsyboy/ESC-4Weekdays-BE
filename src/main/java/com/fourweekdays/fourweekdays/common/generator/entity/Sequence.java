package com.fourweekdays.fourweekdays.common.generator.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Entity
@Table(name = "seq_generator")
public class Sequence {

    @Id
    private String prefix;       // 예: "ORD", "ASN" 등
    private int currentValue;    // 현재 시퀀스 값

    public Sequence(String prefix, int currentValue) {
        this.prefix = prefix;
        this.currentValue = currentValue;
    }

    public void increase() {
        this.currentValue++;
    }
}
