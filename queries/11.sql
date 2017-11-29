-- Average IMDB score by release date
SELECT
  release_year,
  AVG(review) AS average_review_score
FROM movies m
WHERE release_year IS NOT NULL
  AND m.review IS NOT NULL
GROUP BY release_year
ORDER BY release_year DESC;
