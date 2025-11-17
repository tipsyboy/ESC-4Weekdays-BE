CREATE TABLE seq_generator (
                               prefix VARCHAR(50) PRIMARY KEY,
                               current_value INT
);

INSERT INTO seq_generator(prefix, current_value) VALUES('ORD', 0);