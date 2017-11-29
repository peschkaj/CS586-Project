-- number of movies made per genre (excluding horror)
SELECT
  g.genre_name,
  COUNT(*)
FROM movies m
  JOIN movie_genres AS mg ON m.id = mg.movie_id
  JOIN genres g ON mg.genre_id = g.id
WHERE g.genre_name != 'Horror'
GROUP BY g.genre_name
ORDER BY COUNT(*) DESC
