WITH reaction_counts AS (
    SELECT
      user_id,
      reaction,
      COUNT(*) AS reaction_cnt
    FROM
      reactions
    GROUP BY
      user_id,
      reaction
),
user_totals AS (
    SELECT
      user_id,
      SUM(reaction_cnt) AS total_cnt
    FROM
      reaction_counts
    GROUP BY
      user_id
),
dominant_reaction AS (
    SELECT
      rc.user_id,
      rc.reaction,
      rc.reaction_cnt,
      u.total_cnt,
      RANK() OVER (PARTITION BY rc.user_id ORDER BY rc.reaction_cnt DESC) AS rnk
    FROM
      reaction_counts rc
    JOIN
      user_totals u ON rc.user_id = u.user_id
)
SELECT
  user_id,
  reaction AS dominant_reaction,
  ROUND(reaction_cnt/total_cnt, 2) AS reaction_ratio
FROM
  dominant_reaction
WHERE
  rnk = 1 AND total_cnt >= 5 AND ROUND(reaction_cnt/total_cnt, 2) >= 0.60
ORDER BY
  reaction_ratio DESC,
  user_id ASC
