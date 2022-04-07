/* Populate database with sample data. */

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(1, 'Agumon', '3-FEB-2020', 0, true, 10.23);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(2, 'Gabumon', '15-NOV-2018', 2, true, 8);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(3, 'Pikachu', '7-JAN-2021', 1, false, 15.04);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(4, 'Devimon', '12-MAY-2017', 5, true, 11);


INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(5, 'Charmander', '8-FEB-2020', 0, false, -11.0);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(6, 'Plantmon', '15-NOV-2021', 2, true, -5.7);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(7, 'Squirtle', '2-APR-1993', 3, false, -12.13);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(8, 'Angemon', '12-JUN-2005', 1, true, -45.0);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(9, 'Boarmon', '7-JUN-2005', 7, true, 20.4);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(10, 'Blossom', '13-OCT-1998', 3, true, 17);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES(11, 'Blossom', '14-MAY-2022', 4, true, 22);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);


INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE ANIMALS SET species_id = 2 WHERE name LIKE '%mon';
UPDATE ANIMALS SET species_id = 1;

UPDATE ANIMALS SET owner_id = 1 WHERE name = 'Agumon';
UPDATE ANIMALS SET owner_id = 2 WHERE name  IN ('Pikachu','Gabumon');
UPDATE ANIMALS SET owner_id = 3 WHERE name IN ('Devimon','Plantmon');
UPDATE ANIMALS SET owner_id = 4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE ANIMALS SET owner_id = 5 WHERE name IN ('Angemon','Boarmon');

UPDATE owners SET full_name = 'Melody Pond' WHERE id = 4;