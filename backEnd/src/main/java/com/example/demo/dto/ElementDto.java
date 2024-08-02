package com.example.demo.dto;

import java.util.UUID;

public record ElementDto (
        UUID id,
        UUID activityId,
        String information
) {
    @Override
    public UUID activityId() {
        return activityId;
    }

    @Override
    public String information() {
        return information;
    }
}
