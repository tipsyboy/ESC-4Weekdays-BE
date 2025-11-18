package com.fourweekdays.fourweekdays.common.generator.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Entity
@Table(name = "seq_generator")
public class Sequence {

    @Id
    private String prefix;

    private int currentValue;

    private String lastDate;

    public void increase() {
        this.currentValue++;
    }

    public void reset(String newDate) {
        this.currentValue = 0;
        this.lastDate = newDate;
    }
}
