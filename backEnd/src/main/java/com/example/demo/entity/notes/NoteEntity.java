package com.example.demo.entity.notes;

import java.time.LocalDate;
import java.util.UUID;

public record NoteEntity(
        UUID id,
        String text,
        LocalDate date
) implements Note {

}
