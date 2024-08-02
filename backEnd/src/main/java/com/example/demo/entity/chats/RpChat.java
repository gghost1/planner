package com.example.demo.entity.chats;

import com.example.demo.dto.ChatDto;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.messages.RpMessage;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.Outcome;
import com.jcabi.jdbc.SingleOutcome;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

@Component
public class RpChat {
    @Autowired
    public DataSource dataSource;
    @Autowired
    public RpActivity rpActivity;
    @Autowired
    public RpMessage rpMessage;

    public Chat add(ChatDto chatDto) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        UUID id = jdbcSession.sql("""
                INSERT INTO chats (activity_id, creation_date)
                VALUES (?, ?)
                """)
                .set(chatDto.activityId())
                .set(chatDto.creationDate())
                .insert(new SingleOutcome<>(UUID.class));

        jdbcSession.sql("""
                INSERT INTO user_chats (chat_id, user_id)
                VALUES (?, ?)
                """)
                .set(id)
                .set(chatDto.userId())
                .insert(Outcome.VOID);
        return new ChatEntity(
                id,
                chatDto.activityId(),
                chatDto.creationDate(),
                dataSource,
                rpActivity,
                rpMessage);
    }

    public Chat get(UUID id) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        return jdbcSession
                .sql("""
                        SELECT * FROM chats
                        WHERE id = ?
                        """)
                .set(id)
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new ChatEntity(
                                UUID.fromString(rset.getString("id")),
                                UUID.fromString(rset.getString("activity_id")),
                                rset.getDate("creation_date").toLocalDate(),
                                dataSource,
                                rpActivity,
                                rpMessage
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });
    }

}
