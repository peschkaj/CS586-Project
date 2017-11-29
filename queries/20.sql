-- Total budget expenditure by genre
SELECT
  genre_name,
  CAST(SUM(budget) AS DECIMAL(25,2)) AS total_budget_dollars,
  CAST(AVG(budget) AS DECIMAL(25,2)) AS average_movie_budget,
  COUNT(*) AS number_of_movies
FROM movies m
  JOIN movie_genres mg ON m.id = mg.movie_id
  JOIN genres g ON mg.genre_id = g.id
WHERE g.genre_name != 'Horror'
  AND budget IS NOT NULL
GROUP BY g.genre_name
ORDER BY SUM(budget) DESC
