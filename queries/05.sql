-- Number of movies released by country
SELECT
  country_name,
  COUNT(*) AS moviews_released
FROM movies m
JOIN countries c ON m.country_id = c.id
GROUP BY c.country_name
ORDER BY c.country_name;
