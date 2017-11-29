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
  JOIN expensive_movies em ON m.release_year = em.release_year  AND m.budget = em.max_budget
ORDER BY m.release_year DESC;



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
  JOIN expensive_movies em ON m.country_id = em.country_id AND m.budget = em.max_budget
  JOIN countries c ON m.country_id = c.id
ORDER BY c.country_name DESC ;



-- Number of movies released per year
SELECT
  release_year,
  COUNT(*) AS movies_released
FROM movies
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year ASC ;



-- Number of movies released by country
SELECT
  country_name,
  COUNT(*) AS moviews_released
FROM movies m
JOIN countries c ON m.country_id = c.id
GROUP BY c.country_name
ORDER BY c.country_name;



-- Movies released by country by year
SELECT
  release_year,
  country_name,
  COUNT(*)
FROM movies m
JOIN countries c ON m.country_id = c.id
GROUP BY country_name, release_year
ORDER BY country_name, release_year;




-- Number of movies filmed in each country
SELECT
  l.country_name,
  COUNT(*) AS movie_count
FROM movies m
  JOIN movie_locations ml ON m.id = ml.movie_id
  JOIN locations l ON ml.location_id = l.id
GROUP BY l.country_name
ORDER BY COUNT(*) DESC;



-- Number of movies filmed in specific locations
SELECT
  l.country_name,
  l.location_name,
  COUNT(*) AS movie_count
FROM movies m
  JOIN movie_locations ml ON m.id = ml.movie_id
  JOIN locations l ON ml.location_id = l.id
WHERE l.location_name IS NOT NULL
GROUP BY l.country_name, l.location_name
ORDER BY COUNT(*) DESC;



-- Locations where only one movie was filmed
SELECT
  l.country_name,
  l.location_name,
  COUNT(*) AS movie_count
FROM movies m
  JOIN movie_locations ml ON m.id = ml.movie_id
  JOIN locations l ON ml.location_id = l.id
WHERE l.location_name IS NOT NULL
GROUP BY l.country_name, l.location_name
HAVING COUNT(*) = 1;



-- Movies filmed in each country by year
SELECT
  m.release_year,
  l.country_name,
  COUNT(*) AS movie_count
FROM movies m
  JOIN movie_locations ml ON m.id = ml.movie_id
  JOIN locations l ON ml.location_id = l.id
GROUP BY m.release_year, l.country_name
ORDER BY m.release_year, l.country_name DESC;



-- Average IMDB score by release date
SELECT
  release_year,
  AVG(review) AS average_review_score
FROM movies m
WHERE release_year IS NOT NULL
  AND m.review IS NOT NULL
GROUP BY release_year
ORDER BY release_year DESC;



-- Average IMDB score by country of origin
SELECT
  c.country_name,
  AVG(review) AS average_review_score
FROM movies m
  JOIN countries c ON m.country_id = c.id
WHERE m.review IS NOT NULL
GROUP BY c.country_name
ORDER BY average_review_score DESC;



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



-- Average IMDB score by runtime
SELECT
  m.runtime,
  AVG(review) AS average_review_score
FROM movies m
WHERE m.runtime IS NOT NULL
  AND m.review IS NOT NULL
GROUP BY m.runtime
ORDER BY average_review_score DESC ;



-- Most common movie rating by country of origin
WITH q AS (
    SELECT
      c.country_name,
      r.rating,
      ROW_NUMBER() OVER(PARTITION BY c.country_name ORDER BY COUNT(*) DESC) AS rn,
      COUNT(*) number_of_movies
    FROM movies m
      JOIN ratings r ON m.rating_id = r.id
      JOIN countries c ON m.country_id = c.id
    GROUP BY c.country_name, r.rating )
SELECT
  country_name,
  rating,
  number_of_movies
FROM q
WHERE rn = 1
ORDER BY number_of_movies DESC ;



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
    GROUP BY c.country_name, m.release_year, r.rating )
SELECT
  country_name,
  release_year,
  rating,
  number_of_movies
FROM q
WHERE rn = 1
ORDER BY number_of_movies DESC ;



-- Most common movie rating by year
WITH q AS (
    SELECT
      m.release_year,
      r.rating,
      ROW_NUMBER() OVER(PARTITION BY m.release_year ORDER BY COUNT(*) DESC) AS rn,
      COUNT(*) number_of_movies
    FROM movies m
      JOIN ratings r ON m.rating_id = r.id
    GROUP BY m.release_year, r.rating )
SELECT
  release_year,
  rating,
  number_of_movies
FROM q
WHERE rn = 1
ORDER BY release_year DESC ;



-- number of movies made per genre (excluding horror)
SELECT
  m.release_year,
  g.genre_name,
  COUNT(*)
FROM movies m
JOIN movie_genres AS mg ON m.id = mg.movie_id
JOIN genres g ON mg.genre_id = g.id
WHERE g.genre_name != 'Horror'
GROUP BY m.release_year, g.genre_name
ORDER BY COUNT(*) DESC



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
