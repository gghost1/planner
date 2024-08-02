package com.example.demo.entity.elements;

import com.example.demo.dto.ElementDto;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.Outcome;
import com.jcabi.jdbc.SingleOutcome;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

@Component
public class RpElements {
    @Autowired
    private DataSource dataSource;

    public Element add(ElementDto elementDto) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        UUID id = jdbcSession
                .sql("""
                        INSERT INTO elements (information)
                        VALUES (?)
                        """)
                .set(elementDto.information())
                .insert(new SingleOutcome<>(UUID.class));
        jdbcSession.sql("""
                INSERT INTO activity_elements (element_id, activity_id)
                VALUES (?, ?)
                """)
                .set(id)
                .set(elementDto.activityId())
                .insert(Outcome.VOID);
        return new ElementEntity(id, elementDto.information());
    }

    public Element get(UUID id) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        return jdbcSession
                .sql("""
                        SELECT * FROM elements
                        WHERE id = ?
                        """)
                .set(id)
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
    }

}
