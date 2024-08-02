package com.example.demo;

import com.example.demo.dto.ElementDto;
import com.example.demo.entity.elements.Element;
import com.example.demo.entity.elements.ElementEntity;
import com.example.demo.entity.elements.RpElements;
import com.example.demo.entity.messages.RpMessage;
import com.jcabi.jdbc.JdbcSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class RpElementsTest {
    @Autowired
    private RpElements rpElements;
    @Autowired
    private DataSource dataSource;

    ElementDto elementDto = new ElementDto(
            UUID.randomUUID(),
            UUID.fromString("14b1af1d-17d6-45a7-bcff-b348a08d8fdb"),
            "test"
    );

    @Test
    public void addElement() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        Element element = rpElements.add(elementDto);
        Element expected = jdbcSession.sql("""
                SELECT * FROM elements
                WHERE id = ?
                """)
                .set(element.id())
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new ElementEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("information")
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });

        assertEquals(expected, element);
    }

    @Test
    public void getElementById() throws SQLException {
        Element element = rpElements.add(elementDto);
        Element expected = rpElements.get(element.id());
        assertEquals(expected, element);
    }

}
