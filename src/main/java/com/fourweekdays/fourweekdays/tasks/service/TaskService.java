package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.exception.MemberExceptionType;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.tasks.factory.InboundTaskFactory;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.AssignRequest;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.tasks.repository.InboundTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;

@RequiredArgsConstructor
@Service
public class TaskService {

    private final TaskRepository taskRepository;
    private final InboundTaskRepository inboundTaskRepository;
    private final InboundRepository inboundRepository;
    private final InboundTaskFactory inboundTaskFactory;
    private final MemberRepository memberRepository;

    @Transactional
    public void assignWorker(Long taskId, AssignRequest request) {
        Task task = taskRepository.findById(taskId).orElseThrow();
        Member worker = memberRepository.findById(request.memberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));
        task.assignTo(worker);
    }
}
