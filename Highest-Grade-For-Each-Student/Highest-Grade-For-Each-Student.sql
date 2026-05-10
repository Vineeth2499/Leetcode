WITH ranked_score AS(
  SELECT
    student_id,
    exam_id,
    score,
    RANK() OVER (PARTITION BY student_id ORDER BY score DESC, exam_id ASC) AS score_rank
  FROM
    exam_results
)
SELECT
  student_id,
  exam_id,
  score 
FROM
  ranked_score
WHERE
  score_rank = 1
