WITH last_event AS (
    SELECT
      *
    FROM
      subscription_events
    WHERE event_id IN(
        SELECT 
          event_id
        FROM
          subscription_events s1
        WHERE
          event_date = (
            SELECT
              MAX(event_date)
            FROM
              subscription_events s2
            WHERE
              s2.user_id = s1.user_id
          )
          AND event_id = (
            SELECT
              MAX(event_id)
            FROM
              subscription_events s3
            WHERE
              s3.user_id = s1.user_id
            AND
              s3.event_date = (
                SELECT
                  MAX(event_date)
                FROM
                  subscription_events s4
                WHERE
                  s4.user_id = s1.user_id
              )
          )
    )
),
user_stats AS(
    SELECT
      user_id,
      MAX(monthly_amount) AS max_historical_amount,
      SUM(CASE WHEN event_type = 'downgrade' THEN 1 ELSE 0 END) AS downgrade_count,
      DATEDIFF(CURRENT_DATE, MIN(event_date)) AS days_as_subscriber
    FROM
      subscription_events
    GROUP BY
      user_id
)
SELECT
  le.user_id,
  le.plan_name AS current_plan,
  le.monthly_amount AS current_monthly_amount,
  us.max_historical_amount,
  us.days_as_subscriber
FROM
  last_event le
JOIN
  user_stats us ON le.user_id = us.user_id
WHERE
  le.event_type <> 'cancel'
  AND us.downgrade_count >= 1
  AND le.monthly_amount < 0.5 * us.max_historical_amount
  AND us.days_as_subscriber >= 60
ORDER BY
  us.days_as_subscriber DESC,
  le.user_id ASC;
