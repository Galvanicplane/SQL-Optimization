EXPLAIN ANALYZE 
SELECT * 
FROM airports 
WHERE type = 'small_airport' 
  AND iso_country = 'US' 
ORDER BY name DESC;

CREATE INDEX idx_airports_type_country ON airports(type, iso_country);

EXPLAIN ANALYZE 
SELECT * 
FROM airports 
WHERE type = 'small_airport' 
  AND iso_country = 'US' 
ORDER BY name DESC;
