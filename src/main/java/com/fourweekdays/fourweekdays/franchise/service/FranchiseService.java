package com.fourweekdays.fourweekdays.franchise.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.franchise.exception.FranchiseException;
import com.fourweekdays.fourweekdays.franchise.model.dto.request.FranchiseCreateDto;
import com.fourweekdays.fourweekdays.franchise.model.dto.response.FranchiseReadDto;
import com.fourweekdays.fourweekdays.franchise.model.entity.FranchiseStore;
import com.fourweekdays.fourweekdays.franchise.repository.FranchiseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.franchise.exception.FranchiseExceptionType.FRANCHISE_NOT_FOUND;

@Service
@RequiredArgsConstructor
public class FranchiseService {

    public static final String FRANCHISE_CODE_PREFIX = "F";

    private final FranchiseRepository franchiseRepository;
    private final CodeGenerator codeGenerator;

    @Transactional
    public Long create(FranchiseCreateDto dto) {
        FranchiseStore result = franchiseRepository.save(dto.toEntity(codeGenerator.generate(FRANCHISE_CODE_PREFIX)));
        return result.getId();
    }

    public FranchiseReadDto read(Long id) {
        FranchiseStore entity = franchiseRepository.findById(id).orElseThrow(() -> new FranchiseException(FRANCHISE_NOT_FOUND));
        return FranchiseReadDto.from(entity);
    }

    public Page<FranchiseReadDto> readAll(Integer page, Integer size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<FranchiseStore> result = franchiseRepository.findAllWithPaging(pageable);
        return result.map(FranchiseReadDto::from);
    }
}
