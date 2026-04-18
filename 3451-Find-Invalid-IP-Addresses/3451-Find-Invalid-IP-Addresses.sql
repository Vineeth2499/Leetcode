SELECT
  ip,
  CASE
    WHEN (LEFT(ip, 3) > 255) THEN ip ELSE ip END AS ip1
FROM
  logs
WHERE
  LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) != 2
