-- Average IMDB score by country of origin
SELECT
  c.country_name,
  AVG(review) AS average_review_score
FROM movies m
  JOIN countries c ON m.country_id = c.id
WHERE m.review IS NOT NULL
GROUP BY c.country_name
ORDER BY average_review_score DESC;
