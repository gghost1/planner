package com.example.demo.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDate;
import java.util.UUID;

public record MessageDto(
    UUID id,
    UUID chatId,
    String text,
    LocalDate creationDate,
    boolean systems
) {
    @Override
    public String text() {
        return text;
    }

    @Override
    public LocalDate creationDate() {
        return creationDate;
    }

    @Override
    public boolean systems() {
        return systems;
    }
}
