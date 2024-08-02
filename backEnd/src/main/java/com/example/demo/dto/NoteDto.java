package com.example.demo.dto;

import java.time.LocalDate;
import java.util.UUID;

public record NoteDto(
        UUID id,
        UUID userId,
        String text,
        LocalDate date
) {
    @Override
    public UUID userId() {
        return userId;
    }

    @Override
    public String text() {
        return text;
    }

    @Override
    public LocalDate date() {
        return date;
    }
}
