package com.example.demo.entity.elements;

import java.util.UUID;

public record ElementEntity(
        UUID id,
        String information
) implements Element {
}
