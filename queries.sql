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
-- Return 9
SELECT COUNT(*) FROM ANIMALS WHERE neutered = false;
-- Return 3
SELECT COUNT(*) FROM ANIMALS WHERE escape_attempts = 0;
-- Return 2
SELECT AVG(weight_kg) FROM ANIMALS;
-- Return 16.6488888888888889
SELECT neutered,SUM(escape_attempts) AS TOTAL_ESCAPE FROM ANIMALS GROUP BY neutered;;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '01-01-1990' AND date_of_birth < '12-31-2000' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT A.name, O.full_name as owner FROM animals A join owners O on  A.owner_id = O.id WHERE O.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name, S.name  as species FROM animals A join species S  on A.species_id = S.id WHERE S.name = 'Pokemon' ;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT O.full_name as owner_name, A.name as animal_name FROM owners O left join animals A on O.id= A.owner_id;

-- How many animals are there per species?
SELECT count(*), S.name FROM animals A join species S on A.species_id = S.id group by S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name as animal_name, S.name as species_name, O.full_name as owner_name
FROM animals A join species S on A.species_id = S.id join owners O on A.owner_id = O.id
WHERE S.name = 'Digimon' and O.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name as animal_name, A.escape_attempts, O.full_name as owner_name
FROM animals A join owners O on A.owner_id = O.id
WHERE A.escape_attempts = 0 and O.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT count(*) as number_of_animals, O.full_name
FROM animals A join owners O on A.owner_id = O.id
group by O.full_name
order by count(*) desc
LIMIT 1;

SELECT count(distinct A.id) as number_of_animals
FROM animals A join visits V on A.id = V.animals_id
WHERE V.vets_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT V.id, V.name, V.age, V.date_of_graduation, s.name as specialization
FROM vets V left join specializations SP on V.id = SP.vets_id 
left join species S on SP.species_id = S.id;

SELECT A.id, A.name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg 
FROM animals A join visits V on A.id = V.animals_id
WHERE V.vets_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez') 
and V.date_of_visits between '2020-4-1' and '2020-8-30';

SELECT A.id, A.name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, count(*) as visits_number
FROM animals A join visits V on A.id = V.animals_id
group by A.id
order by count(*) desc
limit 1;

SELECT A.id, A.name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg 
FROM animals A join visits V on A.id = V.animals_id
WHERE V.vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
order by date_of_visits
limit 1;

SELECT A.name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, 
V.name, V.age, V.date_of_graduation, VI.date_of_visits 
FROM animals A join visits VI on A.id = VI.animals_id 
join vets V on VI.vets_id = V.id
order by VI.date_of_visits desc
limit 1;
