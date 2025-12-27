WITH order_cnt AS
   (
    SELECT COUNT(order_number) AS order_count, customer_number
    FROM Orders
    GROUP BY customer_number
   )
SELECT customer_number
FROM order_cnt
ORDER BY order_count DESC
LIMIT 1;