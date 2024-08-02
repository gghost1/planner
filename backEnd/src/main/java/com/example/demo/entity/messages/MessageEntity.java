package com.example.demo.entity.messages;

import java.time.LocalDate;
import java.util.UUID;

public record MessageEntity(
        UUID id,
        String text,
        LocalDate date,
        boolean systems
) implements Message {
}
