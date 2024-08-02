package com.example.demo.entity.messages;

import com.example.demo.dto.MessageDto;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.Outcome;
import com.jcabi.jdbc.SingleOutcome;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

@Component
public class RpMessage {
    @Autowired
    private DataSource dataSource;

    public Message add(MessageDto message) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource).autocommit(true);
        UUID id = jdbcSession
                .sql("""
                        INSERT INTO messages (text, creation_date, systems)
                        VALUES (?, ?, ?)
                        """)
                .set(message.text())
                .set(message.creationDate())
                .set(message.systems())
                .insert(new SingleOutcome<>(UUID.class));
        jdbcSession.sql("""
                INSERT INTO chat_messages (message_id, chat_id)
                VALUES (?, ?)
                """)
                .set(id)
                .set(message.chatId())
                .insert(Outcome.VOID);
        return new MessageEntity(id, message.text(), message.creationDate(), message.systems());
    }

    public Message get(UUID id) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        return jdbcSession
                .sql("""
                        SELECT * FROM messages
                        WHERE id = ?
                        """)
                .set(id)
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new MessageEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("text"),
                                rset.getDate("creation_date").toLocalDate(),
                                rset.getBoolean("systems")
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });
    }
}
