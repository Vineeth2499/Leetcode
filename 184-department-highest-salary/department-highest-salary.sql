WITH salary_rank_per_department AS (
    SELECT
          d.name AS Department,
          e.name AS Employee,
          e.salary,
          DENSE_RANK() OVER(PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
    FROM
          Employee e
    JOIN
          Department d ON e.departmentid = d.id)
SELECT
      Department,
      Employee,
      Salary
FROM
      salary_rank_per_department
WHERE
      salary_rank = 1;