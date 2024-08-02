package com.example.demo.entity.chats;

import com.example.demo.entity.activities.Activity;
import com.example.demo.entity.messages.Message;
import com.example.demo.entity.messages.RpMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Component
public interface Chat {
    @Autowired
    default RpMessage getRpMessage(RpMessage rpMessage) {
        return rpMessage;
    }

    UUID id();
    LocalDate date();
    Activity activity() throws SQLException;
    List<Message> messages() throws SQLException;
}
