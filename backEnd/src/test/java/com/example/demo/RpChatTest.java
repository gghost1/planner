package com.example.demo;

import com.example.demo.dto.ActivityDto;
import com.example.demo.dto.ChatDto;
import com.example.demo.dto.MessageDto;
import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.chats.Chat;
import com.example.demo.entity.chats.ChatEntity;
import com.example.demo.entity.chats.RpChat;
import com.example.demo.entity.messages.Message;
import com.example.demo.entity.messages.RpMessage;
import com.jcabi.jdbc.JdbcSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class RpChatTest {
    @Autowired
    private RpChat rpChat;
    @Autowired
    private RpActivity rpActivity;
    @Autowired
    private RpMessage rpMessage;
    @Autowired
    private DataSource dataSource;

    ChatDto chatDto = new ChatDto(
            UUID.randomUUID(),
            UUID.fromString("90318ea0-1139-4c01-8cd1-64bfba2d570c"),
            UUID.fromString("14b1af1d-17d6-45a7-bcff-b348a08d8fdb"),
            LocalDate.now()
    );

    @Test
    public void addChatTest() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        Chat chat = rpChat.add(chatDto);
        Chat expected = jdbcSession.sql("""
                SELECT * FROM chats
                WHERE id = ?
                """)
                .set(chat.id())
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new ChatEntity(
                                UUID.fromString(rset.getString("id")),
                                UUID.fromString(rset.getString("activity_id")),
                                rset.getDate("creation_date").toLocalDate(),
                                rpChat.dataSource,
                                rpChat.rpActivity,
                                rpChat.rpMessage
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }}
                );
        assertEquals(expected, chat);
    }

    @Test
    public void getChatByIdTest() throws SQLException {
        Chat chat = rpChat.add(chatDto);
        Chat expected = rpChat.get(chat.id());
        assertEquals(expected, chat);
    }

    @Test
    public void getChatActivity() throws SQLException {

        ActivityDto activityDto = new ActivityDto(
                UUID.randomUUID(),
                UUID.fromString("90318ea0-1139-4c01-8cd1-64bfba2d570c"),
                "test",
                false,
                LocalDate.now()
        );
        Activity activity = rpActivity.add(activityDto);

        Chat chat = rpChat.add(new ChatDto(
                UUID.randomUUID(),
                activityDto.userId(),
                activity.id(),
                activity.date()
        ));

        assertEquals(activity, chat.activity());
    }

    @Test
    public void getChatMessages() throws SQLException {
        Chat chat = rpChat.add(chatDto);

        List<Message> messages = new ArrayList<>();
        messages.add(rpMessage.add(new MessageDto(
                UUID.randomUUID(),
                chat.id(),
                "test1",
                LocalDate.now(),
                false
        )));
        messages.add(rpMessage.add(new MessageDto(
                UUID.randomUUID(),
                chat.id(),
                "test2",
                LocalDate.now(),
                true
        )));

        assertEquals(messages, chat.messages());
    }

}
