SELECT pg_stat_statements_reset();

EXPLAIN ANALYZE 
SELECT * 
FROM airports 
WHERE type = 'small_airport' 
  AND iso_country = 'US' 
ORDER BY name DESC;
