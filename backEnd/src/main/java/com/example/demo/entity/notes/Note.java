package com.example.demo.entity.notes;

import java.time.LocalDate;
import java.util.UUID;

public interface Note {
    UUID id();
    String text();
    LocalDate date();
}
