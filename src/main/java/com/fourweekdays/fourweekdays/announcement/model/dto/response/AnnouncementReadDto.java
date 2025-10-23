package com.fourweekdays.fourweekdays.announcement.model.dto.response;

import com.fourweekdays.fourweekdays.announcement.model.entity.Announcement;

import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class AnnouncementReadDto {
    private Long id;
    private String name;
    private String title;
    private String content;
    private boolean active;
    private LocalDateTime createdAt;

    public static AnnouncementReadDto from(Announcement entity) {
        return AnnouncementReadDto.builder()
                .id(entity.getId())
                .name(entity.getName())
                .title(entity.getTitle())
                .content(entity.getContent())
                .active(Boolean.TRUE.equals(entity.getActive()))
                .createdAt(entity.getCreatedAt())
                .build();
    };
}

