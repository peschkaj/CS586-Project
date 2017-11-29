-- Average IMDB score by country of origin by release year
SELECT
  c.country_name,
  m.release_year,
  AVG(review) AS average_review_score
FROM movies m
  JOIN countries c ON m.country_id = c.id
WHERE release_year IS NOT NULL
  AND m.review IS NOT NULL
GROUP BY c.country_name, m.release_year
ORDER BY country_name, release_year;
