SELECT
  DISTINCT p1.product_id,
  COALESCE(p2.new_price, 10) AS price
FROM
  products p1
LEFT JOIN
  (SELECT
     product_id,
     new_price,
     RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS product_rank
   FROM
     products
   WHERE
     change_date <= '2019-08-16') p2
ON p1.product_id = p2.product_id
AND product_rank = 1
