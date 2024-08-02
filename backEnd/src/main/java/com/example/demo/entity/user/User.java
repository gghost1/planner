package com.example.demo.entity.user;

import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.chats.Chat;
import com.example.demo.entity.notes.Note;

import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

public interface User {
    UUID id();
    String name();
    String phone();
    List<Note> notes() throws SQLException;
    List<Activity> activities() throws SQLException;
    List<Chat> chats() throws SQLException;
}
