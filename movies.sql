/*
Create a Movie Database
Written on: December 5, 2024
*/

DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
USE movies;

CREATE TABLE genre (
	GenreID INT,
    GenreName VARCHAR(30),
    CONSTRAINT PK_genre PRIMARY KEY (GenreID)
);

CREATE TABLE director (
	DirectorID INT,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    BirthDate DATETIME,
    CONSTRAINT PK_director PRIMARY KEY (DirectorID)
);

CREATE TABLE rating (
	RatingID INT,
    RatingName VARCHAR(5),
    CONSTRAINT PK_rating PRIMARY KEY (RatingID)
);

CREATE TABLE movie (
	MovieID INT,
    GenreID INT,
    DirectorID INT,
    RatingID INT,
    Title VARCHAR(128),
    ReleaseDate DATETIME,
    CONSTRAINT PK_movie PRIMARY KEY (MovieID),
    CONSTRAINT FOREIGN KEY FK_genreid (GenreID)
		REFERENCES Genre (GenreID),
	CONSTRAINT FOREIGN KEY FK_directorid (DirectorID)
		REFERENCES director (DirectorID),
	CONSTRAINT FOREIGN KEY FK_ratingid (RatingID)
		REFERENCES rating (RatingID)
);

CREATE TABLE actor (
	ActorID INT,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    BirthDate DATETIME,
    CONSTRAINT PK_actor PRIMARY KEY (ActorID)
);

CREATE TABLE castmembers (
	CastMemberID INT,
    ActorID INT,
    MovieID INT,
    Role VARCHAR(50),
    CONSTRAINT PK_castmembers PRIMARY KEY (CastMemberID),
    CONSTRAINT FOREIGN KEY FK_actor (ActorID)
		REFERENCES actor (ActorID),
	CONSTRAINT FOREIGN KEY FK_movie (MovieID)
		REFERENCES movie (MovieID)
);