WITH customer_stats AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_orders,
        SUM(
            CASE 
                WHEN EXTRACT(HOUR FROM order_timestamp) BETWEEN 11 AND 13
                  OR EXTRACT(HOUR FROM order_timestamp) BETWEEN 18 AND 20
                THEN 1 ELSE 0
            END
        ) AS peak_orders,
        COUNT(order_rating) AS rated_orders,
        ROUND(AVG(order_rating)::numeric, 2) AS avg_rating
    FROM restaurant_orders
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_orders,
    ROUND((peak_orders * 100.0) / total_orders, 0) AS peak_hour_percentage,
    avg_rating AS average_rating
FROM customer_stats
WHERE 
    total_orders >= 3
    AND (peak_orders * 1.0 / total_orders) >= 0.6
    AND (rated_orders * 1.0 / total_orders) >= 0.5
    AND avg_rating >= 4.0
ORDER BY average_rating DESC, customer_id DESC