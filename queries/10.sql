-- Movies filmed in each country by year
SELECT
  m.release_year,
  l.country_name,
  COUNT(*) AS movie_count
FROM movies m
  JOIN movie_locations ml ON m.id = ml.movie_id
  JOIN locations l ON ml.location_id = l.id
GROUP BY m.release_year, l.country_name
ORDER BY m.release_year, l.country_name DESC;
