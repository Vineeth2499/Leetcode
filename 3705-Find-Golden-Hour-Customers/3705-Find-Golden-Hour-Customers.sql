WITH order_details AS(
    SELECT
      order_id,
      customer_id,
      CASE
        WHEN order_rating IS NULL THEN 0 ELSE order_rating
      END AS order_rating,
      CASE
        WHEN EXTRACT(HOUR FROM order_timestamp) BETWEEN 11 AND 14 THEN 'early_peak'
        WHEN EXTRACT(HOUR FROM order_timestamp) BETWEEN 18 AND 21 THEN 'late_peak'
      END AS peak_hours
    FROM
      restaurant_orders
)
SELECT
  customer_id,
  COUNT(order_id) AS total_orders,
  ROUND(COUNT(peak_hours) * 1.0 / COUNT(order_id), 2) AS peak_hour_percentage,
    AVG(order_rating) AS average_rating
FROM
  order_details
GROUP BY
  customer_id

-------------------------------------------

SELECT
  customer_id,
  COUNT(order_id) AS total_orders,
  ROUND(
      SUM(
          CASE 
              WHEN order_timestamp BETWEEN '11:00:00' AND '14:00:00'
                OR order_timestamp BETWEEN '18:00:00' AND '21:00:00'
              THEN 1 
              ELSE 0 
          END
      ) * 100.0 / COUNT(order_id),
  2) AS peak_hour_percentage
FROM restaurant_orders
GROUP BY customer_id;
