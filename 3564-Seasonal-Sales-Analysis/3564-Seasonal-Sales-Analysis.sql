WITH seasonal_sales AS(
    SELECT
      CASE
        WHEN EXTRACT('Month' FROM sale_date) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT('Month' FROM sale_date) IN(3, 4, 5) THEN 'Spring'
        WHEN EXTRACT('Month' FROM sale_date) IN(6, 7, 8) THEN 'Summer'
        WHEN EXTRACT('Month' FROM sale_date) IN (9, 10, 11) THEN 'Fall' END AS season,
        p.category,
        SUM(quantity) AS total_quantity,
        SUM(quantity*price) AS total_revenue
    FROM
      Sales s
    JOIN
      Products p ON s.product_id = p.product_id
    GROUP BY
      season, p.category
),
ranked AS(
    SELECT
      season,
      category,
      total_quantity,
      total_revenue,
      RANK() OVER (PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC, category ASC) AS rnk
    FROM
      seasonal_sales
)
SELECT
  season,
  category,
  total_quantity,
  total_revenue
FROM
  ranked
WHERE
  rnk = 1
ORDER BY
  season ASC
