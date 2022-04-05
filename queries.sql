/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM ANIMALS WHERE name LIKE '%mon';
SELECT name FROM ANIMALS WHERE date_of_birth BETWEEN '01-01-2016' AND '01-12-2019';
SELECT name FROM ANIMALS WHERE neutered='true' AND escape_attempts < 3;
SELECT date_of_birth FROM ANIMALS WHERE name='Agumon' OR name='Pickachu';
SELECT name,escape_attempts FROM ANIMALS WHERE weight_Kg > 10.5;
SELECT * FROM ANIMALS WHERE neutered='true';
SELECT * FROM ANIMALS WHERE NOT name='Gabumon';
SELECT * FROM ANIMALS WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
