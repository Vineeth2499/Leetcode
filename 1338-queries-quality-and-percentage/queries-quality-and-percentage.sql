SELECT
  DISTINCT(query_name),
  ROUND(AVG(rating * 1.0 / position) OVER (PARTITION BY query_name), 2) AS quality,
  ROUND(
    COUNT(CASE WHEN rating < 3 THEN 1 END) OVER (PARTITION BY query_name)
    * 100.0/ COUNT(*) OVER (PARTITION BY query_name),
    2
) AS poor_query_percentage
FROM
  Queries
ORDER BY
  query_name DESC;