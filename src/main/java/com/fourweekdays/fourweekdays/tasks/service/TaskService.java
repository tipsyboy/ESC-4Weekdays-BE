package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.inbound.exception.InboundException;
import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.tasks.exception.TaskException;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskAssignRequest;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskCompleteRequest;
import com.fourweekdays.fourweekdays.tasks.model.dto.response.TaskDetailResponse;
import com.fourweekdays.fourweekdays.tasks.model.dto.response.TaskResponse;
import com.fourweekdays.fourweekdays.tasks.model.entity.InspectionTask;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.tasks.repository.InspectionTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_NOT_FOUND;
import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.*;

@Transactional(readOnly = true)
@RequiredArgsConstructor
@Service
public class TaskService {

    private final TaskRepository taskRepository;
    private final InspectionTaskRepository inspectionTaskRepository;
    private final MemberRepository memberRepository;
    private final InboundRepository inboundRepository;

    @Transactional
    public void assignWorker(Long taskId, TaskAssignRequest request) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new TaskException(TASK_NOT_FOUND));

        Member worker = memberRepository.findById(request.memberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        task.assignTo(worker);
    }

    @Transactional
    public void startTask(Long taskId) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new TaskException(TASK_NOT_FOUND));

        task.start();
    }

    @Transactional
    public void completeTask(Long taskId, TaskCompleteRequest request) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new TaskException(TASK_NOT_FOUND));

        task.complete(request.note());

        // TODO: Inbound 상태 변경 (INSPECTING → PUTAWAY)
        // InspectionTask inspectionTask = inspectionTaskRepository.findByTaskId(taskId)
        //     .orElseThrow(() -> new TaskException(INSPECTION_TASK_NOT_FOUND));
        // inboundService.updateStatus(inspectionTask.getInboundId(), InboundStatus.PUTAWAY);
    }

    @Transactional
    public void cancelTask(Long taskId, String reason) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new TaskException(TASK_NOT_FOUND));

        task.cancel(reason);
    }

    public TaskDetailResponse getTaskDetail(Long taskId) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow(() -> new TaskException(TASK_NOT_FOUND));

        // TODO: 다른 작업들에 대해서 확장
        InspectionTask detail = inspectionTaskRepository.findByTaskId(task.getId())
                .orElseThrow(() -> new TaskException(INSPECTION_TASK_NOT_FOUND));

        Inbound inbound = inboundRepository.findById(detail.getInboundId())
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));

        return TaskDetailResponse.ofInspection(task, detail, inbound);
    }
}
