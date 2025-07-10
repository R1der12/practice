CREATE TABLE IF NOT EXISTS "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO "user" (name) VALUES
('test'),
('Andrei Olegovich'),
('Dmity'),
('Maksim');
