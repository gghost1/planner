package com.example.demo.entity.activities;

import com.example.demo.entity.elements.Element;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface Activity {
    UUID id();
    String information();
    boolean passed();
    LocalDate date();
    List<Element> elements() throws SQLException;
}
