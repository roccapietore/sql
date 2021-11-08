create table id (
id INTEGER PRIMARY KEY AUTOINCREMENT,
animal_id VARCHAR (50))

INSERT INTO id (animal_id) SELECT DISTINCT (animal_id) FROM animals

create table colors (
id INTEGER PRIMARY KEY AUTOINCREMENT,
color VARCHAR (50))

INSERT INTO colors (color) SELECT DISTINCT TRIM("color") FROM (
   SELECT a1.color1 "color" FROM animals a1
   UNION
   SELECT a2.color2 "color" FROM animals a2
) t WHERE t.color IS NOT NULL;


create table animal_colors (
color_id INT,
animal_id INT);

INSERT INTO animal_colors
SELECT colors.id color_id, id.id animal_id FROM colors
JOIN animals a1 ON colors.color = trim(a1.color1)
JOIN id ON id.animal_id = a1.animal_id
UNION
SELECT colors.id color_id, id.id animal_id FROM colors
JOIN animals a2 ON colors.color = trim(a2.color2)
JOIN id ON id.animal_id = a2.animal_id
;


create table animals_types (
id INTEGER PRIMARY KEY AUTOINCREMENT,
types VARCHAR (50))

INSERT INTO animals_types (types) SELECT DISTINCT (animal_type) FROM animals

create table animals_breeds (
id INTEGER PRIMARY KEY AUTOINCREMENT,
breeds VARCHAR (50))

INSERT INTO animals_breeds (breeds) SELECT DISTINCT (breed) FROM animals

create table outcome_info (
id INTEGER PRIMARY KEY AUTOINCREMENT,
animal_id VARCHAR (50),
outcome_subtype VARCHAR (50),
outcome_type VARCHAR (50),
outcome_month INT,
outcome_year INT
)

INSERT INTO outcome_info ( animal_id,
outcome_subtype,
outcome_type,
outcome_month,
outcome_year)
SELECT
animal_id,
outcome_subtype,
outcome_type,
outcome_month,
outcome_year FROM animals

create table results (
"index" INT,
age_upon_outcome VARCHAR (50),
animal_id VARCHAR (50),
name VARCHAR (50),
date_of_birth DATE,
animal_type INT,
breed VARCHAR (50),
color1 INT,
color2 INT
)

INSERT INTO results
SELECT "index", age_upon_outcome, animals.animal_id, name, DATE(date_of_birth),animals_types.id animals_types, animals_breeds.id breed, c1.id color1, c2.id color2  FROM animals
LEFT JOIN animals_types ON animals.animal_type = animals_types.types
LEFT JOIN animals_breeds ON animals.breed = animals_breeds.breeds
LEFT JOIN colors c1 ON animals.color1 = c1.color
LEFT JOIN colors c2 ON animals.color2 = c2.color

