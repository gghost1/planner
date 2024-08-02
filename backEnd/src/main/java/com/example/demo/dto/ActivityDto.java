package com.example.demo.dto;

import java.time.LocalDate;
import java.util.UUID;

public record ActivityDto (
        UUID id,
        UUID userId,
        String information,
        boolean passed,
        LocalDate creationDate
) {
    @Override
    public UUID userId() {
        return userId;
    }

    @Override
    public String information() {
        return information;
    }

    @Override
    public LocalDate creationDate() {
        return creationDate;
    }
}
