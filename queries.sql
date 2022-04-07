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

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM ANIMALS GROUP BY species;
SELECT species, AVG(escape_attempts) FROM ANIMALS WHERE date_of_birth >= '01-01-1990' AND date_of_birth < '12-31-2000' GROUP BY species;

-- What ANIMALS belong to Melody Pond?
SELECT A.name, O.full_name as owner FROM ANIMALS A join owners O on  A.owner_id = O.id WHERE O.full_name = 'Melody Pond';

-- List of all ANIMALS that are pokemon (their type is Pokemon).
SELECT A.name, S.name  as species FROM ANIMALS A join species S  on A.species_id = S.id WHERE S.name = 'Pokemon' ;

-- List all owners and their ANIMALS, remember to include those that don't own any animal.
SELECT O.full_name as owner_name, A.name as animal_name FROM owners O left join ANIMALS A on O.id= A.owner_id;

-- How many ANIMALS are there per species?
SELECT count(*), S.name FROM ANIMALS A join species S on A.species_id = S.id group by S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name as animal_name, S.name as species_name, O.full_name as owner_name
FROM ANIMALS A join species S on A.species_id = S.id join owners O on A.owner_id = O.id
WHERE S.name = 'Digimon' and O.full_name = 'Jennifer Orwell';

-- List all ANIMALS owned by Dean Winchester that haven't tried to escape.
SELECT A.name as animal_name, A.escape_attempts, O.full_name as owner_name
FROM ANIMALS A join owners O on A.owner_id = O.id
WHERE A.escape_attempts = 0 and O.full_name = 'Dean Winchester';

-- Who owns the most ANIMALS?
SELECT count(*) as number_of_animals, O.full_name
FROM ANIMALS A join owners O on A.owner_id = O.id
group by O.full_name
order by count(*) desc
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name FROM ANIMALS AS a INNER JOIN visits AS j ON j.animals_id = a.id INNER JOIN vets AS v ON j.vets_id = v.id WHERE j.vets_id =1 AND j.date_of_visit = (SELECT MAX(date_of_visit) FROM visits WHERE vets_id = 1);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(j.animals_id) FROM visits AS j LEFT JOIN vets AS v ON v.id = j.vets_id WHERE v.id = 3;

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.name FROM vets AS v FULL JOIN specialization AS j ON j.vets_id = v.id FULL JOIN species AS s ON s.id = j.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name FROM ANIMALS AS a INNER JOIN visits AS j On j.animals_id = a.id INNER JOIN vets AS v ON v.id = j.vets_id WHERE j.vets_id = 3 AND j.date_of_visit BETWEEN '04-01-2020' AND '08-30-2020';

-- What animal has the most visits to vets
SELECT COUNT(j.animals_id) AS number_of_visits, a.name FROM visits AS j FULL JOIN ANIMALS AS a ON a.id = j.animals_id GROUP BY a.name;

-- Who was Maisy Smith's first visit?
SELECT a.name, a.id FROM ANIMALS AS a INNER JOIN visits AS j ON j.animals_id = a.id INNER JOIN vets AS v ON j.vets_id = v.id WHERE j.vets_id =2 AND j.date_of_visit = (SELECT MIN(date_of_visit) FROM visits WHERE vets_id = 2);

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, a.date_of_birth AS pet_dob, a.escape_attempts AS escapeAttempts, a.weight_kg AS weight, a.neutered AS neutered, v.name AS vet_name, v.age AS vet_age, v.date_of_graduation AS vets_graduation_date, j.date_of_visit AS vet_visit_date FROM visits AS j FULL JOIN animals AS a ON a.id = j.animals_id FULL JOIN vets AS v ON v.id = j.vets_id ORDER BY vet_visit_date DESC;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(j.animals_id) FROM visits AS j INNER JOIN vets AS v ON v.id = j.vets_id WHERE v.id NOT IN (SELECT vets_id FROM specialization);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(a.species_id) AS sv, s.name FROM ANIMALS AS a JOIN species AS s ON s.id = a.species_id INNER JOIN visits AS j ON j.animals_id = a.id INNER JOIN vets AS v ON v.id = j.vets_id WHERE v.id = 3 GROUP BY s.name ORDER by sv DESC LIMIT 1;
