WITH weekly_meeting AS(
    SELECT
      e.employee_id,
      employee_name,
      department,
      YEAR(meeting_date) AS year_no,
      WEEKOFYEAR(meeting_date) AS week_no,
      SUM(duration_hours) AS total_duration
    FROM
      employees e
    JOIN
      meetings m ON e.employee_id = m.employee_id
    GROUP BY
      e.employee_id,
      employee_name,
      department,
      year_no,
      week_no
    HAVING
      total_duration > 20
)
SELECT
  employee_id,
  employee_name,
  department,
  COUNT(DISTINCT year_no, week_no) AS meeting_heavy_weeks
FROM
  weekly_meeting
GROUP BY
  employee_id,
  employee_name,
  department
HAVING
  COUNT(DISTINCT year_no, week_no) >= 2
ORDER BY
  meeting_heavy_weeks DESC, employee_name ASC
