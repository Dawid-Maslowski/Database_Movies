BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "genres" (
	"genre_id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("genre_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "movie_cast" (
	"movie_id"	INTEGER,
	"person_id"	INTEGER,
	"role"	TEXT NOT NULL,
	"character_name"	TEXT,
	PRIMARY KEY("movie_id","person_id","role"),
	FOREIGN KEY("movie_id") REFERENCES "movies"("movie_id") ON DELETE CASCADE,
	FOREIGN KEY("person_id") REFERENCES "persons"("person_id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "movie_genres" (
	"movie_id"	INTEGER,
	"genre_id"	INTEGER,
	PRIMARY KEY("movie_id","genre_id"),
	FOREIGN KEY("genre_id") REFERENCES "genres"("genre_id") ON DELETE CASCADE,
	FOREIGN KEY("movie_id") REFERENCES "movies"("movie_id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "movies" (
	"movie_id"	INTEGER,
	"title"	TEXT NOT NULL,
	"release_year"	INTEGER CHECK("release_year" > 1800),
	"duration_minutes"	INTEGER CHECK("duration_minutes" > 0),
	"rating"	REAL CHECK("rating" >= 0 AND "rating" <= 10),
	PRIMARY KEY("movie_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "persons" (
	"person_id"	INTEGER,
	"first_name"	TEXT NOT NULL,
	"last_name"	TEXT NOT NULL,
	"birth_date"	TEXT,
	PRIMARY KEY("person_id" AUTOINCREMENT)
);
INSERT INTO "genres" VALUES (1,'Sci-Fi');
INSERT INTO "genres" VALUES (2,'Dramat');
INSERT INTO "genres" VALUES (3,'Akcja');
INSERT INTO "genres" VALUES (4,'Kryminał');
INSERT INTO "movie_cast" VALUES (1,1,'Reżyser',NULL);
INSERT INTO "movie_cast" VALUES (1,2,'Aktor','Dom Cobb');
INSERT INTO "movie_cast" VALUES (2,3,'Reżyser',NULL);
INSERT INTO "movie_cast" VALUES (2,4,'Aktor','Andy Dufresne');
INSERT INTO "movie_cast" VALUES (3,5,'Reżyser',NULL);
INSERT INTO "movie_cast" VALUES (3,6,'Aktor','Neo');
INSERT INTO "movie_genres" VALUES (1,1);
INSERT INTO "movie_genres" VALUES (1,3);
INSERT INTO "movie_genres" VALUES (1,4);
INSERT INTO "movie_genres" VALUES (2,2);
INSERT INTO "movie_genres" VALUES (3,1);
INSERT INTO "movie_genres" VALUES (3,3);
INSERT INTO "movies" VALUES (1,'Incepcja',2010,148,8.8);
INSERT INTO "movies" VALUES (2,'Skazani na Shawshank',1994,142,9.3);
INSERT INTO "movies" VALUES (3,'Matrix',1999,136,8.7);
INSERT INTO "persons" VALUES (1,'Christopher','Nolan','1970-07-30');
INSERT INTO "persons" VALUES (2,'Leonardo','DiCaprio','1974-11-11');
INSERT INTO "persons" VALUES (3,'Frank','Darabont','1959-01-28');
INSERT INTO "persons" VALUES (4,'Tim','Robbins','1958-10-16');
INSERT INTO "persons" VALUES (5,'Lana','Wachowski','1965-06-21');
INSERT INTO "persons" VALUES (6,'Keanu','Reeves','1964-09-02');
COMMIT;
