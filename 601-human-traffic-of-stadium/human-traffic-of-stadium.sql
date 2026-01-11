WITH people_count AS(
    SELECT
       *,
       id - ROW_NUMBER() OVER (ORDER BY id) AS rw_num
    FROM
       Stadium
    WHERE
       people >= 100
)
SELECT
   id,
   visit_date,
   people
FROM
   people_count
WHERE
   rw_num IN (
    SELECT
       rw_num
    FROM
       people_count
    GROUP BY
       rw_num
    HAVING
       COUNT(id) >= 3
   )