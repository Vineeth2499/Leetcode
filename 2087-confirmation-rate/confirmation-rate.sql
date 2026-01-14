WITH avg_confirmations AS(
    SELECT
       user_id,
       ROUND(AVG(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END), 2) AS confirmation_rate
    FROM confirmations
    GROUP BY user_id
)
SELECT
   s.user_id,
   COALESCE(confirmation_rate, 0) AS confirmation_rate
FROM
   signups s
LEFT JOIN
   avg_confirmations a ON s.user_id = a.user_id