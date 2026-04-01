WITH review_rank AS(
    SELECT
      employee_id,
      review_date,
      rating,
      ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn,
      COUNT(*) OVER (PARTITION BY employee_id) AS total_reviews
    FROM
      performance_reviews
),
top_three AS(
    SELECT
      employee_id,
      rating,
      rn
    FROM
      review_rank
    WHERE
      rn <= 3 AND total_reviews >= 3
),
categories AS(
    SELECT
      employee_id,
      MAX(CASE WHEN rn = 1 THEN rating END) AS latest,
      MAX(CASE WHEN rn = 2 THEN rating END) AS middle,
      MAX(CASE WHEN rn = 3 THEN rating END) AS earliest
    FROM
      top_three
    GROUP BY
      employee_id
)
SELECT
  e.employee_id,
  e.name,
  c.latest - c.earliest AS improvement_score
FROM
  employees e
JOIN
  categories c ON e.employee_id = c.employee_id
WHERE
  c.latest > c.middle AND c.middle > c.earliest
ORDER BY
  improvement_score DESC, e.name ASC;
