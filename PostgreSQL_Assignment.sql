-- Active: 1748166067512@@127.0.0.1@5432@database_assignment


-- rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) ,
    region VARCHAR(50)
);
INSERT INTO rangers (name, region) VALUES
('John Doe', 'North'),
('Jane Smith', 'Hills' ),
('Alice Johnson', 'East'),
('Bob Brown', 'West'),
('Charlie White', 'Mountain' ),
('Carol King','Noakhali'),
('White Green','Barishal')


-- species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);
INSERT INTO species(common_name,scientific_name,discovery_date,conservation_status) VALUES
('African Elephant', 'Loxodonta africana', '2000-01-01', 'Vulnerable'),
('Bengal Tiger', 'Panthera tigris tigris', '1795-05-15', 'Endangered'),
('Giant Panda', 'Ailuropoda melanoleuca', '1970-03-20', 'Vulnerable'),
('Snow Leopard', 'Panthera uncia', '1990-07-10', 'Endangered'),
('Blue Whale', 'Balaenoptera musculus', '1775-11-25', 'Endangered');

-- sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL,
    species_id INT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(50) NOT NULL,
    notes TEXT,

    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (species_id) REFERENCES species(species_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO sightings ( ranger_id, species_id, sighting_time, location, notes) VALUES
( 1, 1, TO_TIMESTAMP('2025-05-10 06:45 AM', 'YYYY-MM-DD HH:MI AM'), 'River Bend', 'Seen near water, alone'),
( 2, 1, TO_TIMESTAMP('2025-05-11 03:15 PM', 'YYYY-MM-DD HH:MI AM'), 'Pass Tree Grove', 'Heard distinctive call'),
( 1, 3, TO_TIMESTAMP('2025-05-12 07:30 AM', 'YYYY-MM-DD HH:MI AM'), 'Misty Pass     ', 'Small group seen hopping'),
( 3, 4, TO_TIMESTAMP('2025-05-13 02:00 PM', 'YYYY-MM-DD HH:MI AM'), 'Red Rock Ridge', 'Rare sighting after rainfall'),
( 4, 1, TO_TIMESTAMP('2025-05-14 06:00 AM', 'YYYY-MM-DD HH:MI AM'), 'Northern Trail', 'Possibly same individual as before'),
( 5, 3, TO_TIMESTAMP('2025-05-14 06:00 PM', 'YYYY-MM-DD HH:MI AM'), 'Snowfall Pass  ', 'Multiple individuals spotted');



--question-1
INSERT INTO rangers (name,region) VALUES
('Derek Fox','Coastal Plains');

--question-2
SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings;

--question-3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

--question-4
SELECT rangers.name AS name, COUNT(sightings.sighting_id) AS total_sightings FROM rangers 
LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id GROUP BY rangers.name;

--question-5
select species.common_name FROM species 
WHERE species_id NOT IN (
    SELECT species_id FROM sightings
);

--question-6

SELECT species.common_name , sightings.sighting_time,rangers.name FROM sightings 
JOIN species ON sightings.species_id = species.species_id
join rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC LIMIT 2;

--question-7
UPDATE species SET conservation_status = 'Historic' WHERE EXTRACT(YEAR FROM discovery_date)  < 1800;
SELECT * from species;

--question-8
SELECT sighting_id,
    CASE 
        WHEN EXTRACT (HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT (HOUR FROM sighting_time) BETWEEN 12 and 17 THEN 'Afternoon'
        Else 'Evening'
    End 
AS time_of_day FROM sightings;

--question-9
DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);



SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

DROP TABLE rangers;
DROP Table sightings ;
DROP TABLE species;