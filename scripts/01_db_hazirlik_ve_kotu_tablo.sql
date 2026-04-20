CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

DROP TABLE IF EXISTS airports;

CREATE TABLE airports (
    id INT,
    ident VARCHAR(50),
    type VARCHAR(50),
    name VARCHAR(255),
    latitude_deg FLOAT,
    longitude_deg FLOAT,
    elevation_ft INT,
    continent VARCHAR(10),
    iso_country VARCHAR(10),
    iso_region VARCHAR(20),
    municipality VARCHAR(255),
    scheduled_service VARCHAR(10),
    icao_code VARCHAR(10),
    iata_code VARCHAR(10),
    gps_code VARCHAR(20),
    local_code VARCHAR(20),
    home_link TEXT,
    wikipedia_link TEXT,
    keywords TEXT
);

COPY airports 
FROM '/data/airports.csv' 
WITH (FORMAT csv, HEADER true, NULL '');

SELECT COUNT(*) FROM airports;
