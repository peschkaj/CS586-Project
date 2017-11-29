-- Average IMDB score by runtime
SELECT
  m.runtime,
  AVG(review) AS average_review_score
FROM movies m
WHERE m.runtime IS NOT NULL
  AND m.review IS NOT NULL
GROUP BY m.runtime
ORDER BY average_review_score DESC ;
