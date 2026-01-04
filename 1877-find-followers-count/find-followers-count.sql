SELECT
    user_id,
    COALESCE(COUNT(follower_id), 0) AS followers_count
FROM
    Followers
GROUP BY
    user_id
ORDER BY
    user_id ASC;