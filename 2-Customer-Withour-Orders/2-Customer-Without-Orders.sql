SELECT
  name
FROM
  Customers c
LEFT JOIN
  Orders o ON c.id = o.customer_id
WHERE
  o.id IS NULL
