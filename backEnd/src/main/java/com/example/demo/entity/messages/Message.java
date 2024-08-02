package com.example.demo.entity.messages;

import java.time.LocalDate;
import java.util.UUID;

public interface Message {
    UUID id();
    String text();
    LocalDate date();
    boolean systems();
}
