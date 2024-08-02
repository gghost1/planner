package com.example.demo.entity.user;

import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.chats.Chat;
import com.example.demo.entity.chats.RpChat;
import com.example.demo.entity.notes.Note;
import com.example.demo.entity.notes.RpNote;
import com.example.demo.entity.user.User;
import com.jcabi.jdbc.JdbcSession;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public record UserEntity(
        UUID id,
        String name,
        String phone,
        String password,
        DataSource dataSource,
        RpNote rpNote,
        RpActivity rpActivity,
        RpChat rpChat
) implements User {
    @Override
    public List<Note> notes() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        List<UUID> noteIds = jdbcSession.sql("""
                SELECT note_id FROM user_notes
                WHERE user_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    List<UUID> ids = new ArrayList<>();
                    while (rset.next()) {
                        ids.add(UUID.fromString(rset.getString("note_id")));
                    }
                    return ids;
                });

        return noteIds.stream().map(id -> {
            try {
                return rpNote.get(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }).toList();
    }

    @Override
    public List<Activity> activities() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        List<UUID> activityIds = jdbcSession.sql("""
                SELECT activity_id FROM user_activities
                WHERE user_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    List<UUID> ids = new ArrayList<>();
                    while (rset.next()) {
                        ids.add(UUID.fromString(rset.getString("activity_id")));
                    }
                    return ids;
                });

        return activityIds.stream().map(id -> {
            try {
                return rpActivity.get(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }).toList();
    }

    @Override
    public List<Chat> chats() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        List<UUID> chatIds = jdbcSession.sql("""
                SELECT chat_id FROM user_chats
                WHERE user_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    List<UUID> ids = new ArrayList<>();
                    while (rset.next()) {
                        ids.add(UUID.fromString(rset.getString("chat_id")));
                    }
                    return ids;
                });

        return chatIds.stream().map(id -> {
            try {
                return rpChat.get(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }).toList();
    }
}
