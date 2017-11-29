-- Number of movies filmed in each country
SELECT
l.country_name,
COUNT(*) AS movie_count
FROM movies m
JOIN movie_locations ml ON m.id = ml.movie_id
JOIN locations l ON ml.location_id = l.id
GROUP BY l.country_name
ORDER BY COUNT(*) DESC;
