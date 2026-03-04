First Approach


SELECT
  title AS results
FROM
  (SELECT
    m.title,
    AVG(rating) AS average_rating
  FROM
    Movies m
  JOIN
    MovieRating r ON m.movie_id = r.movie_id
  JOIN
    Users u ON r.user_id = u.user_id
  WHERE
    EXTRACT(MONTH FROM created_at) = '02'
  GROUP BY
    m.title
  ORDER BY
    average_rating DESC, m.title ASC
  LIMIT
    1
) t1
UNION
SELECT
  name
FROM
  (
  SELECT
    u.name,
    COUNT(rating) AS rating_count  
  FROM
    Movies m
  JOIN
    MovieRating r ON m.movie_id = r.movie_id
  JOIN
    Users u ON r.user_id = u.user_id
  GROUP BY
    u.name
  ORDER BY
    rating_count DESC, name ASC
  LIMIT
    1
) t2
