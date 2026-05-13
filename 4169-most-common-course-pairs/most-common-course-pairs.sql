WITH top_performer AS (
    SELECT
      user_id
    FROM
      course_completions
    GROUP BY
      user_id
    HAVING COUNT(*) >= 5 AND AVG(course_rating) >= 4
),
ranked_course AS (
    SELECT
      cc.user_id,
      cc.course_name,
      ROW_NUMBER() OVER (PARTITION BY cc.user_id ORDER BY cc.completion_date) AS rn
    FROM
      course_completions cc
    INNER JOIN
      top_performer tp ON cc.user_id = tp.user_id
),
consecutive_pairs AS (
    SELECT
      rc.course_name AS first_course,
      rc2.course_name AS second_course
    FROM
      ranked_course rc
    INNER JOIN
      ranked_course rc2 ON rc.user_id = rc2.user_id
    AND
      rc2.rn = rc.rn + 1
)
SELECT
  first_course,
  second_course,
  COUNT(*) AS transition_count
FROM
  consecutive_pairs
GROUP BY
  first_course,
  second_course
ORDER BY
  transition_count DESC,
  first_course ASC,
  second_course ASC;