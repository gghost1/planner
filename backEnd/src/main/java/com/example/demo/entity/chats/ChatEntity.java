package com.example.demo.entity.chats;

import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.messages.Message;
import com.example.demo.entity.messages.RpMessage;
import com.jcabi.jdbc.JdbcSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public record ChatEntity(
        UUID id,
        UUID activityId,
        LocalDate date,
        DataSource dataSource,
        RpActivity rpActivity,
        RpMessage rpMessage
) implements Chat {

    @Override
    public Activity activity() throws SQLException {
        return rpActivity.get(activityId);
    }

    @Override
    public List<Message> messages() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        List<UUID> messageIds = jdbcSession.sql("""
                SELECT message_id FROM chat_messages
                WHERE chat_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    List<UUID> ids = new ArrayList<>();
                    while (rset.next()) {
                        ids.add(UUID.fromString(rset.getString("message_id")));
                    }
                    return ids;
                });
        return messageIds.stream().map(id -> {
            try {
                return rpMessage.get(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }).toList();
    }
}
