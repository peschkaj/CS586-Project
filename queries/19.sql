-- number of movies made per genre per year (excluding horror)
SELECT
  m.release_year,
  g.genre_name,
  COUNT(*)
FROM movies m
  JOIN movie_genres AS mg ON m.id = mg.movie_id
  JOIN genres g ON mg.genre_id = g.id
WHERE g.genre_name != 'Horror'
GROUP BY m.release_year, g.genre_name
ORDER BY COUNT(*) DESC
