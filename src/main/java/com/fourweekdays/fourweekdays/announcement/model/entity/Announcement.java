package com.fourweekdays.fourweekdays.announcement.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;



@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Announcement extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title; // 제목

    @Column(nullable = false)
    private String content; // 내용

    @Builder.Default
    private Boolean active = true ;

    public void update(String title, String content) {
        if (title != null) this.title = title;
        if (content != null) this.content = content;
    }
    public void isActive() {
        this.active = false;
    }
}