SELECT *
FROM
(
    SELECT
      e.employee_id
    FROM
      Employees e
    FULL OUTER JOIN
      Salaries s ON e.employee_id = s.employee_id
    WHERE e.name IS NULL OR s.salary IS NULL
    UNION
    SELECT
      s.employee_id
    FROM
      Employees e
    FULL OUTER JOIN
      Salaries s ON e.employee_id = s.employee_id
    WHERE e.name IS NULL OR s.salary IS NULL
) AS Employee_Salaries
WHERE
  employee_id IS NOT NULL
ORDER BY
  employee_id ASC
