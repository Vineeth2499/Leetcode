WITH ranked_sessions AS (
    SELECT
      ss.session_id,
      ss.student_id,
      ss.subject,
      ss.session_date,
      ss.hours_studied,
      ROW_NUMBER() OVER (PARTITION BY ss.student_id ORDER BY ss.session_date) AS rn
    FROM
      study_sessions ss
),
gap AS (
    SELECT
      r1.student_id,
      r1.rn,
      DATEDIFF(r2.session_date, r1.session_date) AS day_gap
    FROM
      ranked_sessions r1
    JOIN
      ranked_sessions r2
    ON r1.student_id = r2.student_id
    AND r2.rn = r1.rn + 1
),
students_with_gaps AS (
    SELECT
      DISTINCT student_id
    FROM
      gap
    WHERE
      day_gap > 2
),
session_counts AS (
    SELECT
      student_id,
      COUNT(*) AS total_sessions
    FROM
      ranked_sessions
    GROUP BY
      student_id
),
cycle_candidates AS (
    SELECT
      r1.student_id,
      k.cycle_length,
      r1.rn,
      r1.subject AS subj1,
      r2.subject AS subj2
    FROM
      ranked_sessions r1
    CROSS JOIN (
        SELECT
          3 AS cycle_length
        UNION ALL
        SELECT
          4
        UNION ALL
        SELECT
          5
        UNION ALL
        SELECT
          6
        UNION ALL
        SELECT
          7
        UNION ALL
        SELECT
          8
        UNION ALL
        SELECT
          9
        UNION ALL
        SELECT
          10
    ) k
    JOIN ranked_sessions r2
    ON r1.student_id = r2.student_id
    AND r2.rn = r1.rn + k.cycle_length
),
cycle_validity AS (
    SELECT
      cc.student_id,
      cc.cycle_length,
      SUM(CASE WHEN cc.subj1 = cc.subj2 THEN 0 ELSE 1 END) AS mismatches,
      COUNT(*) AS pair_count
    FROM
      cycle_candidates cc
    WHERE
      cc.student_id NOT IN (SELECT student_id FROM students_with_gaps)
    GROUP BY
      cc.student_id,
      cc.cycle_length
),
valid_cycles AS (
    SELECT
      cv.student_id,
      cv.cycle_length
    FROM
      cycle_validity cv
    JOIN
      session_counts sc
    ON
      cv.student_id = sc.student_id
    WHERE
      cv.mismatches = 0
    AND
      sc.total_sessions >= cv.cycle_length * 2
),
best_cycle AS (
    SELECT
      student_id,
      MAX(cycle_length) AS cycle_length
    FROM
      valid_cycles
    GROUP BY
      student_id
),
cycle_hours AS (
    SELECT
      bc.student_id,
      bc.cycle_length,
      SUM(rs.hours_studied) AS total_study_hours
    FROM
      best_cycle bc
    JOIN
      ranked_sessions rs
    ON
      bc.student_id = rs.student_id
    AND
      rs.rn <= bc.cycle_length * 2
    GROUP BY
      bc.student_id,
      bc.cycle_length
)
SELECT
  ch.student_id,
  s.student_name,
  s.major,
  ch.cycle_length,
  ch.total_study_hours
FROM
  cycle_hours ch
JOIN
  students s ON ch.student_id = s.student_id
ORDER BY
  ch.cycle_length DESC,
  ch.total_study_hours DESC
