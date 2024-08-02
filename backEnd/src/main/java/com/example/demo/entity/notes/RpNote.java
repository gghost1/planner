package com.example.demo.entity.notes;

import com.example.demo.dto.NoteDto;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.Outcome;
import com.jcabi.jdbc.SingleOutcome;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

@Component
public class RpNote {
    @Autowired
    private DataSource dataSource;

    public Note add(NoteDto note) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        UUID id = jdbcSession.sql("""
                    INSERT INTO notes (text, creation_date)
                    VALUES (?, ?)
                    """)
                .set(note.text())
                .set(note.date())
                .insert(new SingleOutcome<>(UUID.class));
        jdbcSession.sql("""
                INSERT INTO user_notes (user_id, note_id)
                VALUES (?, ?)
                """)
                .set(note.userId())
                .set(id)
                .insert(Outcome.VOID);
        return new NoteEntity(id, note.text(), note.date());
    }

    public Note get(UUID id) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        return jdbcSession
                .sql("""
                        SELECT * FROM notes
                        WHERE id = ?
                        """)
                .set(id)
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new NoteEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("text"),
                                rset.getDate("creation_date").toLocalDate()
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });
    }

}
