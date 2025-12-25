SELECT contest_id,
       ROUND(COUNT(user_id)*100.00/(SELECT COUNT(user_id) FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY Percentage DESC, contest_id;