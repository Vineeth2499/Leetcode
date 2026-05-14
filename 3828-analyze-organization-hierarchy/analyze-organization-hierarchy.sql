WITH RECURSIVE hierarchy AS (
    SELECT
      employee_id,
      employee_name,
      manager_id,
      salary,
      1 AS level
    FROM
      Employees
    WHERE
      manager_id IS NULL
    
    UNION ALL

    SELECT
      e.employee_id,
      e.employee_name,
      e.manager_id,
      e.salary,
      h.level + 1
    FROM
      Employees e
    JOIN
      hierarchy h ON e.manager_id = h.employee_id
),

subordinate AS (
    SELECT
      h1.employee_id AS manager_id,
      h2.employee_id AS subordinate_id,
      h2.salary AS subordinate_salary
    FROM
      hierarchy h1
    JOIN
      hierarchy h2
    ON
      h2.level > h1.level
),
ancestor_map AS (
    SELECT
      manager_id AS ancestor_id,
      employee_id AS descendant_id,
      salary
    FROM
      Employees
    WHERE
      manager_id IS NOT NULL

    UNION ALL

    SELECT
      a.ancestor_id,
      e.employee_id AS descendant_id,
      e.salary
    FROM
      ancestor_map a
    JOIN
      Employees e ON e.manager_id = a.descendant_id
),

team_budget AS (
    SELECT
      ancestor_id AS employee_id,
      COUNT(*) AS team_size,
      SUM(salary) AS sub_salary_total
    FROM
      ancestor_map
    GROUP BY
      ancestor_id
)

SELECT
  h.employee_id,
  h.employee_name,
  h.level,
  COALESCE(tb.team_size, 0) AS team_size,
  h.salary + COALESCE(tb.sub_salary_total, 0) AS budget
FROM
  hierarchy h
LEFT JOIN
  team_budget tb ON h.employee_id = tb.employee_id
ORDER BY
  h.level ASC,
  budget DESC,
  h.employee_name ASC;