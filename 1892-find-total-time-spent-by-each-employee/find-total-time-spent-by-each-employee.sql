WITH time_spent_by_employee AS(
  SELECT
    event_day,
    emp_id,
    (out_time - in_time) AS entry_time
  FROM
    Employees)
SELECT
  event_day AS day,
  emp_id,
  SUM(entry_time) AS total_time
FROM
  time_spent_by_employee
GROUP BY
  day,
  emp_id
ORDER BY
  emp_id ASC;