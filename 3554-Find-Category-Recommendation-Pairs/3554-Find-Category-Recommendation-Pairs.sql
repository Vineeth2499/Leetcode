WITH Categories AS (
    SELECT
      DISTINCT p.user_id,
      i.category
    FROM
      ProductPurchases p
    JOIN
      ProductInfo i ON p.product_id = i.product_id
),
CategoryPairs AS (
    SELECT
      c1.user_id,
      c1.category AS category1,
      c2.category AS category2
    FROM
      Categories c1
    JOIN
      Categories c2 ON c1.user_id = c2.user_id
    AND
      c1.category < c2.category
)
SELECT
  category1,
  category2,
  COUNT(*) AS customer_count
FROM
  CategoryPairs
GROUP BY
  category1,
  category2
HAVING
  COUNT(*) >= 3
ORDER BY
  customer_count DESC,
  category1 ASC,
  category2 ASC
