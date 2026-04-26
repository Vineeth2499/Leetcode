WITH store_product_count AS (
    SELECT
      store_id
    FROM
      inventory
    GROUP BY
      store_id
    HAVING
      COUNT(DISTINCT product_name) >= 3
),
max_min_price AS (
    SELECT
      i.store_id,
      MAX(i.price) AS max_price,
      MIN(i.price) AS min_price
    FROM
      inventory i
    JOIN
      store_product_count spc ON i.store_id = spc.store_id
    GROUP BY
      i.store_id
),
expensive AS (
    SELECT
      DISTINCT ON (i.store_id)
      i.store_id,
      i.product_name AS most_exp_product,
      i.quantity AS most_exp_quantity
    FROM
      inventory i
    JOIN
      max_min_price m ON i.store_id = m.store_id AND i.price = m.max_price
),
cheapest AS (
    SELECT
      DISTINCT ON (i.store_id)
      i.store_id,
      i.product_name AS cheapest_product,
      i.quantity AS cheapest_quantity
    FROM
      inventory i
    JOIN
      max_min_price m ON i.store_id = m.store_id AND i.price = m.min_price
)
SELECT
  s.store_id,
  s.store_name,
  s.location,
  e.most_exp_product,
  c.cheapest_product,
  ROUND(c.cheapest_quantity::DECIMAL/e.most_exp_quantity, 2) AS imbalance_ratio
FROM
  stores s
JOIN
  expensive e
ON
  s.store_id = e.store_id
JOIN
  cheapest c
ON
  s.store_id = c.store_id
WHERE
  c.cheapest_quantity > e.most_exp_quantity
ORDER BY
  imbalance_ratio DESC,
  s.store_name ASC
