-- Number of movies released per year
SELECT
  release_year,
  COUNT(*) AS movies_released
FROM movies
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year ASC ;
