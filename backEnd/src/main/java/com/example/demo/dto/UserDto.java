package com.example.demo.dto;

import com.example.demo.SecurityBeans;

import java.util.UUID;

public record UserDto(
        UUID id,
        String name,
        String phone,
        String password
) {
    public UserDto (UUID id, String name, String phone, String password) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.password = SecurityBeans.encodePassword(password);
    }

    @Override
    public String name() {
        return name;
    }

    @Override
    public String phone() {
        return phone;
    }

    @Override
    public String password() {
        return password;
    }
}
