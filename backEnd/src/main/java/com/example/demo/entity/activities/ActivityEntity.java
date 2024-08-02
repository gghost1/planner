package com.example.demo.entity.activities;

import com.example.demo.entity.elements.Element;
import com.example.demo.entity.elements.RpElements;
import com.jcabi.jdbc.JdbcSession;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public record ActivityEntity(
        UUID id,
        String information,
        boolean passed,
        LocalDate date,
        DataSource dataSource,
        RpElements rpElements
) implements Activity {
    @Override
    public List<Element> elements() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        List<UUID> elementIds = jdbcSession.sql("""
                SELECT element_id FROM activity_elements
                WHERE activity_id = ?
                """)
                .set(id)
                .select((rset, stmt) -> {
                    List<UUID> ids = new ArrayList<>();
                    while (rset.next()) {
                        ids.add(UUID.fromString(rset.getString("element_id")));
                    }
                    return ids;
                });
        return elementIds.stream().map(id -> {
            try {
                return rpElements.get(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }).toList();
    }
}
