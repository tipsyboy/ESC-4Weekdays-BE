package com.fourweekdays.fourweekdays.announcement.model.dto.response;

import com.fourweekdays.fourweekdays.announcement.model.entity.Announcement;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class AnnouncementReadDto {
    private Long id;
    private String title;
    private String content;

    public static AnnouncementReadDto from(Announcement entity) {
        return AnnouncementReadDto.builder()
                .id(entity.getId())
                .title(entity.getTitle())
                .content(entity.getContent())
                .build();
    };
}

