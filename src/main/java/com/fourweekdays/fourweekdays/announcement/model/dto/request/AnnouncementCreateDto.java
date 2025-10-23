package com.fourweekdays.fourweekdays.announcement.model.dto.request;

import com.fourweekdays.fourweekdays.announcement.model.entity.Announcement;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class AnnouncementCreateDto {

    private String title;
    private String content;

    public Announcement toEntity(String name) {
        return Announcement.builder()
                .name(name)
                .title(title)
                .content(content)
                .build();
    }
}
