WITH ranked AS (
    SELECT
        student_id,
        subject,
        score,
        exam_date,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date) AS rn1,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS rn2
    FROM Scores
)
SELECT
    student_id,
    subject,
    MAX(CASE WHEN rn1 = 1 THEN score END) AS first_score,
    MAX(CASE WHEN rn2 = 1 THEN score END) AS latest_score
FROM ranked
GROUP BY
  student_id,
  subject
HAVING
    COUNT(*) >= 2
    AND MAX(CASE WHEN rn2 = 1 THEN score END) > MAX(CASE WHEN rn1 = 1 THEN score END)
ORDER BY
  student_id,
  subject;
