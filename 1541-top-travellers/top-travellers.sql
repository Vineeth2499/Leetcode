SELECT
   DISTINCT(name),
   ISNULL(SUM(distance) OVER (PARTITION BY user_id), 0) AS travelled_distance
FROM
   Rides r
RIGHT JOIN
   Users u ON r.user_id = u.id
ORDER BY
   travelled_distance DESC, name;