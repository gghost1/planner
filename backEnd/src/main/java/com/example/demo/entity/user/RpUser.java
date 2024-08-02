package com.example.demo.entity.user;

import com.example.demo.dto.UserDto;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.chats.RpChat;
import com.example.demo.entity.notes.RpNote;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.SingleOutcome;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

@Component
public class RpUser {
    @Autowired
    public DataSource dataSource;
    @Autowired
    public RpNote rpNote;
    @Autowired
    public RpActivity rpActivity;
    @Autowired
    public RpChat rpChat;

    public User add(UserDto user) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        UUID id = jdbcSession.sql("""
                        INSERT INTO users (name, phone, password)
                        VALUES (?, ?, ?)
                        """)
                .set(user.name())
                .set(user.phone())
                .set(user.password())
                .insert(new SingleOutcome<>(UUID.class));
        return new UserEntity(
                id,
                user.name(),
                user.phone(),
                user.password(),
                dataSource,
                rpNote,
                rpActivity,
                rpChat
        );
    }

    public User get(UUID id) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        return jdbcSession
                .sql("""
                        SELECT * FROM users
                        WHERE id = ?
                        """)
                .set(id)
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new UserEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("name"),
                                rset.getString("phone"),
                                rset.getString("password"),
                                dataSource,
                                rpNote,
                                rpActivity,
                                rpChat
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });
    }
}
