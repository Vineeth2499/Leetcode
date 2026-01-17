SELECT
   u.user_id AS buyer_id,
   u.join_date,
   COALESCE(COUNT(o.order_id), 0) AS orders_in_2019
FROM
   Users u
LEFT JOIN
   Orders o ON o.buyer_id = u.user_id
AND
   o.order_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY
   u.user_id,
   u.join_date
ORDER BY
   buyer_id ASC
