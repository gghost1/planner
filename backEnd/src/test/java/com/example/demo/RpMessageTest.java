package com.example.demo;

import com.example.demo.dto.MessageDto;
import com.example.demo.entity.messages.Message;
import com.example.demo.entity.messages.MessageEntity;
import com.example.demo.entity.messages.RpMessage;
import com.jcabi.jdbc.JdbcSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class RpMessageTest {

    @Autowired
    private RpMessage rpMessage;
    @Autowired
    private DataSource dataSource;


    private MessageDto messageDto = new MessageDto(
            UUID.randomUUID(),
            UUID.fromString("afd00986-7875-411f-9afe-eaf2c2048171"),
            "test",
            LocalDate.now(),
            true
    );

    @Test
    public void addMessageTest() throws SQLException {
        Message message = rpMessage.add(messageDto);
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        Message expected = jdbcSession.sql("""
                SELECT * FROM messages
                WHERE id = ?
                """)
                .set(message.id())
                .select((rset, stmt) -> {
                            if (rset.next()) {
                                return new MessageEntity(
                                        UUID.fromString(rset.getString("id")),
                                        rset.getString("text"),
                                        rset.getDate("creation_date").toLocalDate(), // Ensure field names match
                                        rset.getBoolean("systems")
                                );
                            } else {
                                throw new SQLException("No data found for the given ID");
                            }
                        }
                );
        assertEquals(expected, message);
    }

    @Test
    public void getMessageByIdTest() throws SQLException {
        Message message = rpMessage.add(messageDto);
        Message expected = rpMessage.get(message.id());

        assertEquals(expected, message);
    }
}
