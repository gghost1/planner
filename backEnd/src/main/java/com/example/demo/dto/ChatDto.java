package com.example.demo.dto;

import java.time.LocalDate;
import java.util.UUID;

public record ChatDto(
        UUID id,
        UUID userId,
        UUID activityId,
        LocalDate creationDate
) {
    @Override
    public UUID activityId() {
        return activityId;
    }

    @Override
    public LocalDate creationDate() {
        return creationDate;
    }

    @Override
    public UUID userId() {
        return userId;
    }
}
