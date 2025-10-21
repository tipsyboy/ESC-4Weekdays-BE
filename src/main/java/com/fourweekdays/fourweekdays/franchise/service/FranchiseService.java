package com.fourweekdays.fourweekdays.franchise.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.franchise.model.dto.request.FranchiseCreateDto;
import com.fourweekdays.fourweekdays.franchise.model.entity.FranchiseStore;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
}
