-- Most common movie rating by year
WITH q AS (
  SELECT
    m.release_year,
    r.rating,
    ROW_NUMBER() OVER(PARTITION BY m.release_year ORDER BY COUNT(*) DESC) AS rn,
    COUNT(*) number_of_movies
  FROM movies m
    JOIN ratings r ON m.rating_id = r.id
  GROUP BY m.release_year, r.rating
)
SELECT
  release_year,
  rating,
  number_of_movies
FROM q
WHERE rn = 1
ORDER BY release_year DESC ;
