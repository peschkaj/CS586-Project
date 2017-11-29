-- Most common movie rating by country of origin and release year
WITH q AS (
  SELECT
    c.country_name,
    m.release_year,
    r.rating,
    ROW_NUMBER() OVER(PARTITION BY c.country_name, m.release_year ORDER BY COUNT(*) DESC) AS rn,
    COUNT(*) number_of_movies
  FROM movies m
    JOIN ratings r ON m.rating_id = r.id
    JOIN countries c ON m.country_id = c.id
  GROUP BY c.country_name, m.release_year, r.rating
)
SELECT
  country_name,
  release_year,
  rating,
  number_of_movies
FROM q
WHERE rn = 1
ORDER BY number_of_movies DESC ;
