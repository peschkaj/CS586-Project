-- Highest budget movie by year
WITH expensive_movies AS (
  SELECT
    release_year,
    MAX(budget) AS max_budget
  FROM movies
  GROUP BY release_year, country_id
)
SELECT DISTINCT
  m.release_year,
  m.title,
  m.budget
FROM movies m
  JOIN expensive_movies em ON m.release_year = em.release_year
                          AND m.budget = em.max_budget
ORDER BY m.release_year DESC;
