/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM ANIMALS WHERE name LIKE '%mon';
SELECT name FROM ANIMALS WHERE date_of_birth BETWEEN '01-01-2016' AND '01-12-2019';
SELECT name FROM ANIMALS WHERE neutered='true' AND escape_attempts < 3;
SELECT date_of_birth FROM ANIMALS WHERE name='Agumon' OR name='Pickachu';
SELECT name,escape_attempts FROM ANIMALS WHERE weight_Kg > 10.5;
SELECT * FROM ANIMALS WHERE neutered='true';
SELECT * FROM ANIMALS WHERE NOT name='Gabumon';
SELECT * FROM ANIMALS WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE ANIMALS SET species = 'unspecified';
SELECT * FROM ANIMALS; 
ROLLBACK;
SELECT * FROM ANIMALS; 

BEGIN;
UPDATE ANIMALS SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE ANIMALS SET species = 'pokemon' WHERE species is NULL;
select * from ANIMALS;
COMMIT;
select * from ANIMALS;

BEGIN;
DELETE FROM ANIMALS;
select * from ANIMALS;
ROLLBACK;
select * from ANIMALS;

BEGIN;
DELETE FROM ANIMALS WHERE date_of_birth > '2022-1-1';
SAVEPOINT delete_one;
UPDATE ANIMALS SET weight_kg = -1 * weight_kg;
ROLLBACK TO delete_one;
UPDATE ANIMALS SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
select * from ANIMALS;
COMMIT;
select * from ANIMALS;

SELECT COUNT(*) FROM ANIMALS;
-- 9
SELECT COUNT(*) FROM ANIMALS WHERE neutered = false;
-- 3
SELECT COUNT(*) FROM ANIMALS WHERE escape_attempts = 0;
-- 2
SELECT AVG(weight_kg) FROM ANIMALS;
-- 16.6488888888888889
SELECT neutered,SUM(escape_attempts) AS TOTAL_ESCAPE FROM ANIMALS GROUP BY neutered;;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '01-01-1990' AND date_of_birth < '12-31-2000' GROUP BY species;