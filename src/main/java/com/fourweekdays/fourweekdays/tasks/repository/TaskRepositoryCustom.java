package com.fourweekdays.fourweekdays.tasks.repository;

import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.LocalDate;

public interface TaskRepositoryCustom {

    Page<Task> findAllWithPaging(Pageable pageable);

}
