-- Movies released by country by year
SELECT
  release_year,
  country_name,
COUNT(*)
FROM movies m
  JOIN countries c ON m.country_id = c.id
GROUP BY country_name, release_year
ORDER BY country_name, release_year;
