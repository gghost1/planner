package com.example.demo.entity.activities;

import com.example.demo.dto.ActivityDto;
import com.example.demo.entity.elements.RpElements;
import com.jcabi.jdbc.JdbcSession;
import com.jcabi.jdbc.Outcome;
import com.jcabi.jdbc.SingleOutcome;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.UUID;

@Component
public class RpActivity {
    @Autowired
    public DataSource dataSource;
    @Autowired
    public RpElements rpElements;

    public Activity add(ActivityDto activityDto) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        UUID id = jdbcSession.sql("""
                INSERT INTO activities (information, passed, creation_date)
                VALUES (?, ?, ?)
                """)
                .set(activityDto.information())
                .set(false)
                .set(activityDto.creationDate())
                .insert(new SingleOutcome<>(UUID.class));
        jdbcSession.sql("""
                INSERT INTO user_activities (activity_id, user_id)
                VALUES (?, ?)
                """)
                .set(id)
                .set(activityDto.userId())
                .insert(Outcome.VOID);
        return new ActivityEntity(
                id,
                activityDto.information(),
                false,
                activityDto.creationDate(),
                dataSource,
                rpElements
        );
    }

    public Activity get(UUID id) throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        return jdbcSession
                .sql("""
                        SELECT * FROM activities
                        WHERE id = ?
                        """)
                .set(id)
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new ActivityEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("information"),
                                rset.getBoolean("passed"),
                                rset.getDate("creation_date").toLocalDate(),
                                dataSource,
                                rpElements
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });
    }

}
