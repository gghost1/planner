package com.example.demo.entity.activities;

import com.example.demo.entity.chats.Chat;
import com.example.demo.entity.chats.ChatEntity;
import com.example.demo.entity.chats.RpChat;
import com.example.demo.entity.elements.Element;
import com.example.demo.entity.elements.RpElements;
import com.jcabi.jdbc.JdbcSession;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public record ActivityEntity(
        UUID id,
        String information,
        boolean passed,
        LocalDate date,
        DataSource dataSource,
        RpElements rpElements,
        RpChat rpChat
) implements Activity {
    @Override
    public List<Element> elements() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        List<UUID> elementIds = jdbcSession.sql("""
                SELECT element_id FROM activity_elements
                WHERE activity_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    List<UUID> ids = new ArrayList<>();
                    while (rset.next()) {
                        ids.add(UUID.fromString(rset.getString("element_id")));
                    }
                    return ids;
                });
        return elementIds.stream().map(id -> {
            try {
                return rpElements.get(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }).toList();
    }

    @Override
    public Chat chat() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        UUID chatId = jdbcSession.sql("""
                SELECT chat_id FROM activity_chats
                WHERE activity_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return UUID.fromString(rset.getString("chat_id"));
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });

        return rpChat.get(chatId);
    }
}
