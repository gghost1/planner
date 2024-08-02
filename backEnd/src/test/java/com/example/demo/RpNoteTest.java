package com.example.demo;

import com.example.demo.dto.NoteDto;
import com.example.demo.entity.messages.RpMessage;
import com.example.demo.entity.notes.Note;
import com.example.demo.entity.notes.NoteEntity;
import com.example.demo.entity.notes.RpNote;
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
public class RpNoteTest {
    @Autowired
    private RpNote rpNote;
    @Autowired
    private DataSource dataSource;

    NoteDto noteDto = new NoteDto(
            UUID.randomUUID(),
            UUID.fromString("90318ea0-1139-4c01-8cd1-64bfba2d570c"),
            "test",
            LocalDate.now()
    );

    @Test
    public void addNoteTest() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        Note note = rpNote.add(noteDto);
        Note expected = jdbcSession.sql("""
                SELECT * FROM notes
                WHERE id = ?
                """)
                .set(note.id())
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
        assertEquals(expected, note);
    }

    @Test
    public void getNoteByIdTest() throws SQLException {
        Note note = rpNote.add(noteDto);
        Note expected = rpNote.get(note.id());
        assertEquals(expected, note);
    }

}
