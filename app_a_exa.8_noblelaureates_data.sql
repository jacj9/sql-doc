/*
Exercise A.8: Nobel Laureates
Written on: January 15, 2025
*/

DROP DATABASE IF EXISTS noblelaureates;

CREATE DATABASE noblelaureates;

USE noblelaureates;

CREATE TABLE laureates (
	Id INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Born DATE,
    Died DATE,
    BornCountry VARCHAR(25),
    BornCountryCode CHAR(2),
    BornCity VARCHAR(25),
    DiedCountry VARCHAR(25),
    DiedCountryCode CHAR(2),
    DiedCity VARCHAR(25),
    Gender CHAR(10),
    Prizes VARCHAR(100),
    PRIMARY KEY (Id)
);
