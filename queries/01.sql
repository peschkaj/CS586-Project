-- Highest budget movie by year by country
WITH expensive_movies AS (
  SELECT
    release_year,
    country_id,
    MAX(budget) AS max_budget
  FROM movies
  GROUP BY release_year, country_id
)
SELECT
  c.country_name,
  m.release_year,
  m.title,
  m.budget
FROM movies m
  JOIN expensive_movies em ON m.release_year = em.release_year
                          AND m.country_id = em.country_id
                          AND m.budget = em.max_budget
  JOIN countries c ON m.country_id = c.id
ORDER BY m.country_id, m.release_year DESC;
