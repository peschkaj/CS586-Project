-- Number of movies filmed in specific locations
SELECT
  l.country_name,
  l.location_name,
  COUNT(*) AS movie_count
FROM movies m
  JOIN movie_locations ml ON m.id = ml.movie_id
  JOIN locations l ON ml.location_id = l.id
WHERE l.location_name IS NOT NULL
GROUP BY l.country_name, l.location_name
ORDER BY COUNT(*) DESC;
