package com.example.demo;

import com.example.demo.dto.ActivityDto;
import com.example.demo.dto.ChatDto;
import com.example.demo.dto.NoteDto;
import com.example.demo.dto.UserDto;
import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.chats.Chat;
import com.example.demo.entity.chats.RpChat;
import com.example.demo.entity.messages.RpMessage;
import com.example.demo.entity.notes.Note;
import com.example.demo.entity.notes.RpNote;
import com.example.demo.entity.user.RpUser;
import com.example.demo.entity.user.User;
import com.example.demo.entity.user.UserEntity;
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
public class RpUserTest {
    @Autowired
    private RpUser rpUser;
    @Autowired
    private RpNote rpNote;
    @Autowired
    private RpActivity rpActivity;
    @Autowired
    private RpChat rpChat;
    @Autowired
    private DataSource dataSource;

    UserDto userDto = new UserDto(
            UUID.randomUUID(),
            "test",
            "test",
            "test"
    );

    @Test
    public void addUserTest() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        User user = rpUser.add(userDto);

        User expected = jdbcSession.sql("""
                            SELECT * from users
                            WHERE id = ?
                            """)
                .set(user.id())
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new UserEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("name"),
                                rset.getString("phone"),
                                rset.getString("password"),
                                rpUser.dataSource,
                                rpUser.rpNote,
                                rpUser.rpActivity,
                                rpUser.rpChat
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });
        assertEquals(expected, user);
    }

    @Test
    public void getUserByIdTest() throws SQLException {
        User user = rpUser.add(userDto);
        User expected = rpUser.get(user.id());
        assertEquals(expected, user);
    }

    @Test
    public void getUserNoteTest() throws SQLException {
        User user = rpUser.add(userDto);

        List<Note> notes = new ArrayList<>();
        notes.add(rpNote.add(new NoteDto(
                UUID.randomUUID(),
                user.id(),
                "test1",
                LocalDate.now()
        )));
        notes.add(rpNote.add(new NoteDto(
                UUID.randomUUID(),
                user.id(),
                "test2",
                LocalDate.now()
        )));
        assertEquals(notes, user.notes());
    }

    @Test
    public void getUserActivityTest() throws SQLException {
        User user = rpUser.add(userDto);

        List<Activity> activities = new ArrayList<>();
        activities.add(rpActivity.add(new ActivityDto(
                UUID.randomUUID(),
                user.id(),
                "test1",
                false,
                LocalDate.now()
        )));
        activities.add(rpActivity.add(new ActivityDto(
                UUID.randomUUID(),
                user.id(),
                "test2",
                false,
                LocalDate.now()
        )));
        assertEquals(activities, user.activities());
    }

    @Test
    public void getUserChatTest() throws SQLException {
        User user = rpUser.add(userDto);

        List<Activity> activities = new ArrayList<>();
        activities.add(rpActivity.add(new ActivityDto(
                UUID.randomUUID(),
                user.id(),
                "test1",
                false,
                LocalDate.now()
        )));
        activities.add(rpActivity.add(new ActivityDto(
                UUID.randomUUID(),
                user.id(),
                "test2",
                false,
                LocalDate.now()
        )));

        List<Chat> chats = new ArrayList<>();
        chats.add(rpChat.add(new ChatDto(
                UUID.randomUUID(),
                user.id(),
                activities.get(0).id(),
                LocalDate.now()
        )));
        chats.add(rpChat.add(new ChatDto(
                UUID.randomUUID(),
                user.id(),
                activities.get(1).id(),
                LocalDate.now()
        )));
        assertEquals(chats, user.chats());
    }
}
