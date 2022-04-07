/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
CREATE TABLE ANIMALS (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE UPDATE_ANIMALS
ADD species VARCHAR(40);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(30) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

ALTER TABLE UPDATE_ANIMALS DROP COLUMN id;  

ALTER TABLE UPDATE_ANIMALS ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE UPDATE_ANIMALS DROP COLUMN species;

ALTER TABLE UPDATE_ANIMALS ADD COLUMN species_id INT,
  ADD CONSTRAINT fk_species
  FOREIGN KEY (species_id)
  REFERENCES species (id);

ALTER TABLE UPDATE_ANIMALS ADD COLUMN owner_id INT,
  ADD CONSTRAINT fk_owners
  FOREIGN KEY (owner_id)
  REFERENCES owners (id);

  CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(65),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specialization(
  species_id INT NOT NULL,
  vets_id INT NOT NULL,
  CONSTRAINT species_fk FOREIGN KEY (species_id) REFERENCES species(id),
  CONSTRAINT vets_id FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits(
  animals_id INT NOT NULL,
  vets_id INT NOT NULL,
  date_of_visit DATE NOT NULL,
  CONSTRAINT animals_fk2 FOREIGN KEY (animals_id) REFERENCES animals(id),
  CONSTRAINT vets_fk2 FOREIGN KEY (vets_id) REFERENCES vets(id)
); 