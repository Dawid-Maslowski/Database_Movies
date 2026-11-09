-- Włączenie obsługi kluczy obcych w SQLite
PRAGMA foreign_keys = ON;

-- Tabela gatunków filmowych
CREATE TABLE IF NOT EXISTS genres (
    genre_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- Tabela filmów
CREATE TABLE IF NOT EXISTS movies (
    movie_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    release_year INTEGER CHECK(release_year > 1800),
    duration_minutes INTEGER CHECK(duration_minutes > 0),
    rating REAL CHECK(rating >= 0 AND rating <= 10)
);

-- Tabela osób (aktorzy, reżyserzy, ekipa)
CREATE TABLE IF NOT EXISTS persons (
    person_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_date TEXT 
);

-- Tabela łącząca filmy z gatunkami (wiele-do-wielu)
CREATE TABLE IF NOT EXISTS movie_genres (
    movie_id INTEGER,
    genre_id INTEGER,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

-- Tabela łącząca filmy z osobami i ich rolami (wiele-do-wielu)
CREATE TABLE IF NOT EXISTS movie_cast (
    movie_id INTEGER,
    person_id INTEGER,
    role TEXT NOT NULL, 
    character_name TEXT, 
    PRIMARY KEY (movie_id, person_id, role),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES persons(person_id) ON DELETE CASCADE
);

-- Dodawanie gatunków
INSERT INTO genres (name) VALUES 
('Sci-Fi'), ('Dramat'), ('Akcja'), ('Kryminał');

-- Dodawanie filmów
INSERT INTO movies (title, release_year, duration_minutes, rating) VALUES 
('Incepcja', 2010, 148, 8.8),
('Skazani na Shawshank', 1994, 142, 9.3),
('Matrix', 1999, 136, 8.7);

-- Dodawanie osób
INSERT INTO persons (first_name, last_name, birth_date) VALUES 
('Christopher', 'Nolan', '1970-07-30'),
('Leonardo', 'DiCaprio', '1974-11-11'),
('Frank', 'Darabont', '1959-01-28'),
('Tim', 'Robbins', '1958-10-16'),
('Lana', 'Wachowski', '1965-06-21'),
('Keanu', 'Reeves', '1964-09-02');

-- Powiązania filmów z gatunkami
INSERT INTO movie_genres (movie_id, genre_id) VALUES 
(1, 1), (1, 3), (1, 4), 
(2, 2),                 
(3, 1), (3, 3);         

-- Powiązania filmów z obsadą i ekipą
INSERT INTO movie_cast (movie_id, person_id, role, character_name) VALUES 
(1, 1, 'Reżyser', NULL),
(1, 2, 'Aktor', 'Dom Cobb'),
(2, 3, 'Reżyser', NULL),
(2, 4, 'Aktor', 'Andy Dufresne'),
(3, 5, 'Reżyser', NULL),
(3, 6, 'Aktor', 'Neo');


-- Sprawdzenie wyniku
SELECT 
    m.title AS Tytuł_Filmu,
    m.release_year AS Rok_Wydania,
    m.rating AS Ocena,
    GROUP_CONCAT(DISTINCT g.name) AS Gatunki,
    GROUP_CONCAT(DISTINCT p.first_name || ' ' || p.last_name || ' (' || mc.role || ')') AS Obsada_I_Twórcy
FROM movies m
LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
LEFT JOIN genres g ON mg.genre_id = g.genre_id
LEFT JOIN movie_cast mc ON m.movie_id = mc.movie_id
LEFT JOIN persons p ON mc.person_id = p.person_id
GROUP BY m.movie_id;

