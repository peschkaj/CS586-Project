-- Highest budget movie by year by country
WITH expensive_movies AS (
  SELECT
    country_id,
    MAX(budget) AS max_budget
  FROM movies
  GROUP BY country_id
)
SELECT DISTINCT
  c.country_name,
  m.title,
  m.budget
FROM movies m
  JOIN expensive_movies em ON m.country_id = em.country_id
                          AND m.budget = em.max_budget
  JOIN countries c ON m.country_id = c.id
ORDER BY c.country_name DESC ;
