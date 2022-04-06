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