CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
                       id       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                       phone    VARCHAR(255) NOT NULL,
                       name     VARCHAR(64) NOT NULL,
                       password VARCHAR(2048) NOT NULL
);

CREATE TABLE notes (
                       id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                       text          VARCHAR NOT NULL,
                       creation_date TIMESTAMP NOT NULL
);

CREATE TABLE user_notes (
                            note_id UUID NOT NULL REFERENCES notes(id),
                            user_id UUID NOT NULL REFERENCES users(id),
                            PRIMARY KEY (note_id, user_id)
);

CREATE TABLE activities (
                            id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                            information     VARCHAR NOT NULL,
                            passed          BOOLEAN NOT NULL,
                            creation_date   TIMESTAMP NOT NULL
);

CREATE TABLE elements (
                          id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                          information VARCHAR NOT NULL
);

CREATE TABLE activity_elements (
                                   element_id  UUID NOT NULL REFERENCES elements(id),
                                   activity_id UUID NOT NULL REFERENCES activities(id),
                                   PRIMARY KEY (element_id, activity_id)
);

CREATE TABLE user_activities (
                                 activity_id UUID NOT NULL REFERENCES activities(id),
                                 user_id     UUID NOT NULL REFERENCES users(id),
                                 PRIMARY KEY (activity_id, user_id)
);

CREATE TABLE chats (
                       id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                       activity_id     UUID NOT NULL REFERENCES activities(id),
                       creation_date   TIMESTAMP NOT NULL
);

CREATE TABLE messages (
                          id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                          text            VARCHAR NOT NULL,
                          creation_date   TIMESTAMP NOT NULL,
                          systems         BOOLEAN NOT NULL
);

CREATE TABLE chat_messages (
                               message_id      UUID NOT NULL REFERENCES messages(id),
                               chat_id         UUID NOT NULL REFERENCES chats(id),
                               PRIMARY KEY (message_id, chat_id)
);

CREATE TABLE user_chats (
                            chat_id         UUID NOT NULL REFERENCES chats(id),
                            user_id         UUID NOT NULL REFERENCES users(id),
                            PRIMARY KEY (chat_id, user_id)
);
