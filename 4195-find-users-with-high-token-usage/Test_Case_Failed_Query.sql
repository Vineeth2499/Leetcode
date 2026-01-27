WITH overall_avg AS(
    SELECT
      AVG(tokens) AS avg_tokens
    FROM
      prompts
),
qualified_user AS(
    SELECT
      DISTINCT(user_id)
    FROM
      prompts p
    JOIN overall_avg o
    ON p.tokens > o.avg_tokens
)
SELECT
  p.user_id,
  COUNT(p.prompt) AS prompt_count,
  ROUND(AVG(p.tokens), 2) AS avg_tokens
FROM
  prompts p
JOIN qualified_user u
ON p.user_id = u.user_id
GROUP BY
  p.user_id
HAVING
  COUNT(p.prompt) >= 3
ORDER BY
  avg_tokens DESC, user_id ASC
