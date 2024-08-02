package com.example.demo;

import com.example.demo.dto.ActivityDto;
import com.example.demo.dto.ElementDto;
import com.example.demo.dto.MessageDto;
import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.activities.ActivityEntity;
import com.example.demo.entity.activities.RpActivity;
import com.example.demo.entity.elements.Element;
import com.example.demo.entity.elements.RpElements;
import com.example.demo.entity.messages.RpMessage;
import com.jcabi.jdbc.JdbcSession;
import org.checkerframework.checker.units.qual.A;
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
public class RpActivityTest {

    @Autowired
    private RpActivity rpActivity;
    @Autowired
    private RpElements rpElements;
    @Autowired
    private DataSource dataSource;

    ActivityDto activityDto = new ActivityDto(
            UUID.randomUUID(),
            UUID.fromString("90318ea0-1139-4c01-8cd1-64bfba2d570c"),
            "test",
            false,
            LocalDate.now()
    );

    @Test
    public void addActivityTest() throws SQLException {
        JdbcSession jdbcSession = new JdbcSession(dataSource);
        Activity activity = rpActivity.add(activityDto);
        Activity expected = jdbcSession.sql("""
                SELECT * FROM activities
                WHERE id = ?
                """)
                .set(activity.id())
                .select((rset, stmt) -> {
                    if (rset.next()) {
                        return new ActivityEntity(
                                UUID.fromString(rset.getString("id")),
                                rset.getString("information"),
                                rset.getBoolean("passed"),
                                rset.getDate("creation_date").toLocalDate(),
                                rpActivity.dataSource,
                                rpActivity.rpElements
                        );
                    } else {
                        throw new SQLException("No data found for the given ID");
                    }
                });

        assertEquals(expected, activity);
    }

    @Test
    public void getActivityById() throws SQLException {
        Activity activity = rpActivity.add(activityDto);
        Activity expected = rpActivity.get(activity.id());
        assertEquals(expected, activity);
    }

    @Test
    public void getActivityElements() throws SQLException {
        Activity activity = rpActivity.add(activityDto);

        List<Element> elements = new ArrayList<>();

        elements.add(rpElements.add(new ElementDto(
                UUID.randomUUID(),
                activity.id(),
                "test1"
        )));
        elements.add(rpElements.add(new ElementDto(
                UUID.randomUUID(),
                activity.id(),
                "test2"
        )));

        assertEquals(elements, activity.elements());
    }

}
