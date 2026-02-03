SELECT
  id,
  SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL end) AS Jan_Revenue,
  SUM(CASE WHEN month = 'Feb' THEN revenue ELSE NULL end) AS Feb_Revenue,
  SUM(CASE WHEN month = 'Mar' THEN revenue ELSE NULL end) AS Mar_Revenue,
  SUM(CASE WHEN month = 'Apr' THEN revenue ELSE NULL end) AS Apr_Revenue,
  SUM(CASE WHEN month = 'May' THEN revenue ELSE NULL end) AS May_Revenue,
  SUM(CASE WHEN month = 'Jun' THEN revenue ELSE NULL end) AS Jun_Revenue,
  SUM(CASE WHEN month = 'Jul' THEN revenue ELSE NULL end) AS Jul_Revenue,
  SUM(CASE WHEN month = 'Aug' THEN revenue ELSE NULL end) AS Aug_Revenue,
  SUM(CASE WHEN month = 'Sep' THEN revenue ELSE NULL end) AS Sep_Revenue,
  SUM(CASE WHEN month = 'Oct' THEN revenue ELSE NULL end) AS Oct_Revenue,
  SUM(CASE WHEN month = 'Nov' THEN revenue ELSE NULL end) AS Nov_Revenue,
  SUM(CASE WHEN month = 'Dec' THEN revenue ELSE NULL end) AS Dec_Revenue
FROM
  Department
GROUP BY
  id
ORDER BY
  id